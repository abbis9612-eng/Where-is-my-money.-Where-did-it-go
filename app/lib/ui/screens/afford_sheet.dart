library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../domain/afford.dart';
import '../../domain/banknotes.dart';
import '../../state/providers.dart';
import '../theme/theme.dart';
import '../widgets/banknote.dart';
import '../widgets/common.dart';
import '../widgets/odometer.dart';

class AffordSheet extends ConsumerStatefulWidget {
  const AffordSheet({super.key, this.initial = 0});
  final int initial;

  @override
  ConsumerState<AffordSheet> createState() => _AffordSheetState();
}

class _AffordSheetState extends ConsumerState<AffordSheet> {
  late var _digits = widget.initial > 0 ? '${widget.initial}' : '';
  static const _presets = [('حذاء للطفل', 35000), ('عشاء برّه', 45000), ('سبلت طن ونص', 650000)];

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider).value;
    if (snap == null) return const SizedBox.shrink();
    final wf = Wf.of(context);
    final price = int.tryParse(_digits) ?? 0;
    final w = snap.week;
    final a = canAfford(price: price, left: w.left < 0 ? 0 : w.left, daysLeft: w.daysLeft, minPerDay: snap.plan.minPerDay);
    final notes = breakdown(w.left).reversed.toList();
    final pick = pickNotes(notes, price);

    final (Color fg, Color bg, IconData icon, String title, String sub, List<String> options) = switch (a.level) {
      AffordLevel.idle => (wf.mute, wf.sunk, Icons.shopping_bag_outlined, 'اكتبوا السعر وشوفوا', 'نحسبها من فلوس الأسبوع، وإذا ما تكفي نقترح منين', <String>[]),
      AffordLevel.yes => (
          wf.ok,
          wf.okBg,
          Icons.check_rounded,
          'إي، اشتروه',
          'يبقى ${formatAmount(a.after)} للأسبوع، كل يوم حوالي ${formatAmount(a.perDayAfter)}${pick.changeFor(price) > 0 ? '. ويرجع لكم ${formatAmount(pick.changeFor(price))}' : ''}',
          <String>[],
        ),
      AffordLevel.tight => (
          wf.warn,
          wf.warnBg,
          Icons.priority_high_rounded,
          'تكدرون، بس يضيق',
          'كل يوم يصير ${formatAmount(a.perDayAfter)} لحد الجمعة',
          [
            if (a.maxComfortable > 0) 'لو بحدود ${formatAmount(a.maxComfortable)}، يضل كل يوم ${formatAmount(snap.plan.minPerDay)}',
            'اشتروه الأسبوع الجاي، ينزل لكم ${formatAmount(snap.weeklyAllowance)}',
          ],
        ),
      AffordLevel.no => (
          wf.alert,
          wf.alertBg,
          Icons.close_rounded,
          'مو من فلوس هالأسبوع',
          'ينقصكم ${formatAmount(a.shortBy)}',
          [
            'ادّخروا له 50,000 بالأسبوع، يجهز بعد ${a.weeksToSave} أسبوع',
            'حطّوه بخطة الراتب الجاي',
            'من الخزنة، بس تنفتح باتفاق الاثنين',
          ],
        ),
    };

    return ListView(padding: EdgeInsets.zero, children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 8, 0),
        child: Row(children: [
          Text('أكدر أشتريه؟', style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          IconButton(tooltip: 'سكّر', onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Odometer(value: price, style: WfText.money(54, color: price == 0 ? wf.faint : wf.ink)),
          const SizedBox(width: 8),
          Padding(padding: const EdgeInsets.only(bottom: 10), child: Text('د.ع', style: TextStyle(color: wf.mute))),
        ]),
      ),
      SizedBox(
        height: 52,
        child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.fromLTRB(20, 8, 20, 4), children: [
          for (final (name, v) in _presets)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: WfChip(label: name, trailing: formatAmount(v), onTap: () => setState(() => _digits = '$v')),
            ),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
        child: Wrap(spacing: 6, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.end, children: [
          if (notes.isEmpty) Text('الرزمة فارغة هالأسبوع', style: TextStyle(color: wf.mute, fontSize: 13)),
          for (var i = 0; i < notes.length; i++)
            AnimatedSlide(
              offset: price > 0 && pick.indexes.contains(i) ? const Offset(0, -.33) : Offset.zero,
              duration: const Duration(milliseconds: 350),
              curve: const SpringCurve(),
              child: MiniNote(notes[i], ring: price > 0 && pick.indexes.contains(i) ? (pick.total < price ? wf.alert : wf.ink) : null),
            ),
        ]),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: wf.surface, borderRadius: BorderRadius.circular(20)),
        child: Semantics(
          liveRegion: true,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
              child: Icon(icon, color: fg, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: a.level == AffordLevel.idle ? wf.ink : fg, height: 1.5)),
                Text(sub, style: TextStyle(fontSize: 13, color: wf.mute, height: 1.55)),
                for (final o in options)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        alignment: AlignmentDirectional.centerStart,
                        foregroundColor: wf.ink,
                        side: BorderSide(color: wf.line),
                        backgroundColor: wf.bg,
                        minimumSize: const Size.fromHeight(44),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        textStyle: const TextStyle(fontSize: 13, fontFamily: WfText.ui),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Toaster.show(context, 'تمام: $o');
                      },
                      child: Text(o),
                    ),
                  ),
              ]),
            ),
          ]),
        ),
      ),
      const SizedBox(height: 8),
      Keypad(keyHeight: 50, onKey: (k) => setState(() => _digits = applyKey(_digits, k, maxLength: 9))),
      const SizedBox(height: 16),
    ]);
  }
}
