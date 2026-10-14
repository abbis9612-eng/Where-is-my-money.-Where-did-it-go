library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../data/snapshot.dart';
import '../../domain/barakah.dart';
import '../../domain/zakat.dart';
import '../../state/providers.dart';
import '../theme/theme.dart';
import '../widgets/barakah_card.dart';
import '../widgets/common.dart';

/// Charity given since a date (from the envelope and logged as spending).
final _givenProvider = FutureProvider.family<int, DateTime>((ref, from) {
  ref.watch(snapshotProvider);
  return ref.watch(repositoryProvider).sadaqaGivenSince(from);
});

/// «الصدقة والزكاة»: the charity envelope, a zakat calculator, zakat
/// al-fitr, and every text with its source.
class GivingScreen extends ConsumerWidget {
  const GivingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snap = ref.watch(snapshotProvider).value;
    if (snap == null) return const Scaffold(body: SizedBox.shrink());
    final wf = Wf.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('الصدقة والزكاة')),
      body: ListView(padding: EdgeInsets.only(bottom: 32 + MediaQuery.of(context).viewPadding.bottom), children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text('صدقة صغيرة دايمة من كل راتب، وحساب الزكاة لما يكمل الحول، وزكاة الفطر بآخر رمضان.',
              style: TextStyle(color: wf.mute, fontSize: 14, height: 1.7)),
        ),
        const SectionTitle('ظرف الصدقة'),
        _SadaqaCard(snap: snap),
        const BarakahCard(place: BarakahPlace.sadaqa),
        const SectionTitle('زكاة المال', padding: EdgeInsets.fromLTRB(20, 28, 20, 8)),
        _ZakatCalculator(snap: snap),
        const BarakahCard(place: BarakahPlace.zakat),
        const SectionTitle('زكاة الفطر', padding: EdgeInsets.fromLTRB(20, 28, 20, 8)),
        _FitrCard(snap: snap),
        const SectionTitle('كل النصوص بمصادرها', padding: EdgeInsets.fromLTRB(20, 28, 20, 8)),
        const _Library(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Text(
            'الحساب هنا على أقوال معروفة لأهل العلم، والاختيارات اللي بيها خلاف مكتوبة قدامكم. '
            'لحالتكم بالضبط اسألوا أهل العلم. النصوص منقولة بمصادرها، والتطبيق ما يفتي.',
            style: TextStyle(color: wf.mute, fontSize: 12, height: 1.7),
          ),
        ),
      ]),
    );
  }
}

// ------------------------------------------------------------------ sadaqa

class _SadaqaCard extends ConsumerWidget {
  const _SadaqaCard({required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final env = snap.sadaqa;
    if (env == null) {
      return WfCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text('ما عندكم ظرف صدقة بعد', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.5)),
          Text('مبلغ صغير ينعزل من كل راتب لحاله، وتصرفونه صدقة وقت ما تحتاجون. القليل الدايم أحسن من الكثير المنقطع.',
              style: TextStyle(fontSize: 13, color: wf.mute, height: 1.7)),
          const SizedBox(height: 12),
          PrimaryButton(label: 'سوّوا ظرف الصدقة', onPressed: () => _pickMonthly(context, ref, null)),
        ]),
      );
    }
    final month = DateTime(snap.now.year, snap.now.month);
    final given = ref.watch(_givenProvider(month)).value ?? 0;
    return WfCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('بالظرف هسه', style: TextStyle(fontSize: 13, color: wf.mute)),
              Text(inThousands(env.balance), style: WfText.money(28, color: wf.ink, height: 1.3)),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('أعطيتوا هالشهر', style: TextStyle(fontSize: 13, color: wf.mute)),
            Text(inThousands(given), style: WfText.money(18, weight: FontWeight.w600, color: wf.ok, height: 1.4)),
          ]),
        ]),
        const SizedBox(height: 4),
        Text('كل راتب ينحط بيه ${inThousands(env.envelope.monthlyMinor)} لحاله', style: TextStyle(fontSize: 13, color: wf.mute, height: 1.6)),
        const SizedBox(height: 12),
        PrimaryButton(label: 'سجّلوا صدقة أعطيتوها', onPressed: () => showWfSheet(context, (_) => _GiveSheet(envelopeId: env.envelope.id, balance: env.balance), heightFactor: .8)),
        TextButton(onPressed: () => _pickMonthly(context, ref, env), child: const Text('غيّروا المبلغ الشهري')),
      ]),
    );
  }

  Future<void> _pickMonthly(BuildContext context, WidgetRef ref, EnvelopeView? env) async {
    final v = await showDialog<int>(
      context: context,
      builder: (c) => SimpleDialog(
        title: const Text('كم تنعزل للصدقة من كل راتب؟'),
        children: [
          for (final a in [5000, 10000, 25000, 50000, 100000])
            SimpleDialogOption(onPressed: () => Navigator.pop(c, a), child: Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Text(inThousands(a), style: const TextStyle(fontSize: 16)))),
        ],
      ),
    );
    if (v == null) return;
    final repo = ref.read(repositoryProvider);
    if (env == null) {
      await repo.addSadaqaEnvelope(v);
    } else {
      await repo.setEnvelopeMonthly(env.envelope.id, v);
    }
    if (context.mounted) Toaster.show(context, 'من الراتب الجاي ينعزل ${inThousands(v)} للصدقة');
  }
}

