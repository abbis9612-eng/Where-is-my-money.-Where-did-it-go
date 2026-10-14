library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../data/snapshot.dart';
import '../../domain/budget.dart';
import '../../state/providers.dart';
import '../theme/theme.dart';
import '../widgets/banknote.dart';
import '../widgets/common.dart';
import '../widgets/guilloche.dart';
import '../widgets/odometer.dart';

class EnvelopesScreen extends ConsumerWidget {
  const EnvelopesScreen({super.key, required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final vault = snap.vault;
    final others = snap.envelopes.where((e) => e.envelope.kind != 'vault').toList();
    final month = '${snap.now.year}-${snap.now.month.toString().padLeft(2, '0')}';
    final bills = snap.bills.where((b) => b.active).toList()..sort((a, b) => a.dayOfMonth.compareTo(b.dayOfMonth));
    return SafeArea(
      bottom: false,
      child: ListView(padding: const EdgeInsets.only(bottom: 24), children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('الظروف', style: Theme.of(context).textTheme.headlineSmall),
            Text('وين يروح الراتب كل شهر، وشكد جمعتوا لكل هدف.', style: TextStyle(color: wf.mute, fontSize: 13, height: 1.6)),
          ]),
        ),
        _SalarySplit(snap: snap),
        if (vault != null) _VaultCard(view: vault, perPay: snap.monthlyPlan.saveFirst),
        const _Explain(
          title: 'ظروف الأهداف',
          body: 'كل ظرف فلوس تعزلونها كل شهر لشي تحتاجوه بعدين: العيد، المدارس، العلاج. ما تنصرف بالأسبوع، '
              'والخط تحت كل ظرف يتعبّى كل ما تحطون بيه. دوسوا على الظرف حتى ينفتح.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: .98,
            children: [for (final e in others) _Envelope(view: e, owner: snap.memberById(e.envelope.memberId)?.displayName)],
          ),
        ),
        if (bills.isNotEmpty) ...[
          const _Explain(title: 'الفواتير الثابتة', body: 'تنقطع لحالها من الراتب بيومها كل شهر، وما تحتاجون تسجّلوها.'),
          WfCard(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            radius: 18,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(children: [
              for (final b in bills)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Row(children: [
                    Icon(billIcon(b.icon), size: 20, color: wf.mute),
                    const SizedBox(width: 10),
                    Expanded(child: Text(b.name, style: const TextStyle(fontSize: 15, height: 1.4))),
                    _Pill(
                      b.lastPosted == month ? 'انقطعت ✓' : 'تنقطع يوم ${b.dayOfMonth}',
                      done: b.lastPosted == month,
                    ),
                    const SizedBox(width: 10),
                    Text(formatAmount(b.amountMinor), style: WfText.money(14, weight: FontWeight.w500, color: wf.ink)),
                  ]),
                ),
            ]),
          ),
        ],
        const _Explain(title: 'المصروف الحر', body: 'كل واحد بالشهر إله مبلغ يصرفه بكيفه، وتفاصيله ما تبين للثاني.'),
        WfCard(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          radius: 18,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(children: [
            for (final m in snap.adults)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(children: [
                  MemberAvatar(m, size: 30),
                  const SizedBox(width: 10),
                  Expanded(child: Text(m.displayName, style: const TextStyle(fontSize: 15, height: 1.4))),
                  Text(inThousands(m.freeAllowance), style: WfText.money(14, weight: FontWeight.w500, color: wf.ink)),
                  Text(' بالشهر', style: TextStyle(fontSize: 12, color: wf.mute)),
                ]),
              ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              side: BorderSide(color: wf.faint, width: 1.5),
              foregroundColor: wf.ink,
              textStyle: const TextStyle(fontFamily: WfText.ui, fontWeight: FontWeight.w600, fontSize: 14),
            ),
            onPressed: () => showWfSheet(context, (_) => const PaydaySheet(), heightFactor: .9),
            child: const Text('نزل الراتب؟ وزّعوه على هالظروف بدقيقة'),
          ),
        ),
      ]),
    );
  }
}

class _VaultCard extends StatelessWidget {
  const _VaultCard({required this.view, required this.perPay});
  final EnvelopeView view;
  final int perPay;

