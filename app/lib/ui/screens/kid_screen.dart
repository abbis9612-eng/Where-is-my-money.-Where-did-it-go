library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../data/snapshot.dart';
import '../../state/providers.dart';
import '../format.dart';
import '../theme/theme.dart';
import '../widgets/banknote.dart';
import '../widgets/common.dart';

/// The child's own screen: three picture jars a non-reader understands.
class KidScreen extends ConsumerStatefulWidget {
  const KidScreen({super.key, required this.memberId});
  final String memberId;
  @override
  ConsumerState<KidScreen> createState() => _KidScreenState();
}

class _KidScreenState extends ConsumerState<KidScreen> with TickerProviderStateMixin {
  late final AnimationController _fly = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
  late final AnimationController _plus = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));
  final _saveJar = GlobalKey();
  final _saveBtn = GlobalKey();
  Offset? _from, _to;

  @override
  void dispose() {
    _fly.dispose();
    _plus.dispose();
    super.dispose();
  }

  Offset _center(GlobalKey k) {
    final box = k.currentContext!.findRenderObject()! as RenderBox;
    final stack = context.findRenderObject()! as RenderBox;
    return box.localToGlobal(box.size.center(Offset.zero), ancestor: stack);
  }

  Future<void> _save(KidView kid) async {
    setState(() {
      _from = _center(_saveBtn);
      _to = _center(_saveJar);
    });
    await _fly.forward(from: 0);
    await ref.read(repositoryProvider).kidDeposit(kid.member.id, 'save', 1000);
    HapticFeedback.mediumImpact();
    if (kid.profile.matchPercent > 0) _plus.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider).value;
    final kid = snap?.kids.where((k) => k.member.id == widget.memberId).firstOrNull;
    if (kid == null) return const Scaffold(body: SizedBox.shrink());
    final wf = Wf.of(context);
    final match = kid.profile.matchPercent * 10;
    return Scaffold(
      backgroundColor: wf.kidBg,
      appBar: AppBar(
        backgroundColor: wf.kidBg,
        title: Text('حصالة ${kid.member.displayName}', style: Theme.of(context).textTheme.titleLarge),
        leading: IconButton(tooltip: 'رجوع لبابا وماما', icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
      ),
      body: Stack(children: [
        ListView(padding: const EdgeInsets.only(bottom: 32), children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center, children: [
              _Jar(label: 'اصرف', icon: Icons.shopping_bag_outlined, value: kid.spend, capacity: 10000, width: 86, color: wf.mute),
              const SizedBox(width: 10),
              _Jar(key: _saveJar, label: 'احفظ', icon: Icons.pedal_bike, value: kid.save, capacity: kid.profile.goalMinor, width: 128, color: wf.kid),
              const SizedBox(width: 10),
              _Jar(label: 'صدقة', icon: Icons.favorite_border, value: kid.give, capacity: 5000, width: 86, color: const Color(0xFFB8913C)),
            ]),
          ),
          WfCard(
            margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            radius: 22,
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              Container(
                width: 86,
                height: 70,
                decoration: BoxDecoration(color: wf.kidBg, borderRadius: BorderRadius.circular(16)),
                child: Icon(Icons.pedal_bike, size: 44, color: wf.kid),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(kid.profile.goalName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text('${formatAmount(kid.save)} من ${formatAmount(kid.profile.goalMinor)}', style: WfText.money(12, weight: FontWeight.w400, color: wf.mute)),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      height: 12,
                      child: LayoutBuilder(builder: (_, box) {
                        final total = kid.profile.goalMinor <= 0 ? 1 : kid.profile.goalMinor;
                        final own = ((kid.save - kid.matched) / total).clamp(0.0, 1.0);
                        final added = (kid.matched / total).clamp(0.0, 1.0 - own);
                        return Stack(children: [
                          Container(color: wf.sunk),
                          AnimatedPositioned(duration: const Duration(milliseconds: 900), curve: const SpringCurve(), right: 0, top: 0, bottom: 0, width: box.maxWidth * own, child: Container(color: wf.kid)),
                          AnimatedPositioned(duration: const Duration(milliseconds: 900), curve: const SpringCurve(), right: box.maxWidth * own, top: 0, bottom: 0, width: box.maxWidth * added, child: Container(color: Wf.vaultGold)),
                        ]);
                      }),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text.rich(TextSpan(children: [
                    const TextSpan(text: 'منها '),
                    TextSpan(text: formatAmount(kid.matched), style: TextStyle(fontFamily: WfText.num, color: wf.goldInk, fontWeight: FontWeight.w600)),
                    TextSpan(text: ' من بابا: على كل ألف تحطه، يحطلك ${formatAmount(match)}'),
                  ]), style: TextStyle(fontSize: 12, color: wf.mute, height: 1.5)),
                ]),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(children: [
              Expanded(
                child: _BigButton(
                  key: _saveBtn,
                  icon: Icons.download_rounded,
                  label: 'حطّ ألف',
                  color: wf.kid,
                  fg: Colors.white,
                  onTap: _fly.isAnimating ? null : () => _save(kid),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _BigButton(
                  icon: Icons.icecream_outlined,
                  label: 'اشتريت حلوى',
                  color: wf.surface,
                  fg: wf.ink,
                  onTap: () async {
                    final ok = await ref.read(repositoryProvider).kidSpend(kid.member.id, 'spend', 1000, label: 'حلوى');
                    if (!context.mounted) return;
                    Toaster.show(context, ok ? 'انسجلت حلوى بألف من جرّة الصرف' : 'جرّة الصرف ما بيها ألف');
                  },
                ),
              ),
            ]),
          ),
          _Note(icon: Icons.calendar_month_outlined, title: 'الجمعة يجيك ${formatAmount(kid.profile.weeklyAllowance)}', body: 'وتقعد ويا بابا خمس دقايق: شنو اشتريت، وشكد بقى ${withLam(kid.profile.goalName)}'),
          const _Note(icon: Icons.favorite_border, title: 'جرّة الصدقة', body: 'كل أسبوع يختار وين يعطيها'),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48), foregroundColor: wf.kid, side: BorderSide(color: wf.kid)),
              onPressed: () async {
                await ref.read(repositoryProvider).kidAllowance(kid.member.id, kid.profile.weeklyAllowance);
                if (context.mounted) Toaster.show(context, 'نزل مصروف الأسبوع وتوزّع على الجرار الثلاث');
              },
              child: const Text('نزّلوا مصروف الأسبوع (للأهل)'),
            ),
          ),
        ]),
        if (_from != null && _to != null)
          AnimatedBuilder(
            animation: _fly,
            builder: (_, _) {
              if (!_fly.isAnimating && _fly.value == 0) return const SizedBox.shrink();
              final t = Curves.easeInOutCubic.transform(_fly.value);
              final mid = Offset((_from!.dx + _to!.dx) / 2, _from!.dy - 120);
              final p = Offset.lerp(Offset.lerp(_from, mid, t), Offset.lerp(mid, _to, t), t)!;
              return Positioned(
                left: p.dx - 27,
                top: p.dy - 12,
                child: IgnorePointer(child: Opacity(opacity: 1 - t * .7, child: Transform.rotate(angle: -.35 * t, child: Transform.scale(scale: 1 - .4 * t, child: const MiniNote(1000))))),
              );
            },
          ),
        if (_to != null)
          AnimatedBuilder(
            animation: _plus,
            builder: (_, _) => _plus.value == 0 || _plus.value == 1
                ? const SizedBox.shrink()
                : Positioned(
                    left: _to!.dx + 10,
                    top: _to!.dy - 60 - 40 * _plus.value,
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: 1 - _plus.value,
                        child: Text('+${formatAmount(match)} بابا', style: WfText.money(16, weight: FontWeight.w600, color: Wf.vaultGold)),
                      ),
                    ),
                  ),
          ),
      ]),
    );
  }
}

