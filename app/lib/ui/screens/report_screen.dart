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
      child: ListView(padding: const EdgeInsets.only(bottom: 24), children: [
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
    final cats = r.byCategory.length > 6
        ? [
            ...r.byCategory.take(5),
            CategorySpend(key: 'rest', name: 'غيرها', amount: r.byCategory.skip(5).fold(0, (a, c) => a + c.amount), count: r.byCategory.skip(5).fold(0, (a, c) => a + c.count), isWant: false),
          ]
        : r.byCategory;
    final sources = <(String, int, bool)>[
      ('الدخل', r.income, false),
      if (r.fromVault > 0) ('من الخزنة', r.fromVault, true),
      if (r.gap - r.fromVault > 0) ('ناقص', r.gap - r.fromVault, true),
    ];
    final selected = _selected >= 0 && _selected < cats.length ? cats[_selected] : null;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
        child: Wrap(spacing: 12, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
          _kv(context, 'دخل', r.income),
          _kv(context, 'صرف', r.spent),
          if (r.gap > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(color: wf.alertBg, borderRadius: BorderRadius.circular(99)),
              child: Text('زاد الصرف ${formatAmount(r.gap)}', style: TextStyle(color: wf.alert, fontWeight: FontWeight.w600, fontSize: 12)),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(color: wf.okBg, borderRadius: BorderRadius.circular(99)),
              child: Text('بقى ${formatAmount(-r.gap)}', style: TextStyle(color: wf.ok, fontWeight: FontWeight.w600, fontSize: 12)),
            ),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: SizedBox(
          height: 400,
          child: LayoutBuilder(builder: (context, box) {
            final layout = _Sankey.layout(Size(box.maxWidth, 400), sources, cats);
            return Stack(children: [
              Positioned.fill(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder: (_, t, _) => CustomPaint(painter: _SankeyPainter(layout, cats, sources, _selected, t, ink: wf.ink, alert: wf.alert, vault: wf.vault)),
                ),
              ),
              for (var i = 0; i < cats.length; i++)
                Positioned(
                  left: 0,
                  width: 138,
                  top: layout.targets[i].center - 20,
                  height: 40,
                  child: Semantics(
                    button: true,
                    label: '${cats[i].name} ${formatAmount(cats[i].amount)}',
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() => _selected = _selected == i ? -1 : i);
                      },
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                        Row(children: [
                          Flexible(child: Text(cats[i].name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, height: 1.3))),
                          if (r.leak?.key == cats[i].key) Text(' ${cats[i].count} مرة', style: TextStyle(fontSize: 10, color: wf.alert, fontWeight: FontWeight.w600)),
                        ]),
                        Text(formatAmount(cats[i].amount), style: WfText.money(12, weight: FontWeight.w400, color: wf.mute, height: 1.3)),
                      ]),
                    ),
                  ),
                ),
              for (var i = 0; i < sources.length; i++)
                Positioned(
                  right: 14,
                  top: layout.sources[i].center - 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(color: wf.surface, borderRadius: BorderRadius.circular(99), boxShadow: [BoxShadow(color: wf.shadow, blurRadius: 6, offset: const Offset(0, 2))]),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: '${sources[i].$1} '),
                      TextSpan(text: formatAmount(sources[i].$2), style: const TextStyle(fontFamily: WfText.num, fontWeight: FontWeight.w600)),
                    ]), style: TextStyle(fontSize: 11, color: sources[i].$3 ? wf.alert : wf.ink)),
                  ),
                ),
            ]);
          }),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Text(
          selected == null
              ? 'دوسوا على أي باب تشوفون تفاصيله.'
              : '${selected.name}: ${formatAmount(selected.amount)} بـ${selected.count} مرة، بالمعدل ${formatAmount(selected.count == 0 ? 0 : selected.amount ~/ selected.count)} للمرة.',
          style: const TextStyle(fontSize: 13, height: 1.6),
        ),
      ),
      if (r.leak != null && r.leakSaving > 0) _Insight(report: r),
    ]);
  }

  Widget _kv(BuildContext context, String k, int v) => Text.rich(TextSpan(children: [
        TextSpan(text: '$k ', style: TextStyle(color: Wf.of(context).mute)),
        TextSpan(text: formatAmount(v), style: WfText.money(13, weight: FontWeight.w600, color: Wf.of(context).ink)),
      ]));
}

class _Band {
  _Band(this.top, this.height);
  final double top;
  final double height;
  double get center => top + height / 2;
}

class _Ribbon {
  _Ribbon(this.source, this.target, this.y0, this.y1, this.h);
  final int source, target;
  final double y0, y1, h;
}

class _Sankey {
  _Sankey(this.sources, this.targets, this.ribbons, this.width);
  final List<_Band> sources;
  final List<_Band> targets;
  final List<_Ribbon> ribbons;
  final double width;

