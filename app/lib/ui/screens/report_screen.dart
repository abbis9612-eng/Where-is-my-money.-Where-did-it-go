library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../data/snapshot.dart';
import '../../domain/budget.dart';
import '../../state/providers.dart';
import '../../domain/barakah.dart';
import '../widgets/barakah_card.dart';
import '../theme/theme.dart';
import '../widgets/common.dart';
import '../widgets/guilloche.dart';
import '../widgets/wf_icons.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key, required this.snap});
  final Snapshot snap;
  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  late DateTime _month = DateTime(widget.snap.now.year, widget.snap.now.month - 1, 1);
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final now = widget.snap.now;
    final canNext = DateTime(_month.year, _month.month + 1).isBefore(DateTime(now.year, now.month + 1));
    final async = ref.watch(monthReportProvider((_month.year, _month.month)));
    return SafeArea(
      bottom: false,
      child: ListView(padding: const EdgeInsets.only(bottom: 96), children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 8, 0),
          child: Row(children: [
            Text('وين راحت؟', style: Theme.of(context).textTheme.headlineSmall),
            const Spacer(),
            IconButton(
              tooltip: 'الشهر اللي قبله',
              onPressed: () => setState(() {
                _month = DateTime(_month.year, _month.month - 1);
                _selected = -1;
              }),
              icon: const Icon(Icons.chevron_right),
            ),
            Text(iraqiMonthName(_month.month), style: const TextStyle(fontWeight: FontWeight.w500)),
            IconButton(
              tooltip: 'الشهر اللي بعده',
              onPressed: canNext
                  ? () => setState(() {
                        _month = DateTime(_month.year, _month.month + 1);
                        _selected = -1;
                      })
                  : null,
              icon: const Icon(Icons.chevron_left),
            ),
          ]),
        ),
        async.when(
          loading: () => const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator())),
          error: (e, _) => Padding(padding: const EdgeInsets.all(20), child: Text('ما كدرنا نحسب الشهر: $e')),
          data: (r) => r.byCategory.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(28),
                  child: Text('ماكو صرف مسجّل بهالشهر. أول ما تسجلون، تطلع هنا صورة الشهر كلها.', style: TextStyle(color: wf.mute, height: 1.7)),
                )
              : _body(context, r),
        ),
        BarakahCard(place: BarakahPlace.family, day: DateTime(_month.year, _month.month, 1)),
      ]),
    );
  }

  Widget _body(BuildContext context, MonthReport r) {
    final wf = Wf.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final green = dark ? wf.mint : Wf.vaultGreen;
    final fill = dark ? const Color(0xFF3E9C84) : const Color(0xFF1B675B);
    final hot = dark ? const Color(0xFFD9765A) : const Color(0xFFC4553A);
    final hotInk = dark ? const Color(0xFFF2A88F) : const Color(0xFFA6412A);
    final cats = r.byCategory;
    final top = cats.isEmpty ? 1 : cats.first.amount.clamp(1, 1 << 62);
    final selected = _selected >= 0 && _selected < cats.length ? cats[_selected] : null;
    final covered = r.gap > 0 ? (r.income <= 0 ? 0 : r.income) : r.spent;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: Text.rich(
          TextSpan(children: [
            const TextSpan(text: 'صرفتوا '),
            TextSpan(text: inThousands(r.spent), style: TextStyle(fontFamily: WfText.num, color: green)),
            TextSpan(text: r.income > 0 ? '،\nوالدخل ' : '.'),
            if (r.income > 0) TextSpan(text: inThousands(r.income), style: const TextStyle(fontFamily: WfText.num)),
            if (r.income > 0) const TextSpan(text: '.'),
          ]),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.5),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: r.gap > 0 ? wf.alertBg : wf.okBg, borderRadius: BorderRadius.circular(99)),
            child: Text(
              r.gap > 0
                  ? (r.fromVault > 0 ? 'زاد ${inThousands(r.gap)}، وانسحب ${inThousands(r.fromVault)} من الخزنة' : 'زاد الصرف ${inThousands(r.gap)} على الدخل')
                  : 'بقى ${inThousands(-r.gap)} من الدخل',
              style: TextStyle(color: r.gap > 0 ? hotInk : wf.ok, fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ),
      ),
      if (r.spent > 0)
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
          child: Semantics(
            label: r.gap > 0 ? 'من الدخل ${formatAmount(covered)}، والزايد ${formatAmount(r.gap)}' : 'كل الصرف من الدخل',
            excludeSemantics: true,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 16,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    if (covered > 0) Expanded(flex: covered, child: ColoredBox(color: fill)),
                    if (r.gap > 0 && covered > 0) const SizedBox(width: 2),
                    if (r.gap > 0) Expanded(flex: r.gap, child: ColoredBox(color: hot)),
                  ]),
                ),
              ),
              const SizedBox(height: 4),
              Row(children: [
                Text('من الدخل', style: TextStyle(fontSize: 12, color: wf.mute)),
                const Spacer(),
                if (r.gap > 0) Text(r.fromVault > 0 ? 'من الخزنة' : 'زايد', style: TextStyle(fontSize: 12, color: hotInk)),
              ]),
            ]),
          ),
        ),
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
        child: Text('وين راحت؟ من الأكثر', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ),
      for (var i = 0; i < cats.length; i++)
        Semantics(
          button: true,
          selected: _selected == i,
          label: '${cats[i].name} ${formatAmount(cats[i].amount)}',
          excludeSemantics: true,
          child: InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _selected = _selected == i ? -1 : i);
            },
            child: Container(
              color: _selected == i ? wf.tint : null,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(children: [
                WfIconTile(
                  glyphForCategory(cats[i].key),
                  size: 40,
                  background: r.leak?.key == cats[i].key ? (dark ? const Color(0x24D9765A) : const Color(0xFFFBEFEA)) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Row(children: [
                      Flexible(child: Text(cats[i].name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, height: 1.4))),
                      if (r.leak?.key == cats[i].key) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(color: wf.alertBg, borderRadius: BorderRadius.circular(99)),
                          child: Text('${cats[i].count} مرة', style: TextStyle(fontSize: 11.5, color: hotInk, height: 1.5)),
                        ),
                      ],
                      const Spacer(),
                      Text(
                        inThousands(cats[i].amount),
                        style: WfText.money(15, weight: r.leak?.key == cats[i].key ? FontWeight.w600 : FontWeight.w500, color: r.leak?.key == cats[i].key ? hotInk : wf.ink),
                      ),
                    ]),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: cats[i].amount / top,
                        minHeight: 10,
                        backgroundColor: dark ? const Color(0x14FFFFFF) : const Color(0xFFEEF2F0),
                        color: r.leak?.key == cats[i].key ? hot : fill,
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Text(
          selected == null
              ? 'دوسوا على أي باب تشوفون تفاصيله.'
              : '${selected.name}: ${formatAmount(selected.amount)} بـ${selected.count} مرة، بالمعدل ${formatAmount(selected.count == 0 ? 0 : selected.amount ~/ selected.count)} للمرة.',
          style: TextStyle(fontSize: 13, height: 1.6, color: selected == null ? wf.mute : wf.ink),
        ),
      ),
      if (r.leak != null && r.leakSaving > 0) _Insight(report: r),
    ]);
  }
}