class _Jar extends StatelessWidget {
  const _Jar({super.key, required this.label, required this.icon, required this.value, required this.capacity, required this.width, required this.color});
  final String label;
  final IconData icon;
  final int value;
  final int capacity;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final fill = capacity <= 0 ? 0.0 : (value / capacity).clamp(0.0, 1.0);
    return Semantics(
      label: '$label ${formatAmount(value)}',
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TweenAnimationBuilder<double>(
          tween: Tween(end: fill),
          duration: const Duration(milliseconds: 900),
          curve: const SpringCurve(),
          builder: (_, f, _) => CustomPaint(size: Size(width, width * 1.25), painter: _JarPainter(fill: f, color: color, glass: wf.surface)),
        ),
        const SizedBox(height: 4),
        Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 16, color: wf.ink),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ]),
        Text(formatAmount(value), style: WfText.money(15, weight: FontWeight.w500, color: wf.ink)),
      ]),
    );
  }
}

class _JarPainter extends CustomPainter {
  _JarPainter({required this.fill, required this.color, required this.glass});
  final double fill;
  final Color color, glass;

  Path _jar(Size s) {
    final sx = s.width / 120, sy = s.height / 150;
    return Path()
      ..moveTo(30 * sx, 30 * sy)
      ..lineTo(90 * sx, 30 * sy)
      ..lineTo(90 * sx, 38 * sy)
      ..cubicTo(104 * sx, 44 * sy, 110 * sx, 56 * sy, 110 * sx, 72 * sy)
      ..lineTo(110 * sx, 124 * sy)
      ..cubicTo(110 * sx, 136 * sy, 102 * sx, 144 * sy, 90 * sx, 144 * sy)
      ..lineTo(30 * sx, 144 * sy)
      ..cubicTo(18 * sx, 144 * sy, 10 * sx, 136 * sy, 10 * sx, 124 * sy)
      ..lineTo(10 * sx, 72 * sy)
      ..cubicTo(10 * sx, 56 * sy, 16 * sx, 44 * sy, 30 * sx, 38 * sy)
      ..close();
  }

