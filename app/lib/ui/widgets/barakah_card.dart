library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/barakah.dart';
import '../../state/providers.dart';
import '../theme/theme.dart';

/// One verse, hadith or du'a that fits this moment, with its source.
/// Shows nothing when «لمسة بركة» is off or no text fits.
class BarakahCard extends ConsumerWidget {
  const BarakahCard({super.key, required this.place, this.day, this.margin = const EdgeInsets.fromLTRB(16, 12, 16, 0), this.onDark = false});
  final BarakahPlace place;
  final DateTime? day;
  final EdgeInsets margin;

  /// Drawn on the green vault colour (payday sheet) instead of a card.
  final bool onDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!(ref.watch(barakahOnProvider).value ?? true)) return const SizedBox.shrink();
    final t = barakahFor(place, day ?? DateTime.now());
    if (t == null) return const SizedBox.shrink();
    return Padding(padding: margin, child: BarakahBody(text: t, onDark: onDark));
  }
}

class BarakahBody extends StatelessWidget {
  const BarakahBody({super.key, required this.text, this.onDark = false, this.showNote = true});
  final BarakahText text;
  final bool onDark;
  final bool showNote;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final ink = onDark ? Wf.vaultText : wf.ink;
    final mute = onDark ? Wf.vaultMuted : wf.mute;
    final accent = onDark ? Wf.vaultGold : wf.goldInk;
    final label = switch (text.kind) { BarakahKind.quran => 'آية', BarakahKind.hadith => 'حديث', BarakahKind.dua => 'دعاء' };
    final body = text.kind == BarakahKind.quran ? '﴿${text.text}﴾' : '«${text.text}»';
    return Semantics(
      container: true,
      label: '$label: ${text.text}. ${text.citation}',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: onDark ? Colors.white.withValues(alpha: .06) : wf.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: onDark ? Colors.white.withValues(alpha: .12) : wf.line),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.auto_stories_outlined, size: 16, color: accent),
            const SizedBox(width: 6),
            Text('لمسة بركة · $label', style: TextStyle(fontSize: 12, color: accent, fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 6),
          Text(body, style: TextStyle(fontSize: 16, height: 1.9, color: ink, fontWeight: FontWeight.w500)),
          if (showNote && text.note.isNotEmpty) Text(text.note, style: TextStyle(fontSize: 13, height: 1.7, color: mute)),
          const SizedBox(height: 4),
          Text(text.citation, style: TextStyle(fontSize: 11.5, height: 1.5, color: mute)),
        ]),
      ),
    );
  }
}
