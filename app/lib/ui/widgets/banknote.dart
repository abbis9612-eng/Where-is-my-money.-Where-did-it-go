/// The signature: the week's money as a stack of (original, invented) dinar
/// notes. Spending sends notes flying; change slides back in.
library;

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/money.dart';
import '../../domain/banknotes.dart';
import '../theme/theme.dart';
import 'guilloche.dart';

class _NoteStyle {
  const _NoteStyle(this.base, this.tint);
  final Color base;
  final Color tint;
}

const _styles = <int, _NoteStyle>{
  25000: _NoteStyle(Color(0xFF8F3E2E), Color(0xFFD7957A)),
  10000: _NoteStyle(Color(0xFF1B675B), Color(0xFF74BBA8)),
  5000: _NoteStyle(Color(0xFF2D4580), Color(0xFF859CD7)),
  1000: _NoteStyle(Color(0xFF80602A), Color(0xFFD3B274)),
  500: _NoteStyle(Color(0xFF55468A), Color(0xFFA797D8)),
  250: _NoteStyle(Color(0xFF287595), Color(0xFF86C4DC)),
};

Color noteColor(int d) => (_styles[d] ?? _styles[250]!).base;

/// Rendered once per denomination at 600×256 and reused everywhere.
class NoteArt {
  static final Map<int, ui.Image> _cache = {};

  static ui.Image image(int d) => _cache.putIfAbsent(d, () => _render(d));

  static ui.Image _render(int d) {
    const w = 600.0, h = 256.0;
    final st = _styles[d] ?? _styles[250]!;
    final rec = ui.PictureRecorder();
    final c = Canvas(rec);
    c.drawRect(
      const Rect.fromLTWH(0, 0, w, h),
      Paint()..shader = ui.Gradient.linear(const Offset(0, h), const Offset(w, 0), [st.tint, st.base, st.base], [0, .5, 1]),
    );
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var k = 0; k < 20; k++) {
      final p = Path();
      for (var x = 0.0; x <= w; x += 4) {
        final y = h * .6 + k * 3.3 + math.sin(x * .021 + k * .4) * 9 + math.sin(x * .006 + k) * 7;
        x == 0 ? p.moveTo(x, y) : p.lineTo(x, y);
      }
      c.drawPath(p, line..color = Colors.white.withValues(alpha: .09 + .06 * (k % 2)));
    }
    for (var k = 0; k < 10; k++) {
      final p = Path();
      for (var x = 0.0; x <= w; x += 4) {
        final y = 26 + k * 3 + math.sin(x * .03 + k * .5) * 4;
        x == 0 ? p.moveTo(x, y) : p.lineTo(x, y);
      }
      c.drawPath(p, line..color = Colors.white.withValues(alpha: .08));
    }
    drawRosette(c, const Offset(w * .2, h * .5), 74, 9, (k) => Colors.white.withValues(alpha: k % 4 == 0 ? .32 : .17), 30, stroke: .9);
    drawRosette(c, const Offset(w * .2, h * .5), 34, 12, (_) => Colors.white.withValues(alpha: .18), 14, stroke: .9);
    _palm(c, const Offset(w * .2, h * .47), 1.05, Colors.white.withValues(alpha: .42));
    c.drawRect(const Rect.fromLTWH(9, 9, w - 18, h - 18), Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withValues(alpha: .5));
    c.drawRect(const Rect.fromLTWH(15, 15, w - 30, h - 30), Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white.withValues(alpha: .22));
    final tp = TextPainter(
      text: TextSpan(text: 'وين فلوسي · رزمة الأسبوع · ' * 9, style: TextStyle(fontSize: 9, color: Colors.white.withValues(alpha: .34), fontFamily: WfText.ui)),
      textDirection: TextDirection.rtl,
      maxLines: 1,
    )..layout(maxWidth: w - 40);
    tp.paint(c, Offset(w - 20 - tp.width, h - 31));
    return rec.endRecording().toImageSync(w.toInt(), h.toInt());
  }

  static void _palm(Canvas c, Offset o, double s, Color col) {
    final p = Paint()
      ..color = col
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3 * s;
    final trunk = Path()
      ..moveTo(o.dx, o.dy + 40 * s)
      ..quadraticBezierTo(o.dx + 6 * s, o.dy + 10 * s, o.dx + 2 * s, o.dy - 14 * s);
    c.drawPath(trunk, p);
    p.strokeWidth = 2.2 * s;
    final top = Offset(o.dx + 2 * s, o.dy - 14 * s);
    for (final (a, l) in const [(-160.0, 26.0), (-130.0, 30.0), (-100.0, 24.0), (-75.0, 30.0), (-45.0, 28.0), (-20.0, 24.0), (-190.0, 22.0)]) {
      final r = a * math.pi / 180;
      final end = Offset(top.dx + math.cos(r) * l * s * 1.4, top.dy + math.sin(r) * l * s * 1.1 + 14 * s);
      c.drawPath(Path()
        ..moveTo(top.dx, top.dy)
        ..quadraticBezierTo((top.dx + end.dx) / 2, top.dy - 18 * s, end.dx, end.dy), p);
    }
    final dot = Paint()..color = col;
    for (var i = 0; i < 3; i++) {
      c.drawCircle(Offset(o.dx - 3 * s + i * 4 * s, o.dy - 8 * s + (i % 2) * 3 * s), 2.4 * s, dot);
    }
  }
}

