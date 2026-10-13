/// Rolling digits: when a number changes, each digit turns like a counter.
library;

import 'package:flutter/material.dart';

import '../../core/money.dart';
import '../theme/theme.dart';

class Odometer extends StatelessWidget {
  const Odometer({super.key, required this.value, required this.style, this.prefix = '', this.semanticsSuffix = ''});

  final int value;
  final TextStyle style;
  final String prefix;
  final String semanticsSuffix;

  @override
  Widget build(BuildContext context) {
    final text = '$prefix${formatAmount(value)}';
    final size = style.fontSize ?? 16;
    final lineH = size * 1.15;
    final reduce = MediaQuery.of(context).disableAnimations;
    final chars = text.split('');
    return Semantics(
      label: '$text $semanticsSuffix',
      excludeSemantics: true,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          for (var i = 0; i < chars.length; i++)
            if (RegExp(r'\d').hasMatch(chars[i]))
              _Digit(key: ValueKey('d${chars.length - i}'), digit: int.parse(chars[i]), style: style, lineHeight: lineH, reduce: reduce)
            else
              SizedBox(height: lineH, child: Text(chars[i], style: style.copyWith(height: 1.15))),
        ]),
      ),
    );
  }
}

class _Digit extends StatelessWidget {
  const _Digit({super.key, required this.digit, required this.style, required this.lineHeight, required this.reduce});
  final int digit;
  final TextStyle style;
  final double lineHeight;
  final bool reduce;

  @override
  Widget build(BuildContext context) {
    final tp = TextPainter(text: TextSpan(text: '0', style: style.copyWith(height: 1.15)), textDirection: TextDirection.ltr)..layout();
    return SizedBox(
      width: tp.width,
      height: lineHeight,
      child: ClipRect(
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: digit.toDouble()),
          duration: reduce ? Duration.zero : const Duration(milliseconds: 750),
          curve: const SpringCurve(damping: .6),
          builder: (context, v, child) => OverflowBox(
            alignment: Alignment.topCenter,
            minHeight: lineHeight * 10,
            maxHeight: lineHeight * 10,
            child: Transform.translate(offset: Offset(0, -v * lineHeight), child: child),
          ),
          child: Column(children: [
            for (var d = 0; d < 10; d++) SizedBox(height: lineHeight, child: Center(child: Text('$d', style: style.copyWith(height: 1.15)))),
          ]),
        ),
      ),
    );
  }
}
