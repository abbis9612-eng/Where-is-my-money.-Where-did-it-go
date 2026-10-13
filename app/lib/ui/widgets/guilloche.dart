/// Guilloche: the engraved line patterns of banknotes, drawn procedurally.
/// Original artwork; it imitates no real note.
library;

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void drawRosette(Canvas canvas, Offset c, double r, int petals, Color Function(int line) color, int lines, {double stroke = 1}) {
  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = stroke
    ..isAntiAlias = true;
  for (var k = 0; k < lines; k++) {
    final path = Path();
    for (var i = 0; i <= 524; i++) {
      final t = i / 524 * 2 * math.pi;
      final rr = r + r * .32 * math.sin(petals * t + k * .19) * math.cos(2 * t + k * .05);
      final p = Offset(c.dx + rr * math.cos(t), c.dy + rr * math.sin(t));
      i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(path, paint..color = color(k));
  }
}

/// A slowly turning rosette for dark vault cards.
class RosettePainter extends CustomPainter {
  const RosettePainter({required this.color, this.lines = 30, this.petals = 10});
  final Color color;
  final int lines;
  final int petals;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide * .33;
    drawRosette(canvas, c, r, petals, (k) => color.withValues(alpha: k % 4 == 0 ? .34 : .16), lines);
    drawRosette(canvas, c, r * .52, petals + 4, (_) => color.withValues(alpha: .15), 16);
  }

  @override
  bool shouldRepaint(RosettePainter old) => old.color != color || old.lines != lines;
}

class Rosette extends StatefulWidget {
  const Rosette({super.key, required this.size, this.color = const Color(0xFF9FD8C4), this.spin = true});
  final double size;
  final Color color;
  final bool spin;

  @override
  State<Rosette> createState() => _RosetteState();
}

class _RosetteState extends State<Rosette> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 140));
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    if (widget.spin) _c.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) _c.stop();
  }

  ui.Image _render(double size, double dpr) {
    final rec = ui.PictureRecorder();
    final canvas = Canvas(rec);
    final px = (size * dpr).ceil();
    canvas.scale(dpr);
    RosettePainter(color: widget.color).paint(canvas, Size.square(size));
    return rec.endRecording().toImageSync(px, px);
  }

  @override
  void dispose() {
    _c.dispose();
    _image?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    _image ??= _render(widget.size, dpr);
    return SizedBox.square(
      dimension: widget.size,
      child: RotationTransition(turns: _c, child: RawImage(image: _image, width: widget.size, height: widget.size)),
    );
  }
}
