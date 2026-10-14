library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../domain/banknotes.dart';
import '../../state/providers.dart';
import '../../domain/barakah.dart';
import '../widgets/barakah_card.dart';
import '../theme/theme.dart';
import '../widgets/banknote.dart';
import '../widgets/common.dart';
import '../widgets/odometer.dart';

/// Friday: drag what is left of the week into the vault, then one question.
class FridayScreen extends ConsumerStatefulWidget {
  const FridayScreen({super.key});
  @override
  ConsumerState<FridayScreen> createState() => _FridayScreenState();
}

class _FridayScreenState extends ConsumerState<FridayScreen> {
  List<int>? _notes;
  var _deposited = 0;
  var _stamped = false;
  String? _answer;

  Future<void> _deposit(int index, int denom) async {
    setState(() {
      _notes![index] = 0;
      _deposited += denom;
    });
    HapticFeedback.mediumImpact();
    final snap = ref.read(snapshotProvider).value!;
    await ref.read(repositoryProvider).closeWeek(weekStart: snap.week.weekStart, leftover: snap.week.left, toVault: denom);
    if (_notes!.every((n) => n == 0)) {
      HapticFeedback.heavyImpact();
      setState(() => _stamped = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider).value;
    if (snap == null) return const Scaffold();
    final wf = Wf.of(context);
    final left = snap.week.left - _deposited;
    _notes ??= breakdown(snap.week.left).reversed.take(4).toList();
    final vault = snap.vault?.balance ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('جلسة الجمعة', style: Theme.of(context).textTheme.titleLarge),
        leading: IconButton(tooltip: 'سكّر', icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        actions: [Padding(padding: const EdgeInsetsDirectional.only(end: 16), child: Center(child: Text('دقيقتين، سؤالين', style: TextStyle(color: wf.mute, fontSize: 13))))],
      ),
      body: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text.rich(
            _stamped
                ? TextSpan(children: [const TextSpan(text: 'الخزنة صارت '), TextSpan(text: formatAmount(vault), style: const TextStyle(fontFamily: WfText.num, fontWeight: FontWeight.w600)), const TextSpan(text: '. عاشت إيدكم.')])
                : snap.week.left <= 0
                    ? const TextSpan(text: 'هالأسبوع ما بقى شي. عادي، المهم نعرف ليش.')
                    : TextSpan(children: [const TextSpan(text: 'خلص الأسبوع وبقى '), TextSpan(text: formatAmount(left), style: const TextStyle(fontFamily: WfText.num, fontWeight: FontWeight.w600)), const TextSpan(text: '. ودّوها للخزنة؟')]),
            style: const TextStyle(fontSize: 15, height: 1.6),
          ),
        ),
        if (snap.week.left > 0) ...[
          Container(
            margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            height: 286,
            decoration: BoxDecoration(color: wf.surface, borderRadius: BorderRadius.circular(26)),
            child: Stack(clipBehavior: Clip.none, children: [
              for (var i = _notes!.length - 1; i >= 0; i--)
                if (_notes![i] != 0) _draggable(i, _notes![i]),
              Positioned(
                left: 14,
                right: 14,
                bottom: 14,
                child: DragTarget<int>(
                  onAcceptWithDetails: (d) => _deposit(d.data, _notes![d.data]),
                  builder: (context, candidates, _) => AnimatedScale(
                  scale: candidates.isNotEmpty ? 1.03 : 1,
                  duration: const Duration(milliseconds: 250),
                  curve: const SpringCurve(),
                  child: Container(
                  height: 78,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Wf.vaultGreen,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: candidates.isNotEmpty ? const [BoxShadow(color: Wf.vaultGold, spreadRadius: 3)] : null,
                  ),
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 120,
                        height: 5,
                        decoration: BoxDecoration(color: const Color(0xFF06201B), borderRadius: BorderRadius.circular(3), boxShadow: const [BoxShadow(color: Wf.vaultGold, offset: Offset(0, 1))]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(children: [
                        const Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('اسحبوا الأوراق هنا', style: TextStyle(color: Wf.vaultMuted, fontSize: 12)),
                          Text('الخزنة', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                        ]),
                        const Spacer(),
                        Odometer(value: vault, style: WfText.money(22, color: Wf.vaultGold)),
                      ]),
                    ),
                  ]),
                ),
                ),
                ),
              ),
              Positioned(
                top: 44,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: _stamped ? .92 : 0,
                    duration: const Duration(milliseconds: 150),
                    child: AnimatedScale(
                      scale: _stamped ? 1 : 2.2,
                      duration: const Duration(milliseconds: 450),
                      curve: const SpringCurve(damping: .45),
                      child: Center(
                        child: Transform.rotate(
                          angle: -.21,
                          child: Container(
                            width: 132,
                            height: 132,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: wf.goldInk, width: 3)),
                            child: Container(
                              margin: const EdgeInsets.all(7),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: wf.goldInk, width: 1.5)),
                              child: Text('عاشت\nإيدكم', textAlign: TextAlign.center, style: TextStyle(fontFamily: WfText.brand, fontSize: 25, height: 1.15, color: wf.goldInk)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          if (!_stamped)
            Center(
              child: TextButton(
                onPressed: () async {
                  for (var i = 0; i < _notes!.length; i++) {
                    if (_notes![i] != 0) await _deposit(i, _notes![i]);
                  }
                  final rest = snap.week.left - _deposited;
                  if (rest > 0) await ref.read(repositoryProvider).closeWeek(weekStart: snap.week.weekStart, leftover: snap.week.left, toVault: rest);
                },
                child: const Text('ودّوها كلها للخزنة'),
              ),
            ),
        ],
        if (snap.sadaqa != null && snap.week.left - _deposited >= 1000)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              icon: const Icon(Icons.volunteer_activism_outlined),
              label: Text('حطّوا ${inThousands(_sadaqaShare(snap.week.left - _deposited))} من الفائض بظرف الصدقة'),
              onPressed: () async {
                final amt = _sadaqaShare(snap.week.left - _deposited);
                setState(() => _deposited += amt);
                await ref.read(repositoryProvider).closeWeek(weekStart: snap.week.weekStart, leftover: snap.week.left, toVault: amt, envelopeId: snap.sadaqa!.envelope.id);
                if (context.mounted) Toaster.show(context, 'تقبّل الله. انحطّت ${inThousands(amt)} بظرف الصدقة');
              },
            ),
          ),
        BarakahCard(place: BarakahPlace.friday, day: snap.now),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
          child: Text('شنو فاجأكم هالأسبوع؟', style: Theme.of(context).textTheme.titleLarge),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Wrap(spacing: 8, runSpacing: 8, children: [
            for (final (k, label) in const [('car', 'تصليح سيارة'), ('gift', 'مناسبة أو هدية'), ('med', 'علاج'), ('none', 'ولا شي')])
              WfChip(label: label, selected: _answer == k, onTap: () => setState(() => _answer = k)),
          ]),
        ),
        if (_answer != null) _suggestion(context),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('الأسبوع الجاي إلكم', style: TextStyle(color: wf.mute, fontSize: 13)),
            const Spacer(),
            Text(formatAmount(snap.weeklyAllowance), style: WfText.money(26, color: wf.ink)),
          ]),
        ),
      ]),
    );
  }

  /// A tenth of what is left, at least a thousand, in whole thousands.
  int _sadaqaShare(int rest) => (rest ~/ 10 ~/ 1000 * 1000).clamp(1000, rest ~/ 1000 * 1000);

  Widget _draggable(int i, int d) {
    final note = AnimatedRotation(
      turns: (i.isEven ? -4 : 5) / 360,
      duration: const Duration(milliseconds: 200),
      child: Banknote(denomination: d, width: 222),
    );
    return Positioned(
      top: 18.0 + i * 46,
      left: 0,
      right: 0,
      child: Center(
        child: Semantics(
          button: true,
          label: 'ورقة ${formatAmount(d)}، اسحبوها للخزنة أو دوسوها مرتين',
          child: GestureDetector(
            onDoubleTap: () => _deposit(i, d),
            child: Draggable<int>(
              data: i,
              onDragStarted: HapticFeedback.selectionClick,
              feedback: Material(color: Colors.transparent, child: Transform.scale(scale: 1.04, child: Banknote(denomination: d, width: 222))),
              childWhenDragging: const SizedBox(width: 222, height: 95),
              child: note,
            ),
          ),
        ),
      ),
    );
  }

  Widget _suggestion(BuildContext context) {
    final wf = Wf.of(context);
    final (title, body, action, envelope, monthly) = switch (_answer!) {
      'car' => ('تصليح السيارة يرجع، مو مفاجأة', 'نفتح ظرف «السيارة» بـ15,000 بالشهر؟ المرة الجاية تلقونه جاهز.', true, 'السيارة', 15000),
      'gift' => ('المناسبات تتكرر كل شهر تقريباً', 'نفتح ظرف «مناسبات» بـ25,000 بالشهر؟', true, 'مناسبات', 25000),
      'med' => ('العلاج يجي فجأة', 'نزيد ظرف العلاج 10,000 بالشهر؟', true, 'العلاج', 10000),
      _ => ('أسبوع هادئ، عاشت إيدكم', 'ماكو شي يحتاج تغيير. نشوفكم الجمعة الجاية.', false, '', 0),
    };
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: wf.tint, borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: wf.tintInk, fontSize: 15, fontWeight: FontWeight.w600)),
        Text(body, style: TextStyle(color: wf.tintInk, fontSize: 14, height: 1.6)),
        if (action)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(children: [
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Wf.vaultGreen, foregroundColor: Colors.white),
                onPressed: () async {
                  final repo = ref.read(repositoryProvider);
                  final snap = ref.read(snapshotProvider).value;
                  final existing = snap?.envelopes.where((e) => e.envelope.name == envelope).firstOrNull;
                  if (existing == null) {
                    await repo.addEnvelope(name: envelope, monthly: monthly, note: 250);
                  } else {
                    await repo.setEnvelopeMonthly(existing.envelope.id, existing.envelope.monthlyMinor + monthly);
                  }
                  if (!context.mounted) return;
                  setState(() => _answer = null);
                  Toaster.show(context, existing == null ? 'انفتح ظرف «$envelope» بـ${formatAmount(monthly)} بالشهر' : 'زاد ظرف «$envelope» ${formatAmount(monthly)} بالشهر');
                },
                child: const Text('سوّوها'),
              ),
              TextButton(onPressed: () => setState(() => _answer = null), child: const Text('بعدين')),
            ]),
          ),
      ]),
    );
  }
}
