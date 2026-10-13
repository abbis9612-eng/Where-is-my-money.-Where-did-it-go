library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../data/database.dart';
import '../../data/snapshot.dart';
import '../../state/providers.dart';
import '../format.dart';
import '../theme/theme.dart';
import '../widgets/common.dart';

/// Bank messages as a deck of cards: tap "صح" or swipe left to record,
/// swipe right if it was not the family's spending.
class InboxSheet extends ConsumerStatefulWidget {
  const InboxSheet({super.key});
  @override
  ConsumerState<InboxSheet> createState() => _InboxSheetState();
}

class _InboxSheetState extends ConsumerState<InboxSheet> {
  final Map<String, String> _chosen = {};
  double _dx = 0;
  bool _flying = false;

  Future<void> _decide(Snapshot snap, InboxItem item, bool accept) async {
    if (_flying) return;
    HapticFeedback.mediumImpact();
    setState(() {
      _flying = true;
      _dx = accept ? -500 : 500;
    });
    await Future<void>.delayed(const Duration(milliseconds: 260));
    final repo = ref.read(repositoryProvider);
    if (accept) {
      final cat = _chosen[item.id] ?? item.suggestedCategory;
      final txn = await repo.acceptInbox(item.id, categoryKey: cat, memberId: snap.me.id);
      if (mounted) {
        Toaster.show(context, 'انسجلت من الرسالة: ${snap.categoryName(cat)} ${formatMoney(item.amountMinor, Currency.fromCode(item.currency))}', onUndo: () async {
          if (txn != null) await repo.softDelete([txn]);
          await repo.reopenInbox(item.id);
        });
      }
    } else {
      await repo.dismissInbox(item.id);
    }
    if (mounted) {
      setState(() {
        _flying = false;
        _dx = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider).value;
    if (snap == null) return const SizedBox.shrink();
    final wf = Wf.of(context);
    final items = snap.inbox;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 8, 0),
        child: Row(children: [
          Text('من الكي كارد', style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          IconButton(tooltip: 'سكّر', onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('التطبيق قرأ رسائل البنك وخمّن الباب. دوسوا «صح» أو اسحبوا البطاقة لليسار، ولليمين إذا مو صرفة إلكم.',
            style: TextStyle(color: wf.mute, fontSize: 13, height: 1.6)),
      ),
      const SizedBox(height: 16),
      Expanded(
        child: items.isEmpty
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('خلصت، كلها متسجلة', style: Theme.of(context).textTheme.titleLarge),
                Text('الرسائل الجاية تنتظركم هنا', style: TextStyle(color: wf.mute)),
              ])
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(children: [
                  for (var i = (items.length > 3 ? 2 : items.length - 1); i >= 0; i--) _card(snap, items[i], depth: i),
                ]),
              ),
      ),
      if (items.isNotEmpty) Center(child: Text('باقي ${items.length}', style: TextStyle(color: wf.mute, fontSize: 12))),
      Padding(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 16 + MediaQuery.of(context).viewPadding.bottom),
        child: Text('يقرأ رسائل البنك بس، وبموافقتكم. Google Play يسمح بهذا لتطبيقات إدارة الميزانية.', style: TextStyle(color: wf.mute, fontSize: 11)),
      ),
    ]);
  }

  Widget _card(Snapshot snap, InboxItem it, {required int depth}) {
    final wf = Wf.of(context);
    final top = depth == 0;
    final chosen = _chosen[it.id] ?? it.suggestedCategory;
    final options = <String>{it.suggestedCategory, 'groceries', 'eating_out', 'health', 'fuel', 'kid', 'other'}.toList();
    final kindLabel = switch (it.kind) { 'withdrawal' => 'سحب كاش، ينحسب بالجيب مو صرف', 'credit' => 'فلوس دخلت', _ => null };
    final card = Container(
      decoration: BoxDecoration(
        color: wf.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: wf.line),
        boxShadow: [BoxShadow(color: wf.shadow, blurRadius: 30, offset: const Offset(0, 18), spreadRadius: -22)],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(color: wf.sunk, borderRadius: BorderRadius.circular(10)),
          child: Text(it.body, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: wf.mute, height: 1.6)),
        ),
        const SizedBox(height: 12),
        Text(it.merchant ?? it.sender, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4)),
        Text(kindLabel ?? spokenTime(it.receivedAt), style: TextStyle(fontSize: 12, color: wf.mute)),
        Text(formatMoney(it.amountMinor, Currency.fromCode(it.currency)), style: WfText.money(44, color: wf.ink, height: 1.2)),
        if (it.kind == 'purchase') ...[
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final o in options.take(4))
              WfChip(
                label: snap.categoryName(o),
                selected: chosen == o,
                tag: o == it.suggestedCategory ? 'تخمين' : null,
                onTap: top ? () => setState(() => _chosen[it.id] = o) : null,
              ),
          ]),
        ],
        const Spacer(),
        Row(children: [
          Expanded(child: PrimaryButton(label: 'صح، سجّلوها', height: 50, onPressed: top ? () => _decide(snap, it, true) : null)),
          const SizedBox(width: 8),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(shape: const StadiumBorder(), side: BorderSide(color: wf.line), foregroundColor: wf.ink),
              onPressed: top ? () => _decide(snap, it, false) : null,
              child: const Text('مو إلنا'),
            ),
          ),
        ]),
      ]),
    );
    if (!top) {
      return Positioned.fill(
        child: Transform.translate(
          offset: Offset(0, depth * 10.0),
          child: Transform.scale(scale: 1 - depth * .04, child: ExcludeSemantics(child: card)),
        ),
      );
    }
    return Positioned.fill(
      child: GestureDetector(
        onHorizontalDragUpdate: _flying ? null : (d) => setState(() => _dx += d.delta.dx),
        onHorizontalDragEnd: _flying
            ? null
            : (_) {
                if (_dx < -90) {
                  _decide(snap, it, true);
                } else if (_dx > 90) {
                  _decide(snap, it, false);
                } else {
                  setState(() => _dx = 0);
                }
              },
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: _dx),
          duration: _flying ? const Duration(milliseconds: 260) : const Duration(milliseconds: 1),
          builder: (_, dx, child) => Transform.translate(
            offset: Offset(dx, 0),
            child: Transform.rotate(angle: dx / 900, child: Stack(children: [
              child!,
              if (dx < -20) _stamp('صح', wf.ok, (-dx / 90).clamp(0, 1).toDouble(), start: true),
              if (dx > 20) _stamp('مو إلنا', wf.alert, (dx / 90).clamp(0, 1).toDouble(), start: false),
            ])),
          ),
          child: card,
        ),
      ),
    );
  }

  Widget _stamp(String text, Color color, double opacity, {required bool start}) => PositionedDirectional(
        top: 22,
        start: start ? null : 22,
        end: start ? 22 : null,
        child: Opacity(
          opacity: opacity,
          child: Transform.rotate(
            angle: start ? -.25 : .25,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(border: Border.all(color: color, width: 2.5), borderRadius: BorderRadius.circular(8)),
              child: Text(text, style: TextStyle(fontFamily: WfText.brand, fontSize: 18, color: color)),
            ),
          ),
        ),
      );
}