  static _Sankey layout(Size size, List<(String, int, bool)> src, List<CategorySpend> cats) {
    const gap = 12.0, sg = 8.0;
    final total = cats.fold(0, (a, c) => a + c.amount);
    final srcTotal = src.fold(0, (a, s) => a + s.$2);
    final scaleTotal = total > srcTotal ? total : srcTotal;
    final k = (size.height - gap * (cats.length - 1)) / (scaleTotal == 0 ? 1 : scaleTotal);
    final sourcesH = srcTotal * k + sg * (src.length - 1);
    var sy = (size.height - sourcesH) / 2;
    final sources = <_Band>[];
    for (final s in src) {
      sources.add(_Band(sy, s.$2 * k));
      sy += s.$2 * k + sg;
    }
    var ty = 0.0;
    final targets = <_Band>[];
    for (final c in cats) {
      targets.add(_Band(ty, c.amount * k));
      ty += c.amount * k + gap;
    }
    final ribbons = <_Ribbon>[];
    final sCur = [for (final s in sources) s.top];
    final tCur = [for (final t in targets) t.top];
    var si = 0;
    for (var ci = 0; ci < cats.length; ci++) {
      var need = cats[ci].amount * k;
      while (need > .01 && si < sources.length) {
        final avail = sources[si].top + sources[si].height - sCur[si];
        final take = need < avail ? need : avail;
        if (take > 0) {
          ribbons.add(_Ribbon(si, ci, sCur[si], tCur[ci], take));
          sCur[si] += take;
          tCur[ci] += take;
          need -= take;
        }
        if (sources[si].top + sources[si].height - sCur[si] < .01) si++;
      }
    }
    return _Sankey(sources, targets, ribbons, size.width);
  }
}

class _SankeyPainter extends CustomPainter {
  _SankeyPainter(this.s, this.cats, this.src, this.selected, this.t, {required this.ink, required this.alert, required this.vault});
  final _Sankey s;
  final List<CategorySpend> cats;
  final List<(String, int, bool)> src;
  final int selected;
  final double t;
  final Color ink, alert, vault;

  @override
  void paint(Canvas canvas, Size size) {
    final xs = size.width - 10, xt = 146.0, nw = 8.0;
    final xm = (xs + xt + nw) / 2;
    final leakKey = cats.where((c) => c.isWant).fold<CategorySpend?>(null, (a, c) => a == null || c.count > a.count ? c : a)?.key;
    for (final r in s.ribbons) {
      final red = src[r.source].$3 || cats[r.target].key == leakKey;
      final base = src[r.source].$3 ? .42 : (cats[r.target].key == leakKey ? .24 : .1);
      final dim = selected >= 0 && selected != r.target;
      final b = xt + nw;
      // Ribbons grow from the source towards the categories as t goes 0→1.
      final xEnd = xs - (xs - b) * t;
      final path = Path()
        ..moveTo(xs, r.y0)
        ..cubicTo(xm, r.y0, xm, r.y1, xEnd, r.y1)
        ..lineTo(xEnd, r.y1 + r.h)
        ..cubicTo(xm, r.y1 + r.h, xm, r.y0 + r.h, xs, r.y0 + r.h)
        ..close();
      canvas.drawPath(path, Paint()..color = (red ? alert : ink).withValues(alpha: dim ? base * .3 : (selected == r.target ? base * 2.2 : base)));
      // Engraved lines inside each ribbon, like a banknote.
      canvas.save();
      canvas.clipPath(path);
      final line = Paint()
        ..color = ink.withValues(alpha: dim ? .05 : .14)
        ..strokeWidth = .8
        ..style = PaintingStyle.stroke;
      final top = r.y0 < r.y1 ? r.y0 : r.y1;
      final bottom = (r.y0 > r.y1 ? r.y0 : r.y1) + r.h;
      for (var y = top - 40; y < bottom + 40; y += 5) {
        final p = Path()..moveTo(b, y);
        for (var x = b; x <= xs; x += 22) {
          p.quadraticBezierTo(x + 5.5, y - 2.5, x + 11, y);
          p.quadraticBezierTo(x + 16.5, y + 2.5, x + 22, y);
        }
        canvas.drawPath(p, line);
      }
      canvas.restore();
    }
    for (var i = 0; i < s.sources.length; i++) {
      final b = s.sources[i];
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(xs, b.top, 10, b.height), const Radius.circular(2)), Paint()..color = src[i].$3 ? alert : vault);
    }
    for (var i = 0; i < s.targets.length; i++) {
      final b = s.targets[i];
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(xt, b.top, nw, b.height * t), const Radius.circular(2)),
          Paint()..color = cats[i].key == leakKey ? alert : ink);
    }
  }

  @override
  bool shouldRepaint(_SankeyPainter o) => o.t != t || o.selected != selected || o.ink != ink;
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