  @override
  Widget build(BuildContext context) {
    final target = view.envelope.targetMinor;
    final months = perPay <= 0 || target <= view.balance ? 0 : ((target - view.balance) / perPay).ceil();
    final reach = DateTime(DateTime.now().year, DateTime.now().month + months, 1);
    final wf = Wf.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      height: 188,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Wf.vaultGreen, borderRadius: BorderRadius.circular(26), border: Border.all(color: wf.vaultLine)),
      padding: const EdgeInsetsDirectional.fromSTEB(18, 0, 8, 0),
      child: Row(children: [
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.lock_outline, color: Wf.vaultGold, size: 16),
              const SizedBox(width: 6),
              Text(view.envelope.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            ]),
            const Text('للطوارئ الكبيرة. ما تنفتح إلا إذا بابا وماما اتفقوا', style: TextStyle(color: Wf.vaultMuted, fontSize: 12, height: 1.5)),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(children: [
                const TextSpan(text: 'الهدف '),
                TextSpan(text: inThousands(target), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: WfText.num)),
                const TextSpan(text: '\nكل راتب تنحط بيها '),
                TextSpan(text: inThousands(perPay), style: const TextStyle(color: Wf.vaultGold, fontWeight: FontWeight.w600, fontFamily: WfText.num)),
                TextSpan(text: months == 0 ? '\nوصلتوا الهدف ✓' : '\nفتوصلون الهدف ب${iraqiMonthName(reach.month)}'),
              ]),
              style: const TextStyle(color: Color(0xFFDCE9E4), fontSize: 13, height: 1.5),
            ),
          ]),
        ),
        SizedBox.square(
          dimension: 150,
          child: Stack(alignment: Alignment.center, children: [
            const Rosette(size: 150),
            TweenAnimationBuilder<double>(
              tween: Tween(end: view.progress),
              duration: const Duration(milliseconds: 900),
              curve: const SpringCurve(damping: .8),
              builder: (_, v, _) => CustomPaint(size: const Size.square(124), painter: _Arc(v)),
            ),
            Column(mainAxisSize: MainAxisSize.min, children: [
              Odometer(value: view.balance, style: WfText.money(22, weight: FontWeight.w400, color: Wf.vaultGold)),
              const Text('جمعتوا', style: TextStyle(color: Wf.vaultMuted, fontSize: 11)),
            ]),
          ]),
        ),
      ]),
    );
  }
}

class _Arc extends CustomPainter {
  _Arc(this.v);
  final double v;
  @override
  void paint(Canvas c, Size s) {
    final r = Offset.zero & s;
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    c.drawArc(r, 0, math.pi * 2, false, p..color = Colors.white.withValues(alpha: .14));
    c.drawArc(r, -math.pi / 2, math.pi * 2 * v, false, p..color = Wf.vaultGold);
  }

  @override
  bool shouldRepaint(_Arc o) => o.v != v;
}

class _Envelope extends StatefulWidget {
  const _Envelope({required this.view, this.owner});
  final EnvelopeView view;

  /// Set when the envelope belongs to one person (e.g. the child's future).
  final String? owner;
  @override
  State<_Envelope> createState() => _EnvelopeState();
}

