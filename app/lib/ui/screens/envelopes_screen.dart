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
    final total = snap.envelopes.fold(0, (a, e) => a + e.balance);
    final free = snap.adults.map((m) => '${m.displayName} ${formatAmount(m.freeAllowance)}').join('، ');
    return SafeArea(
      bottom: false,
      child: ListView(padding: const EdgeInsets.only(bottom: 24), children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('الظروف', style: Theme.of(context).textTheme.headlineSmall),
            const Spacer(),
            Text('بكل الظروف ', style: TextStyle(color: wf.mute, fontSize: 13)),
            Text(formatAmount(total), style: WfText.money(15, weight: FontWeight.w600, color: wf.ink)),
          ]),
        ),
        if (vault != null) _VaultCard(view: vault, perPay: snap.monthlyPlan.saveFirst),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [for (final e in others) _Envelope(view: e)],
          ),
        ),
        WfCard(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          radius: 18,
          child: Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('المصروف الحر', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.5)),
                Text('كل واحد يصرفه بكيفه، وتفاصيله ما تبين للثاني', style: TextStyle(fontSize: 12, color: wf.mute, height: 1.5)),
              ]),
            ),
            Flexible(child: Text(free, textAlign: TextAlign.end, style: WfText.money(13, weight: FontWeight.w400, color: wf.mute, height: 1.5))),
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
            child: const Text('نزل الراتب؟ وزّعوه بدقيقة'),
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
      height: 176,
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
            const Text('مقفولة. ما تنفتح إلا باتفاق الاثنين', style: TextStyle(color: Wf.vaultMuted, fontSize: 12, height: 1.5)),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(children: [
                const TextSpan(text: 'كل راتب '),
                TextSpan(text: formatAmount(perPay), style: const TextStyle(color: Wf.vaultGold, fontWeight: FontWeight.w600, fontFamily: WfText.num)),
                TextSpan(text: months == 0 ? '\nوصلتوا الهدف' : '\nبهالسرعة توصلون الهدف ب${iraqiMonthName(reach.month)}'),
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
              Text('من ${formatAmount(target)}', style: const TextStyle(color: Wf.vaultMuted, fontSize: 11)),
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
  const _Envelope({required this.view});
  final EnvelopeView view;
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
    final monthly = e.monthlyMinor > 0 ? '${formatAmount(e.monthlyMinor)} كل شهر' : 'باقي ${formatAmount((e.targetMinor - widget.view.balance).clamp(0, 1 << 40))} للهدف';
    return Semantics(
      button: true,
      label: '${e.name}، ${formatAmount(widget.view.balance)} من ${formatAmount(e.targetMinor)}',
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
              height: box.maxHeight * .7,
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
                  if (e.memberId != null)
                    PositionedDirectional(
                      top: -18,
                      end: -4,
                      child: Container(
                        width: 34,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: wf.bg,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF2E8A6C), width: 1.5),
                        ),
                        child: Icon(Icons.add_a_photo_outlined, size: 15, color: wf.mute),
                      ),
                    ),
                  Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4)),
                    Text('${formatAmount(widget.view.balance)} من ${formatAmount(e.targetMinor)}', style: WfText.money(12, weight: FontWeight.w400, color: wf.mute, height: 1.4)),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(value: f, minHeight: 3, backgroundColor: wf.sunk, color: Theme.of(context).brightness == Brightness.dark ? wf.mint : wf.vault),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: _open ? Text(monthly, style: TextStyle(fontSize: 11, color: wf.ok, height: 1.6)) : const SizedBox(width: double.infinity),
                    ),
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