class _GiveSheet extends ConsumerStatefulWidget {
  const _GiveSheet({required this.envelopeId, required this.balance});
  final String envelopeId;
  final int balance;
  @override
  ConsumerState<_GiveSheet> createState() => _GiveSheetState();
}

class _GiveSheetState extends ConsumerState<_GiveSheet> {
  var _digits = '';
  final _label = TextEditingController();

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final amount = int.tryParse(_digits) ?? 0;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('صدقة أعطيتوها', style: Theme.of(context).textTheme.titleLarge),
          Text('تنسحب من ظرف الصدقة (بيه ${inThousands(widget.balance)})، وما تنحسب من مصروف الأسبوع.', style: TextStyle(fontSize: 13, color: wf.mute, height: 1.6)),
          const SizedBox(height: 8),
          Center(child: Text(amount == 0 ? '0' : formatAmount(amount), style: WfText.money(44, color: wf.ink))),
          TextField(controller: _label, decoration: const InputDecoration(labelText: 'لمن؟ (اختياري، يبقى عندكم بس)')),
        ]),
      ),
      const Spacer(),
      Keypad(onKey: (k) => setState(() => _digits = applyKey(_digits, k))),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 12 + MediaQuery.of(context).viewPadding.bottom),
        child: PrimaryButton(
          label: 'سجّلوها',
          onPressed: amount <= 0
              ? null
              : () async {
                  HapticFeedback.mediumImpact();
                  await ref.read(repositoryProvider).giveSadaqa(widget.envelopeId, amount, label: _label.text.trim().isEmpty ? 'صدقة' : _label.text.trim());
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  Toaster.show(context, 'تقبّل الله. انسجلت ${inThousands(amount)}');
                },
        ),
      ),
    ]);
  }
}

// ------------------------------------------------------------------- zakat

class _ZakatCalculator extends ConsumerStatefulWidget {
  const _ZakatCalculator({required this.snap});
  final Snapshot snap;
  @override
  ConsumerState<_ZakatCalculator> createState() => _ZakatCalculatorState();
}

