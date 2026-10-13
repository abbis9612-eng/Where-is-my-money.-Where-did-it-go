library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/money.dart';
import '../../data/repository.dart';
import '../../data/snapshot.dart';
import '../../domain/banknotes.dart';
import '../../domain/dialect_parser.dart';
import '../../platform/voice.dart';
import '../../state/providers.dart';
import '../theme/theme.dart';
import '../widgets/banknote.dart';
import '../widgets/common.dart';
import '../widgets/guilloche.dart';
import '../widgets/odometer.dart';

/// "صرفت": keypad, a sentence the way people talk, or the voice.
class AddSheet extends ConsumerStatefulWidget {
  const AddSheet({super.key, this.startWithVoice = false, this.initialText});
  final bool startWithVoice;
  final String? initialText;

  @override
  ConsumerState<AddSheet> createState() => _AddSheetState();
}

enum _Pay { cash, card }

class _AddSheetState extends ConsumerState<AddSheet> {
  final _text = TextEditingController();
  var _digits = '';
  var _currency = Currency.iqd;
  String? _category;
  String? _memberId;
  var _pay = _Pay.cash;
  var _items = <ParsedItem>[];
  var _listening = false;
  var _heard = '';
  var _usedVoice = false;

  static const _examples = ['صمون 2 وخضرة 5', 'بنزين 25 ومولدة 75', 'دفعت ورقة للطبيب', 'عشرين ألف مطعم'];

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null) {
      _text.text = widget.initialText!;
      _items = parseExpenseText(_text.text).items;
    }
    _text.addListener(() => setState(() => _items = parseExpenseText(_text.text).items));
    if (widget.startWithVoice) WidgetsBinding.instance.addPostFrameCallback((_) => _startVoice());
  }

  @override
  void dispose() {
    _text.dispose();
    if (_listening) VoiceInput.instance.stop();
    super.dispose();
  }

  bool get _textMode => _text.text.trim().isNotEmpty;

  int _usdRate(Snapshot s) => s.household.usdRate;

  int get _typedMinor {
    final n = int.tryParse(_digits) ?? 0;
    return _currency == Currency.usd ? n * 100 : n;
  }

  int _base(Snapshot s) => toBaseIqd(_typedMinor, _currency, _usdRate(s));

  String _suggestedCategory(Snapshot s) {
    final h = s.now.hour;
    if (h >= 6 && h < 11) return 'bread_veg';
    if (s.quickPicks.isNotEmpty) return s.quickPicks.first.categoryKey;
    return 'groceries';
  }

  String? _walletFor(Snapshot s, Currency c, String memberId) {
    if (c == Currency.usd) {
      for (final w in s.wallets) {
        if (w.wallet.currency == 'USD') return w.wallet.id;
      }
    }
    if (_pay == _Pay.card) return s.walletOfKind('qi_card')?.id;
    return s.walletOfKind('cash', ownerId: memberId)?.id ?? s.walletOfKind('cash')?.id;
  }

  Future<void> _startVoice() async {
    final mic = await Permission.microphone.request();
    if (!mic.isGranted) {
      if (mounted) Toaster.show(context, 'نحتاج إذن المايكروفون حتى نسمعكم. تگدرون تفعّلوه من إعدادات الموبايل.');
      return;
    }
    final ok = await VoiceInput.instance.ensureReady();
    if (!ok) {
      if (mounted) Toaster.show(context, 'التعرف على الصوت مو متوفر بهالموبايل. اكتبوها بجملة بدالها.');
      return;
    }
    setState(() {
      _listening = true;
      _heard = '';
    });
    await VoiceInput.instance.listen(onText: (text, done) {
      if (!mounted) return;
      setState(() => _heard = text);
      if (done) {
        HapticFeedback.mediumImpact();
        setState(() {
          _listening = false;
          _usedVoice = true;
          _text.text = text;
        });
      }
    });
  }

  Future<void> _stopVoice() async {
    await VoiceInput.instance.stop();
    if (!mounted) return;
    setState(() {
      _listening = false;
      if (_heard.isNotEmpty) {
        _usedVoice = true;
        _text.text = _heard;
      }
    });
  }

  Future<void> _save(Snapshot s) async {
    final repo = ref.read(repositoryProvider);
    final memberHint = parseExpenseText(_text.text).memberHint;
    var member = _memberId ?? s.me.id;
    if (_textMode && memberHint != null) {
      final role = memberHint == 'mum' ? 'member' : 'owner';
      member = s.adults.where((m) => m.role == role).map((m) => m.id).firstOrNull ?? member;
    }
    final List<ExpenseDraft> drafts;
    if (_textMode) {
      drafts = [
        for (final i in _items)
          ExpenseDraft(
            label: i.label,
            categoryKey: i.categoryKey,
            amountMinor: i.amountMinor,
            currency: i.currency,
            walletId: _walletFor(s, i.currency, member),
            memberId: member,
            source: _usedVoice ? 'voice' : 'text',
          ),
      ];
    } else {
      final key = _category ?? 'other';
      drafts = [
        ExpenseDraft(
          label: s.categoryName(key),
          categoryKey: key,
          amountMinor: _typedMinor,
          currency: _currency,
          walletId: _walletFor(s, _currency, member),
          memberId: member,
        ),
      ];
    }
    if (drafts.isEmpty) return;
    final nav = Navigator.of(context);
    final ids = await repo.addExpenses(drafts);
    if (!mounted) return;
    final msg = drafts.length > 1
        ? 'انسجلت ${drafts.length} صرفات بجملة وحدة'
        : 'انسجلت: ${drafts.first.label} ${formatMoney(drafts.first.amountMinor, drafts.first.currency)}';
    final toastContext = nav.context;
    nav.pop();
    if (!toastContext.mounted) return;
    Toaster.show(toastContext, msg, onUndo: () => repo.softDelete(ids));
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider).value;
    if (snap == null) return const SizedBox.shrink();
    final wf = Wf.of(context);
    final left = snap.week.left;
    final total = _textMode ? _items.fold(0, (a, i) => a + toBaseIqd(i.amountMinor, i.currency, _usdRate(snap))) : _base(snap);
    final after = left - total;
    _memberId ??= snap.me.id;

    String cta;
    if (total <= 0) {
      cta = _textMode ? 'اكتبوا الشي والمبلغ' : 'اكتبوا المبلغ';
    } else {
      final head = _textMode && _items.length > 1 ? 'سجّلوا ${_items.length} صرفات' : 'سجّلوها';
      cta = after >= 0 ? '$head · يبقى ${formatAmount(after)}' : '$head · تعدّيتوا بـ ${formatAmount(-after)}';
    }

    return Stack(children: [
      Column(children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 8, 6),
          child: Row(children: [
            Text('صرفت', style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            IconButton(tooltip: 'سكّر', onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'اكتبوا مثل ما تحچون: صمون 2 وخضرة 5',
              suffixIcon: Padding(
                padding: const EdgeInsets.all(6),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: wf.tint, borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.auto_awesome_outlined, color: wf.tintInk, size: 20),
                ),
              ),
            ),
          ),
        ),
        if (!_textMode)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              children: [
                for (final e in _examples)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: wf.mute,
                        side: BorderSide(color: wf.faint),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        minimumSize: const Size(0, 30),
                        textStyle: const TextStyle(fontSize: 12, fontFamily: WfText.ui),
                      ),
                      onPressed: () => _text.text = e,
                      child: Text(e),
                    ),
                  ),
              ],
            ),
          ),
        Expanded(child: _textMode ? _parsedList(snap) : _keypadMode(snap, after)),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 16 + MediaQuery.of(context).viewPadding.bottom),
          child: Row(children: [
            Semantics(
              button: true,
              label: 'سجّلوا بالصوت',
              child: Material(
                color: wf.surface,
                shape: CircleBorder(side: BorderSide(color: wf.line)),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _startVoice,
                  child: SizedBox.square(dimension: 56, child: Icon(Icons.mic_none, color: wf.ink)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: PrimaryButton(label: cta, danger: total > 0 && after < 0, onPressed: total > 0 ? () => _save(snap) : null)),
          ]),
        ),
      ]),
      if (_listening) Positioned.fill(top: 60, child: _VoicePanel(heard: _heard, onStop: _stopVoice)),
    ]);
  }

  Widget _keypadMode(Snapshot snap, int after) {
    final wf = Wf.of(context);
    final n = int.tryParse(_digits) ?? 0;
    final base = _base(snap);
    final suggested = _suggestedCategory(snap);
    final cats = snap.categories.where((c) => c.kind == 'expense' && !c.isFixed && c.key != 'small').toList()
      ..sort((a, b) => (a.key == suggested ? 0 : 1).compareTo(b.key == suggested ? 0 : 1));
    final diff = diffNotes(snap.week.left, after < 0 ? 0 : after);
    return ListView(padding: EdgeInsets.zero, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Odometer(value: n, prefix: _currency == Currency.usd ? r'$' : '', style: WfText.money(54, color: n == 0 ? wf.faint : wf.ink)),
          const Spacer(),
          Segmented<Currency>(
            values: Currency.values,
            selected: _currency,
            label: (c) => c == Currency.iqd ? 'دينار' : 'دولار',
            onChanged: (c) => setState(() {
              _currency = c;
              _digits = '';
            }),
          ),
        ]),
      ),
      if (_currency == Currency.usd && n > 0)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('= ${formatAmount(base)} دينار، بسعر اليوم ${formatAmount(snap.household.usdRate)}', style: TextStyle(color: wf.mute, fontSize: 13)),
        ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: SizedBox(
          height: 34,
          child: base <= 0
              ? Text('أو اكتبوا المبلغ، وشوفوا شنو يطلع من الرزمة', style: TextStyle(fontSize: 12, color: wf.mute))
              : after < 0
                  ? Text('تطلع الرزمة كلها، ويبقى عليكم ${formatAmount(-after)}', style: TextStyle(fontSize: 12, color: wf.alert))
                  : SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
                      Text('تطلع', style: TextStyle(fontSize: 12, color: wf.mute)),
                      for (final d in diff.removed.take(4)) Padding(padding: const EdgeInsetsDirectional.only(start: 6), child: MiniNote(d)),
                      if (diff.added.isNotEmpty) ...[
                        const SizedBox(width: 12),
                        Text('ويرجع', style: TextStyle(fontSize: 12, color: wf.mute)),
                        for (final d in diff.added.take(3)) Padding(padding: const EdgeInsetsDirectional.only(start: 6), child: MiniNote(d)),
                      ],
                    ])),
        ),
      ),
      SizedBox(
        height: 52,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
          children: [
            for (final c in cats)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: WfChip(
                  label: c.name,
                  selected: _category == c.key,
                  tag: c.key == suggested ? 'عادةً هسه' : null,
                  onTap: () => setState(() => _category = c.key),
                ),
              ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Row(children: [
          for (final m in snap.adults)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 6),
              child: GestureDetector(
                onTap: () => setState(() => _memberId = m.id),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _memberId == m.id ? wf.ink : Colors.transparent, width: 2)),
                  child: MemberAvatar(m, size: 34, dim: _memberId != m.id),
                ),
              ),
            ),
          const Spacer(),
          Segmented<_Pay>(
            values: _Pay.values,
            selected: _pay,
            label: (p) => p == _Pay.cash ? 'كاش' : 'كي كارد',
            onChanged: (p) => setState(() => _pay = p),
          ),
        ]),
      ),
      const SizedBox(height: 8),
      Keypad(onKey: (k) => setState(() => _digits = applyKey(_digits, k, maxLength: _currency == Currency.usd ? 5 : 8))),
    ]);
  }

  Widget _parsedList(Snapshot snap) {
    final wf = Wf.of(context);
    return ListView(padding: const EdgeInsets.fromLTRB(16, 12, 16, 0), children: [
      for (final i in _items)
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: wf.surface, borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            MiniNote(denominationFor(toBaseIqd(i.amountMinor, i.currency, snap.household.usdRate)), width: 46, showLabel: false),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(i.label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.4)),
                Text('${snap.categoryName(i.categoryKey)}${i.fromSlang ? ' · ورقة = 100 دولار' : ''}', style: TextStyle(fontSize: 12, color: wf.mute, height: 1.4)),
              ]),
            ),
            Text(formatMoney(i.amountMinor, i.currency), style: WfText.money(17, weight: FontWeight.w500, color: wf.ink)),
          ]),
        ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Text(
          _items.isEmpty
              ? 'اكتبوا الشي والمبلغ، مثلاً: بنزين 25'
              : 'فهمت ${_items.length} ${_items.length == 1 ? 'صرفة' : 'صرفات'}. إذا شي غلط، صحّحوا الجملة.',
          style: TextStyle(fontSize: 12, color: wf.mute),
        ),
      ),
    ]);
  }
}