/// A full note. Laid out at 300×128 and scaled to [width].
class Banknote extends StatelessWidget {
  const Banknote({super.key, required this.denomination, this.width = 300, this.foil = .4, this.showFoil = true, this.elevated = true});

  final int denomination;
  final double width;

  /// 0..1 position of the holographic shimmer.
  final double foil;
  final bool showFoil;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final text = TextStyle(color: Colors.white, shadows: [Shadow(color: Colors.black.withValues(alpha: .28), blurRadius: 2, offset: const Offset(0, 1))]);
    return SizedBox(
      width: width,
      height: width * 128 / 300,
      child: FittedBox(
        child: Container(
          width: 300,
          height: 128,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            boxShadow: elevated
                ? [
                    BoxShadow(color: Colors.black.withValues(alpha: .3), blurRadius: 24, offset: const Offset(0, 12), spreadRadius: -14),
                    BoxShadow(color: Colors.black.withValues(alpha: .14), blurRadius: 4, offset: const Offset(0, 2)),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Stack(children: [
              Positioned.fill(child: RawImage(image: NoteArt.image(denomination), fit: BoxFit.fill)),
              if (showFoil)
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 120,
                  width: 20,
                  child: Opacity(
                    opacity: .36,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        backgroundBlendMode: BlendMode.screen,
                        gradient: LinearGradient(
                          begin: Alignment(0, -1 - 2 * foil),
                          end: Alignment(0, 3 - 2 * foil),
                          colors: const [Color(0xFFF2D389), Color(0xFFA5E3D2), Color(0xFFBCAAF2), Color(0xFFF2AAB7), Color(0xFFF2D389)],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 10,
                right: 16,
                child: Text(formatAmount(denomination),
                    textDirection: TextDirection.ltr, style: WfText.money(30, weight: FontWeight.w600, height: 1).merge(text)),
              ),
              Positioned(top: 12, left: 16, child: Text(easternDigits(denomination), style: WfText.money(14, weight: FontWeight.w500, height: 1).merge(text))),
              Positioned(
                bottom: 18,
                right: 16,
                child: Text(noteWords(denomination), style: const TextStyle(fontFamily: WfText.brand, fontSize: 16, fontWeight: FontWeight.w700, height: 1.3).merge(text)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Small note chip with its spoken label, used in previews and lists.
class MiniNote extends StatelessWidget {
  const MiniNote(this.denomination, {super.key, this.width = 54, this.showLabel = true, this.ring});
  final int denomination;
  final double width;
  final bool showLabel;
  final Color? ring;

  @override
  Widget build(BuildContext context) {
    final h = width * 24 / 54;
    return Container(
      width: width,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          if (ring != null) BoxShadow(color: ring!, spreadRadius: 2),
          BoxShadow(color: Colors.black.withValues(alpha: .25), blurRadius: 4, offset: const Offset(0, 2), spreadRadius: -2),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(fit: StackFit.expand, children: [
          RawImage(image: NoteArt.image(denomination), fit: BoxFit.fill),
          if (showLabel)
            Center(
              child: Text(shortNoteLabel(denomination),
                  style: TextStyle(fontFamily: WfText.num, fontSize: h * .42, fontWeight: FontWeight.w600, color: Colors.white, height: 1)),
            ),
        ]),
      ),
    );
  }
}

class _Pose {
  const _Pose({this.dx = 0, this.dy = 0, this.rot = 0, this.scale = 1, this.opacity = 1});
  final double dx, dy, rot, scale, opacity;
}

class _NoteEntry {
  _NoteEntry(this.key, this.denomination);
  final int key;
  final int denomination;
  bool leaving = false;
  bool entering = true;
}

/// The stack on the week screen. Tap to spread the notes by denomination.
class NoteStack extends StatefulWidget {
  const NoteStack({super.key, required this.amount, this.height = 186});
  final int amount;
  final double height;

  @override
  State<NoteStack> createState() => _NoteStackState();
}

class _NoteStackState extends State<NoteStack> {
  final List<_NoteEntry> _notes = [];
  var _next = 0;
  var _spread = false;
  Offset _tilt = Offset.zero;

  @override
  void initState() {
    super.initState();
    for (final d in breakdown(widget.amount)) {
      _notes.add(_NoteEntry(_next++, d)..entering = false);
    }
  }

  @override
  void didUpdateWidget(NoteStack old) {
    super.didUpdateWidget(old);
    if (old.amount == widget.amount) return;
    final diff = diffNotes(old.amount, widget.amount);
    var delay = 0;
    for (final d in diff.removed) {
      final e = _notes.lastWhere((n) => n.denomination == d && !n.leaving, orElse: () => _notes.first);
      final wait = delay;
      delay += 90;
      Future.delayed(Duration(milliseconds: wait), () {
        if (!mounted) return;
        setState(() => e.leaving = true);
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) setState(() => _notes.remove(e));
        });
      });
    }
    Future.delayed(Duration(milliseconds: math.min(delay, 200) + 120), () {
      if (!mounted) return;
      setState(() {
        for (final d in diff.added) {
          final e = _NoteEntry(_next++, d);
          final at = _notes.indexWhere((n) => !n.leaving && n.denomination > d);
          at < 0 ? _notes.add(e) : _notes.insert(at, e);
        }
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          for (final n in _notes) {
            n.entering = false;
          }
        });
      });
    });
  }

  Map<int, _Pose> _poses(double width) {
    final live = _notes.where((n) => !n.leaving).toList();
    final poses = <int, _Pose>{};
    if (!_spread) {
      for (var i = 0; i < live.length; i++) {
        final depth = live.length - 1 - i;
        final v = math.min(depth, 6);
        poses[live[i].key] = _Pose(
          dx: depth == 0 ? 0 : (((i * 53) % 9) - 4) * 1.8,
          dy: -v * 8.0,
          rot: depth == 0 ? 0 : (((i * 37) % 7) - 3) * .8 * math.pi / 180,
          opacity: depth > 6 ? 0 : 1,
        );
      }
      return poses;
    }
    final groups = <int, List<_NoteEntry>>{};
    for (final n in live.reversed) {
      groups.putIfAbsent(n.denomination, () => []).add(n);
    }
    final keys = groups.keys.toList();
    final cols = math.min(3, keys.length);
    const sc = .34, pw = 300 * sc, ph = 128 * sc, gx = 14.0, gy = 44.0;
    final rows = (keys.length / math.max(cols, 1)).ceil();
    final totH = rows * ph + (rows - 1) * gy;
    for (var gi = 0; gi < keys.length; gi++) {
      final c = gi % cols, r = gi ~/ cols;
      final inRow = math.min(cols, keys.length - r * cols);
      final rowW = inRow * pw + (inRow - 1) * gx;
      final cx = rowW / 2 - pw / 2 - c * (pw + gx);
      final cy = -totH / 2 + ph / 2 + r * (ph + gy) - 8;
      final g = groups[keys[gi]]!;
      for (var k = 0; k < g.length; k++) {
        poses[g[k].key] = _Pose(dx: cx, dy: cy + 14 - k * 4, scale: sc, opacity: k > 5 ? 0 : 1);
      }
    }
    return poses;
  }

  List<Widget> _labels() {
    if (!_spread) return const [];
    final live = _notes.where((n) => !n.leaving).toList();
    final groups = <int, int>{};
    for (final n in live.reversed) {
      groups[n.denomination] = (groups[n.denomination] ?? 0) + 1;
    }
    final keys = groups.keys.toList();
    final cols = math.min(3, keys.length);
    const sc = .34, pw = 300 * sc, ph = 128 * sc, gx = 14.0, gy = 44.0;
    final rows = (keys.length / math.max(cols, 1)).ceil();
    final totH = rows * ph + (rows - 1) * gy;
    final out = <Widget>[];
    for (var gi = 0; gi < keys.length; gi++) {
      final c = gi % cols, r = gi ~/ cols;
      final inRow = math.min(cols, keys.length - r * cols);
      final rowW = inRow * pw + (inRow - 1) * gx;
      final cx = rowW / 2 - pw / 2 - c * (pw + gx);
      final cy = -totH / 2 + ph / 2 + r * (ph + gy) - 8;
      final n = groups[keys[gi]]!;
      out.add(Align(
        alignment: Alignment.center,
        child: Transform.translate(
          offset: Offset(cx, cy + 28 + ph / 2 + 16),
          child: Text(n == 1 ? 'ورقة وحدة' : n == 2 ? 'ورقتين' : '$n أوراق', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Wf.of(context).ink, fontWeight: FontWeight.w600)),
        ),
      ));
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.of(context).disableAnimations;
    final count = _notes.where((n) => !n.leaving).length;
    return Semantics(
      button: true,
      label: _spread ? 'الرزمة: $count أوراق. دوسوا حتى ترجع' : 'رزمة الأسبوع، دوسوا حتى تشوفون الأوراق',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _spread = !_spread);
        },
        onPanUpdate: reduce ? null : (d) => setState(() => _tilt = Offset((_tilt.dx + d.delta.dx / 300).clamp(-.5, .5), (_tilt.dy + d.delta.dy / 300).clamp(-.5, .5))),
        onPanEnd: (_) => setState(() => _tilt = Offset.zero),
        child: SizedBox(
          height: widget.height,
          child: LayoutBuilder(builder: (context, box) {
            final poses = _poses(box.maxWidth);
            return TweenAnimationBuilder<Offset>(
              tween: Tween(end: _tilt),
              duration: const Duration(milliseconds: 400),
              curve: const SpringCurve(damping: .7),
              builder: (context, tilt, child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, .0011)
                  ..rotateX(-tilt.dy * .4)
                  ..rotateY(tilt.dx * .5),
                child: child,
              ),
              child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
                for (final n in _notes)
                  _AnimatedNote(
                    key: ValueKey(n.key),
                    pose: n.leaving
                        ? _Pose(dx: (poses[n.key]?.dx ?? 0) - 150, dy: -260, rot: -28 * math.pi / 180, scale: .55, opacity: 0)
                        : n.entering
                            ? const _Pose(dx: 60, dy: 240, rot: 14 * math.pi / 180, opacity: 0)
                            : poses[n.key] ?? const _Pose(),
                    leaving: n.leaving,
                    reduceMotion: reduce,
                    child: Banknote(denomination: n.denomination, foil: .4 + _tilt.dx, showFoil: n == _notes.lastWhere((x) => !x.leaving, orElse: () => n)),
                  ),
                ..._labels(),
              ]),
            );
          }),
        ),
      ),
    );
  }
}