class _ZakatCalculatorState extends ConsumerState<_ZakatCalculator> {
  final _c = <String, TextEditingController>{
    for (final k in ['cash', 'g24', 'g21', 'g18', 'silver', 'gPrice', 'sPrice', 'recv', 'pay']) k: TextEditingController(),
  };
  var _basis = NisabBasis.gold;
  var _deduct = false;
  DateTime? _start;
  var _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repo = ref.read(repositoryProvider);
    final saved = await repo.getValue('zakat_inputs');
    final start = await repo.getValue('zakat_start');
    final s = widget.snap;
    final rate = s.household.usdRate;
    var held = 0;
    for (final w in s.wallets) {
      held += w.wallet.currency == 'USD' ? toBaseIqd(w.balance, Currency.usd, rate) : w.balance;
    }
    for (final e in s.envelopes) {
      held += e.balance;
    }
    int open(bool theyOweUs) =>
        s.debts.where((d) => !d.forgiven && (d.direction == 'in') == theyOweUs).fold(0, (a, d) => a + (d.amountMinor - d.paidMinor));
    _c['cash']!.text = '${held < 0 ? 0 : held}';
    _c['recv']!.text = '${open(true)}';
    _c['pay']!.text = '${open(false)}';
    if (saved != null) {
      final m = jsonDecode(saved) as Map<String, dynamic>;
      for (final k in ['g24', 'g21', 'g18', 'silver', 'gPrice', 'sPrice']) {
        if (m[k] != null) _c[k]!.text = '${m[k]}';
      }
      _basis = m['basis'] == 'silver' ? NisabBasis.silver : NisabBasis.gold;
      _deduct = m['deduct'] == true;
    }
    if (start != null) _start = DateTime.tryParse(start);
    if (mounted) setState(() => _loaded = true);
  }

  Future<void> _save() => ref.read(repositoryProvider).setValue(
        'zakat_inputs',
        jsonEncode({
          for (final k in ['g24', 'g21', 'g18', 'silver', 'gPrice', 'sPrice']) k: _c[k]!.text,
          'basis': _basis.name,
          'deduct': _deduct,
        }),
      );

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  int _int(String k) => int.tryParse(_c[k]!.text.replaceAll(',', '').trim()) ?? 0;
  double _num(String k) => double.tryParse(_c[k]!.text.replaceAll(',', '').trim()) ?? 0;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    if (!_loaded) return const SizedBox(height: 80);
    final r = computeZakat(ZakatInput(
      cash: _int('cash'),
      gold24: _num('g24'),
      gold21: _num('g21'),
      gold18: _num('g18'),
      silverGrams: _num('silver'),
      receivable: _int('recv'),
      payable: _int('pay'),
      deductPayable: _deduct,
      goldPricePerGram: _int('gPrice'),
      silverPricePerGram: _int('sPrice'),
      basis: _basis,
    ));
    Widget field(String k, String label, {String? hint, String? suffix}) => TextField(
          controller: _c[k],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(labelText: label, hintText: hint, suffixText: suffix, isDense: true),
          onChanged: (_) {
            setState(() {});
            _save();
          },
        );
    Widget row(List<Widget> children) => Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(children: [for (final (i, w) in children.indexed) ...[if (i > 0) const SizedBox(width: 10), Expanded(child: w)]]),
        );
    return WfCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('تنحسب على الفلوس اللي كملت عندكم سنة هجرية كاملة وهي فوق النصاب.', style: TextStyle(fontSize: 13, color: wf.mute, height: 1.7)),
        const SizedBox(height: 4),
        field('cash', 'الفلوس اللي عندكم', suffix: 'د.ع'),
        Text('عبّيناها من الكاش والكي كارد والدولار والخزنة والظروف. عدّلوها لو تختلف.', style: TextStyle(fontSize: 11.5, color: wf.mute, height: 1.6)),
        row([field('g21', 'ذهب عيار 21', suffix: 'غم'), field('g18', 'عيار 18', suffix: 'غم'), field('g24', 'عيار 24', suffix: 'غم')]),
        row([field('gPrice', 'سعر غرام الذهب عيار 24 اليوم', suffix: 'د.ع')]),
        row([field('silver', 'فضة', suffix: 'غم'), field('sPrice', 'سعر غرام الفضة', suffix: 'د.ع')]),
        row([field('recv', 'ديون إلكم يرجعوها', suffix: 'د.ع'), field('pay', 'ديون عليكم حالّة', suffix: 'د.ع')]),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _deduct,
          onChanged: (v) {
            setState(() => _deduct = v);
            _save();
          },
          title: const Text('اخصموا الديون اللي عليكم', style: TextStyle(fontSize: 14)),
          subtitle: Text('بيها خلاف بين العلماء', style: TextStyle(fontSize: 12, color: wf.mute)),
        ),
        Row(children: [
          const Expanded(child: Text('النصاب على', style: TextStyle(fontSize: 14))),
          Segmented<NisabBasis>(
            values: NisabBasis.values,
            selected: _basis,
            label: (b) => b == NisabBasis.gold ? 'الذهب 85 غم' : 'الفضة 595 غم',
            onChanged: (b) {
              setState(() => _basis = b);
              _save();
            },
          ),
        ]),
        const SizedBox(height: 14),
        _ZakatResultBox(r: r, basis: _basis),
        const SizedBox(height: 12),
        _HawlRow(
          start: _start,
          onPick: (d) async {
            setState(() => _start = d);
            await ref.read(repositoryProvider).setValue('zakat_start', d.toIso8601String());
          },
        ),
        const _ScholarNotes(),
      ]),
    );
  }
}

class _ZakatResultBox extends StatelessWidget {
  const _ZakatResultBox({required this.r, required this.basis});
  final ZakatResult r;
  final NisabBasis basis;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final String title;
    final String detail;
    if (r.missingPrice) {
      title = 'اكتبوا سعر غرام ${basis == NisabBasis.gold ? 'الذهب' : 'الفضة'} اليوم';
      detail = 'بدون السعر ما نعرف النصاب بالدينار.';
    } else if (r.reached) {
      title = 'الزكاة: ${formatAmount(r.due)} د.ع';
      detail = 'عندكم ${inThousands(r.wealth)}، والنصاب ${inThousands(r.nisab)}. الزكاة ربع العُشر (2.5%).';
    } else {
      title = 'ما وصلتوا النصاب';
      detail = 'عندكم ${inThousands(r.wealth)}، والنصاب ${inThousands(r.nisab)}. ما عليكم زكاة مال هسه.';
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: r.reached ? Wf.vaultGreen : wf.sunk, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, height: 1.5, color: r.reached ? Wf.vaultGold : wf.ink)),
        Text(detail, style: TextStyle(fontSize: 13, height: 1.7, color: r.reached ? Wf.vaultText : wf.mute)),
      ]),
    );
  }
}