class _EnvelopeState extends State<_Envelope> {
  var _open = false;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final e = widget.view.envelope;
    final f = widget.view.progress;
    final peekTop = 40 - f * 34 - (_open ? 18 : 0);
    final rest = (e.targetMinor - widget.view.balance).clamp(0, 1 << 40);
    final detail = rest == 0 ? 'وصل هدفه ✓' : 'باقي ${inThousands(rest)}';
    final monthly = e.monthlyMinor > 0 ? 'كل شهر تنحط بيه ${inThousands(e.monthlyMinor)}' : 'ما إله مبلغ شهري';
    return Semantics(
      button: true,
      label: '${e.name}، جمعتوا ${inThousands(widget.view.balance)} من ${inThousands(e.targetMinor)}، $detail',
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _open = !_open);
        },
        child: LayoutBuilder(builder: (context, box) {
          return Stack(clipBehavior: Clip.none, children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: const SpringCurve(),
              top: peekTop,
              left: 16,
              right: 16,
              child: Banknote(denomination: e.noteDenomination, width: box.maxWidth - 32, showFoil: false),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: box.maxHeight * .74,
              child: Container(
                decoration: BoxDecoration(
                  color: wf.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: wf.shadow, blurRadius: 20, offset: const Offset(0, 10), spreadRadius: -16)],
                ),
                padding: const EdgeInsets.fromLTRB(14, 26, 14, 10),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                    top: -26,
                    left: -14,
                    right: -14,
                    height: 30,
                    child: TweenAnimationBuilder<double>(
                        tween: Tween(end: _open ? math.pi : 0),
                        duration: const Duration(milliseconds: 550),
                        curve: const SpringCurve(damping: .75),
                        builder: (_, a, _) => Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, .002)
                            ..rotateX(a),
                          child: ClipPath(clipper: _FlapClip(), child: Container(color: wf.flap)),
                        ),
                      ),
                  ),
                  if (widget.owner != null)
                    PositionedDirectional(
                      top: -16,
                      end: -6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                        decoration: BoxDecoration(color: wf.tint, borderRadius: BorderRadius.circular(99)),
                        child: Text('لـ${widget.owner}', style: TextStyle(fontSize: 11, color: wf.tintInk, height: 1.5)),
                      ),
                    ),
                  Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4)),
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: 'جمعتوا '),
                        TextSpan(text: inThousands(widget.view.balance), style: WfText.money(13, weight: FontWeight.w600, color: wf.ink)),
                        TextSpan(text: ' من ${formatAmount(e.targetMinor ~/ 1000)}'),
                      ]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: wf.mute, height: 1.4),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(value: f, minHeight: 3, backgroundColor: wf.sunk, color: Theme.of(context).brightness == Brightness.dark ? wf.mint : wf.vault),
                    ),
                    const SizedBox(height: 3),
                    Text(_open ? monthly : detail, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, color: rest == 0 || _open ? wf.ok : wf.mute, height: 1.5)),
                  ]),
                ]),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}

/// The salary as one bar, so every dinar has a visible place.
class _SalarySplit extends StatelessWidget {
  const _SalarySplit({required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final plan = snap.monthlyPlan;
    if (plan.salary <= 0) return const SizedBox.shrink();
    final split = splitSalary(plan, snap.now);
    final parts = [
      ('الخزنة: ادّخار أول شي', split.save, const Color(0xFFB8913C)),
      ('ظروف الأهداف', split.envelopes, const Color(0xFF1B675B)),
      ('الفواتير الثابتة', split.bills, const Color(0xFFB4573F)),
      ('مصروف البيت بالأسابيع', split.spend, const Color(0xFF8C9C96)),
    ].where((p) => p.$2 > 0).toList();
    return WfCard(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      radius: 20,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text.rich(
          TextSpan(children: [
            const TextSpan(text: 'الراتب '),
            TextSpan(text: inThousands(plan.salary), style: WfText.money(15, weight: FontWeight.w600, color: wf.ink)),
            const TextSpan(text: ' يتقسّم كل شهر هيچ:'),
          ]),
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 16,
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              for (final (i, p) in parts.indexed) ...[
                if (i > 0) const SizedBox(width: 2),
                Expanded(flex: p.$2 ~/ 1000 + 1, child: ColoredBox(color: p.$3)),
              ],
            ]),
          ),
        ),
        const SizedBox(height: 8),
        for (final p in parts)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: p.$3, borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: 8),
              Expanded(child: Text(p.$1, style: const TextStyle(fontSize: 13, height: 1.4))),
              Text(inThousands(p.$2), style: WfText.money(13, weight: FontWeight.w500, color: wf.ink)),
            ]),
          ),
      ]),
    );
  }
}

/// A section title with one plain sentence saying what it is.
class _Explain extends StatelessWidget {
  const _Explain({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, height: 1.4)),
        Text(body, style: TextStyle(fontSize: 13, color: wf.mute, height: 1.65)),
      ]),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text, {required this.done});
  final String text;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(color: done ? wf.tint : wf.sunk, borderRadius: BorderRadius.circular(99)),
      child: Text(text, style: TextStyle(fontSize: 11, color: done ? wf.tintInk : wf.mute, height: 1.6)),
    );
  }
}