class _Insight extends ConsumerWidget {
  const _Insight({required this.report});
  final MonthReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leak = report.leak!;
    final next = iraqiMonthName(report.month + 1);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Wf.vaultGreen, borderRadius: BorderRadius.circular(24), border: Border.all(color: Wf.of(context).vaultLine)),
      child: Stack(children: [
        const PositionedDirectional(end: -110, top: -90, child: Rosette(size: 260, spin: false)),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('فكرة ل$next', style: const TextStyle(color: Wf.vaultMint, fontSize: 13)),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(children: [
                TextSpan(text: '${leak.name} صار ${leak.count} مرة. لو صار مرة بالأسبوع توفّرون حوالي '),
                TextSpan(text: formatAmount(report.leakSaving), style: const TextStyle(color: Wf.vaultGold, fontFamily: WfText.num, fontWeight: FontWeight.w600, fontSize: 18)),
                TextSpan(text: report.gap > 0 && report.leakSaving >= report.gap ? '، يعني يغطي الزيادة ويبقى.' : ' بالشهر.'),
              ]),
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, height: 1.6),
            ),
            const SizedBox(height: 12),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Wf.vaultGreen, shape: const StadiumBorder(), minimumSize: const Size(0, 44)),
              onPressed: () async {
                await ref.read(repositoryProvider).setValue('goal_${report.year}_${report.month + 1}', '${leak.key}:weekly');
                if (context.mounted) Toaster.show(context, 'صار هدف $next: ${leak.name} مرة بالأسبوع');
              },
              child: Text('خلّوها هدف $next'),
            ),
          ]),
        ),
      ]),
    );
  }
}