class _HawlRow extends StatelessWidget {
  const _HawlRow({required this.start, required this.onPick});
  final DateTime? start;
  final ValueChanged<DateTime> onPick;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final next = start == null ? null : nextHawl(start!);
    return Material(
      color: wf.sunk,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () async {
          final now = DateTime.now();
          final d = await showDatePicker(context: context, initialDate: start ?? now, firstDate: DateTime(now.year - 3), lastDate: now);
          if (d != null) onPick(d);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Icon(Icons.event_outlined, color: wf.mute),
            const SizedBox(width: 10),
            Expanded(
              child: start == null
                  ? const Text('من إمتى وصلت فلوسكم النصاب؟ اختاروا اليوم حتى نذكّركم بالحول', style: TextStyle(fontSize: 13, height: 1.6))
                  : Text('بداية الحول ${hijriLabel(start!)} هـ\nالحول يكمل ${hijriLabel(next!)} هـ (${next.day}/${next.month}/${next.year})',
                      style: const TextStyle(fontSize: 13, height: 1.7)),
            ),
          ]),
        ),
      ),
    );
  }
}

/// Where scholars differ, said plainly so the family can choose and ask.
class _ScholarNotes extends StatelessWidget {
  const _ScholarNotes();
  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 8),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: const Text('شنو اللي بيه خلاف؟', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        children: [
          for (final n in kZakatNotes)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('• $n', style: TextStyle(fontSize: 13, height: 1.7, color: wf.mute)),
            ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------- fitr

class _FitrCard extends ConsumerStatefulWidget {
  const _FitrCard({required this.snap});
  final Snapshot snap;
  @override
  ConsumerState<_FitrCard> createState() => _FitrCardState();
}

class _FitrCardState extends ConsumerState<_FitrCard> {
  final _per = TextEditingController();
  late int _people = widget.snap.members.length;

  @override
  void initState() {
    super.initState();
    _per.text = '$kFitrIraq1447';
    ref.read(repositoryProvider).getValue('fitr_per').then((v) {
      if (v != null && v.isNotEmpty && mounted) setState(() => _per.text = v);
    });
  }

  @override
  void dispose() {
    _per.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final per = int.tryParse(_per.text) ?? 0;
    final total = fitrTotal(people: _people, perPerson: per);
    return WfCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(kFitrSummary, style: TextStyle(fontSize: 13, color: wf.mute, height: 1.7)),
        const SizedBox(height: 8),
        Row(children: [
          const Expanded(child: Text('عدد أفراد البيت', style: TextStyle(fontSize: 14))),
          IconButton(tooltip: 'نقّصوا', onPressed: _people > 1 ? () => setState(() => _people--) : null, icon: const Icon(Icons.remove_circle_outline)),
          Text('$_people', style: WfText.money(18, color: wf.ink)),
          IconButton(tooltip: 'زيدوا', onPressed: () => setState(() => _people++), icon: const Icon(Icons.add_circle_outline)),
        ]),
        TextField(
          controller: _per,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textDirection: TextDirection.ltr,
          decoration: const InputDecoration(labelText: 'المبلغ عن كل شخص', suffixText: 'د.ع', helperText: 'غيّروه حسب الجهة اللي تتبعون فتواها'),
          onChanged: (v) {
            setState(() {});
            ref.read(repositoryProvider).setValue('fitr_per', v);
          },
        ),
        const SizedBox(height: 10),
        Text(total == 0 ? 'اكتبوا المبلغ عن الشخص الواحد' : 'المجموع: ${formatAmount(total)} د.ع عن $_people أشخاص',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.5)),
        if (isFitrSeason(DateTime.now()))
          Text('هسه العشر الأواخر من رمضان: جهّزوها، وتنطى قبل صلاة العيد.', style: TextStyle(fontSize: 13, color: wf.ok, height: 1.7)),
      ]),
    );
  }
}

// ----------------------------------------------------------------- library

class _Library extends StatelessWidget {
  const _Library();
  @override
  Widget build(BuildContext context) {
    final groups = [
      ('من القرآن', BarakahKind.quran),
      ('من السنة', BarakahKind.hadith),
      ('أدعية', BarakahKind.dua),
    ];
    return Column(children: [
      for (final (title, kind) in groups)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 4),
              title: Text('$title (${kBarakahTexts.where((t) => t.kind == kind).length})', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              children: [
                for (final t in kBarakahTexts.where((t) => t.kind == kind))
                  Padding(padding: const EdgeInsets.only(bottom: 10), child: BarakahBody(text: t)),
              ],
            ),
          ),
        ),
    ]);
  }
}