class _FlapClip extends CustomClipper<Path> {
  @override
  Path getClip(Size s) => Path()
    ..moveTo(0, 0)
    ..lineTo(s.width, 0)
    ..lineTo(s.width / 2, s.height)
    ..close();
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Pay yourself first: the salary is split into four piles of notes.
class PaydaySheet extends ConsumerStatefulWidget {
  const PaydaySheet({super.key});
  @override
  ConsumerState<PaydaySheet> createState() => _PaydaySheetState();
}

class _PaydaySheetState extends ConsumerState<PaydaySheet> {
  int? _pct;
  var _busy = false;

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider).value;
    if (snap == null) return const SizedBox.shrink();
    final wf = Wf.of(context);
    final pct = _pct ?? snap.plan.savePercent;
    final plan = snap.monthlyPlan.copyWith(savePercent: pct);
    final split = splitSalary(plan, snap.now);
    final piles = [
      ('الخزنة', split.save, const Color(0xFFB8913C), 25000),
      ('الظروف', split.envelopes, const Color(0xFF1B675B), 10000),
      ('الالتزامات', split.bills, const Color(0xFF3A4744), 5000),
      ('للصرف', split.spend, const Color(0xFF8C9C96), 1000),
    ];
    final max = plan.salary * .75;
    return ListView(padding: EdgeInsets.zero, children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 8, 0),
        child: Row(children: [
          Text('نزل الراتب', style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          IconButton(tooltip: 'سكّر', onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
        ]),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 118,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Wf.vaultGreen, borderRadius: BorderRadius.circular(24)),
        child: Stack(children: [
          const PositionedDirectional(end: -90, top: -80, child: Rosette(size: 280, color: Wf.vaultGold, spin: false)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('كي كارد · ${snap.plan.payDay} ${iraqiMonthName(snap.now.month)}', style: const TextStyle(color: Wf.vaultGold, fontSize: 13)),
              Text(formatAmount(plan.salary), style: WfText.money(46, color: Colors.white, height: 1.2)),
            ]),
          ),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Row(children: [
          const Text('ادّخروا أول شي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const Spacer(),
          Segmented<int>(values: const [5, 10, 15, 20], selected: pct, label: (v) => '$v%', onChanged: (v) => setState(() => _pct = v)),
        ]),
      ),
      SizedBox(
        height: 210,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            for (final (name, value, color, d) in piles)
              Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Stack(clipBehavior: Clip.none, alignment: Alignment.topCenter, children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: const SpringCurve(),
                      width: 64,
                      height: math.max(10, value / max * 120),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [color, color, Colors.white.withValues(alpha: .55), Colors.white.withValues(alpha: .55)],
                          stops: const [0, .75, .75, 1],
                          tileMode: TileMode.repeated,
                        ),
                      ),
                    ),
                    Positioned(top: -10, child: Transform.rotate(angle: -.07, child: MiniNote(d, width: 70, showLabel: false))),
                  ]),
                  const SizedBox(height: 6),
                  Text(formatAmount(value), style: WfText.money(13, weight: FontWeight.w500, color: wf.ink)),
                  Text(name, style: TextStyle(fontSize: 12, color: wf.mute)),
                ]),
              ),
          ]),
        ),
      ),
      WfCard(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        radius: 18,
        child: Row(children: [
          Expanded(child: Text('يعني كل أسبوع\nللصرف حوالي', style: TextStyle(color: wf.mute, fontSize: 13, height: 1.5))),
          Odometer(value: split.weekly, style: WfText.money(32, color: wf.ink)),
        ]),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).viewPadding.bottom),
        child: PrimaryButton(
          label: 'وزّعوا الراتب',
          onPressed: _busy
              ? null
              : () async {
                  final card = snap.walletOfKind('qi_card');
                  if (card == null) return;
                  setState(() => _busy = true);
                  await ref.read(repositoryProvider).runPayday(salary: plan.salary, savePercent: pct, walletId: card.id);
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  Toaster.show(context, 'توزّع الراتب. الخزنة زادت ${formatAmount(split.save)}');
                },
        ),
      ),
    ]);
  }
}
