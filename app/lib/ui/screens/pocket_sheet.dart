library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../data/database.dart';
import '../../data/snapshot.dart';
import '../../state/providers.dart';
import '../theme/theme.dart';
import '../widgets/common.dart';
import '../widgets/odometer.dart';
import 'add_sheet.dart';

/// "عدّ الجيب": count the cash instead of logging every small purchase.
class PocketSheet extends ConsumerStatefulWidget {
  const PocketSheet({super.key});
  @override
  ConsumerState<PocketSheet> createState() => _PocketSheetState();
}

class _PocketSheetState extends ConsumerState<PocketSheet> {
  String? _memberId;
  var _digits = '';
  var _busy = false;

  Wallet? _cash(Snapshot s) => s.walletOfKind('cash', ownerId: _memberId);

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider).value;
    if (snap == null) return const SizedBox.shrink();
    final wf = Wf.of(context);
    _memberId ??= snap.me.id;
    final wallet = _cash(snap);
    final view = snap.wallets.where((w) => w.wallet.id == wallet?.id).firstOrNull;
    final expected = view?.balance ?? 0;
    final counted = int.tryParse(_digits) ?? 0;
    final gap = expected - counted;
    final firstTime = view != null && !view.counted;

    Widget result;
    if (counted == 0) {
      result = Text(firstTime ? 'أول مرة: عدّوا اللي بالجيب، وهذا يصير البداية.' : 'عدّوا اللي بالجيب واكتبوه.');
    } else if (firstTime) {
      result = Row(children: [
        const Expanded(child: Text('تمام، من هسه نحسب الكاش من هنا.')),
        FilledButton(onPressed: _busy ? null : () => _save(snap, counted, log: false), child: const Text('ثبّتوها')),
      ]);
    } else if (gap > 0) {
      result = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text.rich(TextSpan(children: [
          const TextSpan(text: 'ناقص '),
          TextSpan(text: formatAmount(gap), style: const TextStyle(fontFamily: WfText.num, fontWeight: FontWeight.w600)),
          const TextSpan(text: ' ما مسجّلة. عادي، هذني الأشياء الصغيرة.'),
        ])),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Wf.vaultGreen, foregroundColor: Colors.white),
            onPressed: _busy ? null : () => _save(snap, counted, log: true),
            child: const Text('سجّلوها «أشياء صغيرة»'),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(foregroundColor: wf.tintInk, side: BorderSide(color: wf.tintInk)),
            onPressed: _busy
                ? null
                : () async {
                    await ref.read(repositoryProvider).countWallet(walletId: wallet!.id, counted: expected, memberId: _memberId, logGap: false);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    final g6 = (gap * .6 / 1000).round();
                    final g4 = (gap / 1000).round() - g6;
                    showWfSheet(context, (_) => AddSheet(initialText: 'خبز وخضرة $g6 وبقالة $g4'));
                  },
            child: const Text('وزّعوها على الأبواب'),
          ),
        ]),
      ]);
    } else if (gap < 0) {
      result = Row(children: [
        Expanded(child: Text('بالجيب ${formatAmount(-gap)} زيادة. يمكن دخلت فلوس ما تسجلت.')),
        TextButton(onPressed: _busy ? null : () => _save(snap, counted, log: false), child: const Text('ثبّتوها')),
      ]);
    } else {
      result = const Text('مضبوط. كل الكاش متسجل.');
    }

    return ListView(padding: EdgeInsets.zero, children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 8, 0),
        child: Row(children: [
          Text('عدّ الجيب', style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          IconButton(tooltip: 'سكّر', onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('ما تحتاجون تسجّلون كل صمونة كاش. عدّوا اللي بجيبكم مرة باليوم أو بالأسبوع، والفرق نسجله وحده.',
            style: TextStyle(color: wf.mute, fontSize: 13, height: 1.6)),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Row(children: [
          for (final m in snap.adults)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 6),
              child: GestureDetector(
                onTap: () => setState(() {
                  _memberId = m.id;
                  _digits = '';
                }),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _memberId == m.id ? wf.ink : Colors.transparent, width: 2)),
                  child: MemberAvatar(m, size: 34, dim: _memberId != m.id),
                ),
              ),
            ),
          const Spacer(),
          OutlinedButton(
            style: OutlinedButton.styleFrom(shape: const StadiumBorder(), foregroundColor: wf.ink, side: BorderSide(color: wf.line)),
            onPressed: wallet == null ? null : () => _withdraw(snap, wallet),
            child: const Text('سحبت كاش من الكي كارد'),
          ),
        ]),
      ),
      if (!firstTime)
        WfCard(
          margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          radius: 18,
          child: Row(children: [
            Expanded(child: Text('حسب المسجّل،\nلازم يكون بالجيب', style: TextStyle(color: wf.mute, fontSize: 13, height: 1.5))),
            Text(formatAmount(expected), style: WfText.money(22, weight: FontWeight.w500, color: wf.ink)),
          ]),
        ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Odometer(value: counted, style: WfText.money(52, color: counted == 0 ? wf.faint : wf.ink)),
          const SizedBox(width: 8),
          Padding(padding: const EdgeInsets.only(bottom: 10), child: Text('بالجيب هسه', style: TextStyle(color: wf.mute))),
        ]),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(minHeight: 48),
        decoration: BoxDecoration(color: wf.tint, borderRadius: BorderRadius.circular(18)),
        child: DefaultTextStyle(style: TextStyle(color: wf.tintInk, fontSize: 14, height: 1.6, fontFamily: WfText.ui), child: result),
      ),
      const SizedBox(height: 8),
      Keypad(onKey: (k) => setState(() => _digits = applyKey(_digits, k, maxLength: 9))),
      const SizedBox(height: 16),
    ]);
  }

  Future<void> _save(Snapshot snap, int counted, {required bool log}) async {
    final wallet = _cash(snap);
    if (wallet == null) return;
    setState(() => _busy = true);
    final r = await ref.read(repositoryProvider).countWallet(walletId: wallet.id, counted: counted, memberId: _memberId, logGap: log);
    if (!mounted) return;
    Navigator.pop(context);
    Toaster.show(context, r.gap > 0 && log ? 'انسجل الفرق: ${formatAmount(r.gap)}' : 'تثبّت الكاش: ${formatAmount(counted)}');
  }

  Future<void> _withdraw(Snapshot snap, Wallet cash) async {
    final card = snap.walletOfKind('qi_card');
    if (card == null) return;
    final amount = await showDialog<int>(context: context, builder: (_) => const _AmountDialog(title: 'شكد سحبتوا؟'));
    if (amount == null || amount <= 0) return;
    await ref.read(repositoryProvider).withdrawCash(fromWalletId: card.id, toWalletId: cash.id, amount: amount, memberId: _memberId);
    if (mounted) Toaster.show(context, 'سحب ${formatAmount(amount)} صار كاش بالجيب. هذا مو صرف.');
  }
}

class _AmountDialog extends StatefulWidget {
  const _AmountDialog({required this.title});
  final String title;
  @override
  State<_AmountDialog> createState() => _AmountDialogState();
}

class _AmountDialogState extends State<_AmountDialog> {
  final _c = TextEditingController();
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.title),
        content: TextField(
          controller: _c,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'مثلاً 100000', suffixText: 'د.ع'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          FilledButton(onPressed: () => Navigator.pop(context, int.tryParse(_c.text.replaceAll(',', ''))), child: const Text('تمام')),
        ],
      );
}