class _AnimatedNote extends ImplicitlyAnimatedWidget {
  const _AnimatedNote({super.key, required this.pose, required this.child, required this.leaving, required bool reduceMotion})
      : super(
          duration: reduceMotion ? Duration.zero : (leaving ? const Duration(milliseconds: 560) : const Duration(milliseconds: 700)),
          curve: leaving ? const Cubic(.55, 0, .8, .3) : const SpringCurve(damping: .55),
        );

  final _Pose pose;
  final Widget child;
  final bool leaving;

  @override
  ImplicitlyAnimatedWidgetState<_AnimatedNote> createState() => _AnimatedNoteState();
}

class _AnimatedNoteState extends AnimatedWidgetBaseState<_AnimatedNote> {
  Tween<double>? _dx, _dy, _rot, _scale, _opacity;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    final p = widget.pose;
    _dx = visitor(_dx, p.dx, (v) => Tween<double>(begin: v as double)) as Tween<double>?;
    _dy = visitor(_dy, p.dy, (v) => Tween<double>(begin: v as double)) as Tween<double>?;
    _rot = visitor(_rot, p.rot, (v) => Tween<double>(begin: v as double)) as Tween<double>?;
    _scale = visitor(_scale, p.scale, (v) => Tween<double>(begin: v as double)) as Tween<double>?;
    _opacity = visitor(_opacity, p.opacity, (v) => Tween<double>(begin: v as double)) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    final a = animation;
    final o = (_opacity?.evaluate(a) ?? 1).clamp(0.0, 1.0);
    return Opacity(
      opacity: o,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translateByDouble(_dx?.evaluate(a) ?? 0, (_dy?.evaluate(a) ?? 0) + 14, 0, 1)
          ..rotateZ(_rot?.evaluate(a) ?? 0)
          ..scaleByDouble(_scale?.evaluate(a) ?? 1, _scale?.evaluate(a) ?? 1, 1, 1),
        child: widget.child,
      ),
    );
  }
}