class _VoicePanel extends StatelessWidget {
  const _VoicePanel({required this.heard, required this.onStop});
  final String heard;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: Container(
        color: Wf.vaultGreen,
        child: Stack(alignment: Alignment.center, children: [
          const Positioned(bottom: -160, child: Rosette(size: 520)),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const _Bars(),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(heard.isEmpty ? 'گولوا شنو صرفتوا…' : heard,
                  textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300, height: 1.7)),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text('تگدرون تگولون أكثر من صرفة: «صمون ألفين وخضرة خمسة آلاف»',
                  textAlign: TextAlign.center, style: TextStyle(color: Wf.vaultMuted, fontSize: 12)),
            ),
            const SizedBox(height: 30),
            Semantics(
              button: true,
              label: 'وقّف التسجيل',
              child: GestureDetector(
                onTap: onStop,
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.stop_rounded, color: Wf.vaultGreen, size: 34),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

class _Bars extends StatefulWidget {
  const _Bars();
  @override
  State<_Bars> createState() => _BarsState();
}

class _BarsState extends State<_Bars> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const delays = [0.0, .1, .25, .05, .3, .15, .2];
    return AnimatedBuilder(
      animation: _c,
      builder: (_, _) => Row(mainAxisSize: MainAxisSize.min, children: [
        for (final d in delays)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.5),
            width: 5,
            height: 10 + 42 * (1 - (((_c.value + d) % 1) * 2 - 1).abs()),
            decoration: BoxDecoration(color: Wf.vaultMint, borderRadius: BorderRadius.circular(3)),
          ),
      ]),
    );
  }
}