  @override
  void paint(Canvas c, Size s) {
    final jar = _jar(s);
    c.drawPath(jar, Paint()..color = glass);
    c.save();
    c.clipPath(jar);
    // Notes stacked inside, rising with the fill.
    final sx = s.width / 120, sy = s.height / 150;
    final shift = (1 - fill) * 118 * sy;
    const colors = [Color(0xFF1B675B), Color(0xFF8F3E2E), Color(0xFF2D4580), Color(0xFF80602A)];
    for (var i = 0; i < 12; i++) {
      c.save();
      final y = (140 - i * 11) * sy + shift;
      c.translate(60 * sx, y + 6 * sy);
      c.rotate((i.isOdd ? -3 : 3) * 3.14159 / 180);
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset.zero, width: (106 - (i % 2) * 8) * sx, height: 12 * sy), const Radius.circular(2)), Paint()..color = colors[i % 4]);
      c.restore();
    }
    c.restore();
    c.drawPath(jar, Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * sx);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(26 * sx, 14 * sy, 68 * sx, 16 * sy), const Radius.circular(5)), Paint()..color = color);
  }

  @override
  bool shouldRepaint(_JarPainter o) => o.fill != fill || o.color != color || o.glass != glass;
}

class _BigButton extends StatelessWidget {
  const _BigButton({super.key, required this.icon, required this.label, required this.color, required this.fg, this.onTap});
  final IconData icon;
  final String label;
  final Color color, fg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: color,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: SizedBox(
            height: 96,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, size: 34, color: fg),
              const SizedBox(height: 6),
              Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: fg)),
            ]),
          ),
        ),
      );
}

class _Note extends StatelessWidget {
  const _Note({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title, body;
  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return WfCard(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      radius: 18,
      padding: const EdgeInsets.all(12),
      child: Row(children: [
        Icon(icon, color: wf.kid, size: 28),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.5)),
            Text(body, style: TextStyle(fontSize: 13, color: wf.mute, height: 1.5)),
          ]),
        ),
      ]),
    );
  }
}
