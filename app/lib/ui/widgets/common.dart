library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

import '../../data/database.dart';
import '../theme/theme.dart';

/// Phone-style number pad. Always left-to-right like every phone keypad.
class Keypad extends StatelessWidget {
  const Keypad({super.key, required this.onKey, this.keyHeight = 56});
  final ValueChanged<String> onKey;
  final double keyHeight;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '000', '0', 'del'];
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: (MediaQuery.of(context).size.width - 28) / 3 / keyHeight,
        children: [
          for (final k in keys)
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                highlightColor: wf.press,
                onTap: () {
                  HapticFeedback.selectionClick();
                  onKey(k);
                },
                child: Semantics(
                  button: true,
                  label: k == 'del' ? 'امسح' : k,
                  child: Center(
                    child: k == 'del'
                        ? Icon(Icons.backspace_outlined, color: wf.ink, size: 24)
                        : Text(k, style: WfText.money(26, weight: FontWeight.w400, color: wf.ink)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Applies a keypad key to a digit string, with a length cap and no leading zeros.
String applyKey(String current, String key, {int maxLength = 9}) {
  if (key == 'del') return current.isEmpty ? current : current.substring(0, current.length - 1);
  if (current.isEmpty && (key == '0' || key == '000')) return current;
  final next = current + key;
  return next.length > maxLength ? current : next;
}

class Segmented<T> extends StatelessWidget {
  const Segmented({super.key, required this.values, required this.selected, required this.label, required this.onChanged});
  final List<T> values;
  final T selected;
  final String Function(T) label;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: wf.sunk, borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        for (final v in values)
          Semantics(
            selected: v == selected,
            button: true,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                onChanged(v);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                constraints: const BoxConstraints(minWidth: 44, minHeight: 36),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: v == selected ? wf.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: v == selected ? [BoxShadow(color: wf.shadow, blurRadius: 2, offset: const Offset(0, 1))] : null,
                ),
                child: Text(label(v),
                    style: TextStyle(fontSize: 13, fontWeight: v == selected ? FontWeight.w600 : FontWeight.w400, color: v == selected ? wf.ink : wf.mute)),
              ),
            ),
          ),
      ]),
    );
  }
}

class WfChip extends StatelessWidget {
  const WfChip({super.key, required this.label, this.selected = false, this.onTap, this.tag, this.trailing});
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final String? tag;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final fg = selected ? wf.onPrimary : wf.ink;
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? wf.primary : wf.surface,
        shape: StadiumBorder(side: BorderSide(color: selected ? wf.primary : wf.line)),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap == null
              ? null
              : () {
                  HapticFeedback.selectionClick();
                  onTap!();
                },
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(label, style: TextStyle(fontSize: 14, color: fg)),
              if (trailing != null) ...[const SizedBox(width: 6), Text(trailing!, style: WfText.money(13, weight: FontWeight.w500, color: fg))],
              if (tag != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(color: selected ? Colors.white24 : wf.okBg, borderRadius: BorderRadius.circular(99)),
                  child: Text(tag!, style: TextStyle(fontSize: 10, color: selected ? fg : wf.ok)),
                ),
              ],
            ]),
          ),
        ),
      ),
    );
  }
}

class MemberAvatar extends StatelessWidget {
  const MemberAvatar(this.member, {super.key, this.size = 30, this.dim = false});
  final Member member;
  final double size;
  final bool dim;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return Semantics(
      label: member.displayName,
      child: Opacity(
        opacity: dim ? .45 : 1,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: wf.memberColor(member.colorIndex), shape: BoxShape.circle),
          child: Text(member.letter, style: TextStyle(color: Colors.white, fontSize: size * .4, fontWeight: FontWeight.w600, height: 1)),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.trailing, this.padding = const EdgeInsets.fromLTRB(20, 20, 20, 8)});
  final String title;
  final String? trailing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: padding,
      child: Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
        Expanded(child: Semantics(header: true, child: Text(title, style: t.titleMedium))),
        if (trailing != null) Text(trailing!, style: t.labelMedium),
      ]),
    );
  }
}

class WfCard extends StatelessWidget {
  const WfCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.margin = const EdgeInsets.symmetric(horizontal: 16), this.color, this.radius = 20, this.onTap});
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color? color;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return Padding(
      padding: margin,
      child: Material(
        color: color ?? wf.surface,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, this.onPressed, this.danger = false, this.height = 56, this.background, this.foreground});
  final String label;
  final VoidCallback? onPressed;
  final bool danger;
  final double height;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final bg = background ?? (danger ? wf.alert : wf.primary);
    final fg = foreground ?? (danger ? Colors.white : wf.onPrimary);
    return SizedBox(
      height: height,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: bg.withValues(alpha: .35),
          disabledForegroundColor: fg.withValues(alpha: .8),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontFamily: WfText.ui, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed == null
            ? null
            : () {
                HapticFeedback.mediumImpact();
                onPressed!();
              },
        child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

/// Bottom sheet with the design's rounded top and drag-to-close.
Future<T?> showWfSheet<T>(BuildContext context, WidgetBuilder builder, {double heightFactor = .9}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => SizedBox(height: MediaQuery.of(ctx).size.height * heightFactor, child: builder(ctx)),
  );
}

/// Top toast with an optional undo, matching the prototype.
class Toaster {
  static OverlayEntry? _entry;
  static Timer? _timer;

  static void show(BuildContext context, String message, {VoidCallback? onUndo}) {
    _timer?.cancel();
    _entry?.remove();
    final overlay = Overlay.of(context, rootOverlay: true);
    final key = GlobalKey<_ToastState>();
    _entry = OverlayEntry(builder: (_) => _Toast(key: key, message: message, onUndo: onUndo, onClose: hide));
    overlay.insert(_entry!);
    HapticFeedback.lightImpact();
    SemanticsService.sendAnnouncement(View.of(context), message, TextDirection.rtl);
    _timer = Timer(const Duration(milliseconds: 4200), () => key.currentState?.close());
  }

  static void hide() {
    _timer?.cancel();
    _entry?.remove();
    _entry = null;
  }
}

class _Toast extends StatefulWidget {
  const _Toast({super.key, required this.message, required this.onClose, this.onUndo});
  final String message;
  final VoidCallback? onUndo;
  final VoidCallback onClose;

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 520))..forward();

  Future<void> close() async {
    if (!mounted) return;
    await _c.reverse();
    widget.onClose();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final top = MediaQuery.of(context).padding.top + 8;
    return Positioned(
      top: top,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: Tween(begin: const Offset(0, -1.6), end: Offset.zero).animate(CurvedAnimation(parent: _c, curve: const SpringCurve(damping: .7), reverseCurve: Curves.easeIn)),
        child: Material(
          color: wf.primary,
          borderRadius: BorderRadius.circular(16),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(18, 6, 8, 6),
            child: Row(children: [
              Expanded(child: Text(widget.message, style: TextStyle(color: wf.onPrimary, fontSize: 14, height: 1.5))),
              if (widget.onUndo != null)
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: wf.onPrimary, backgroundColor: wf.onPrimary.withValues(alpha: .14), minimumSize: const Size(64, 40)),
                  onPressed: () {
                    widget.onUndo!();
                    close();
                  },
                  child: const Text('تراجع'),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}

IconData billIcon(String name) => switch (name) {
      'bolt' => Icons.bolt_outlined,
      'wifi' => Icons.wifi,
      'phone' => Icons.smartphone_outlined,
      'bus' => Icons.directions_bus_outlined,
      'home' => Icons.home_outlined,
      _ => Icons.receipt_long_outlined,
    };
