library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../data/demo.dart';
import '../../data/repository.dart';
import '../../domain/banknotes.dart';
import '../../domain/budget.dart';
import '../../state/providers.dart';
import '../theme/theme.dart';
import '../widgets/banknote.dart';
import '../widgets/guilloche.dart';
import '../widgets/odometer.dart';

/// First launch: five short steps and the first stack of notes.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _Fixed {
  _Fixed(this.name, this.icon, this.amount, this.category, {this.on = true, this.amps, this.price});
  final String name, icon, category;
  int amount;
  bool on;
  final int? amps, price;
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _page = PageController();
  var _step = 0;
  var _busy = false;
  final _me = TextEditingController(text: 'بابا');
  final _partner = TextEditingController(text: 'ماما');
  var _hasPartner = true;
  final List<TextEditingController> _kids = [TextEditingController()];
  var _salary = 1250000;
  var _payDay = 1;
  var _save = 10;
  var _envelopes = 130000;
  final _fixed = [
    _Fixed('المولدة', 'bolt', 75000, 'generator', amps: 6, price: 12500),
    _Fixed('الإنترنت', 'wifi', 35000, 'phone_net'),
    _Fixed('رصيد الموبايلات', 'phone', 20000, 'phone_net'),
    _Fixed('نقل المدرسة', 'bus', 15000, 'other'),
    _Fixed('الإيجار', 'home', 0, 'home', on: false),
  ];

  @override
  void dispose() {
    _page.dispose();
    _me.dispose();
    _partner.dispose();
    for (final k in _kids) {
      k.dispose();
    }
    super.dispose();
  }

  MonthlyPlan get _plan => MonthlyPlan(
        salary: _salary,
        savePercent: _save,
        envelopesMonthly: _envelopes,
        fixedBills: _fixed.where((f) => f.on).fold(0, (a, f) => a + f.amount),
        payDay: _payDay,
      );

  void _go(int step) {
    HapticFeedback.selectionClick();
    setState(() => _step = step);
    _page.animateToPage(step, duration: const Duration(milliseconds: 450), curve: const SpringCurve(damping: .85));
  }

  Future<void> _finish() async {
    setState(() => _busy = true);
    final kids = _kids.map((c) => c.text.trim()).where((s) => s.isNotEmpty).toList();
    await ref.read(repositoryProvider).createHousehold(HouseholdSetup(
          familyName: 'بيت ${_me.text.trim().isEmpty ? 'العائلة' : _me.text.trim()}',
          meName: _me.text.trim().isEmpty ? 'أنا' : _me.text.trim(),
          partnerName: _hasPartner && _partner.text.trim().isNotEmpty ? _partner.text.trim() : null,
          kidNames: kids,
          salary: _salary,
          payDay: _payDay,
          savePercent: _save,
          envelopesMonthly: _envelopes,
          bills: [
            for (final f in _fixed.where((f) => f.on && f.amount > 0))
              BillSetup(f.name, f.icon, f.amount, f.category, day: _payDay, amps: f.amps, pricePerAmp: f.price),
          ],
        ));
  }

  Future<void> _demo() async {
    setState(() => _busy = true);
    await seedDemo(ref.read(repositoryProvider));
  }

  @override
  Widget build(BuildContext context) {
    const fg = Colors.white;
    return Theme(
      data: buildTheme(Brightness.dark),
      child: Scaffold(
        backgroundColor: const Color(0xFF0B231F),
        body: Stack(children: [
          const Positioned(top: 120, left: -60, right: -60, child: Center(child: Rosette(size: 640))),
          SafeArea(
            child: Column(children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 8, 0),
                child: Row(children: [
                  for (var i = 0; i < 5; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: const SpringCurve(),
                      margin: const EdgeInsetsDirectional.only(end: 6),
                      width: i == _step ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(color: i == _step ? Wf.vaultMint : Colors.white24, borderRadius: BorderRadius.circular(4)),
                    ),
                  const Spacer(),
                  if (_step == 0)
                    TextButton(
                      onPressed: _busy ? null : _demo,
                      child: const Text('جرّبوا ببيانات تجريبية', style: TextStyle(color: Wf.vaultMuted)),
                    ),
                ]),
              ),
              Expanded(
                child: PageView(
                  controller: _page,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [_welcome(), _who(), _salaryStep(), _fixedStep(), _reveal()],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Row(children: [
                  if (_step > 0)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10),
                      child: IconButton.outlined(
                        tooltip: 'رجوع',
                        style: IconButton.styleFrom(fixedSize: const Size(56, 56), side: const BorderSide(color: Colors.white38), foregroundColor: fg),
                        onPressed: () => _go(_step - 1),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0B231F), shape: const StadiumBorder(), textStyle: const TextStyle(fontFamily: WfText.ui, fontSize: 16, fontWeight: FontWeight.w600)),
                        onPressed: _busy ? null : (_step < 4 ? () => _go(_step + 1) : _finish),
                        child: Text(const ['يلا نبدأ', 'التالي', 'التالي', 'احسبوا رزمتنا', 'ادخلوا'][_step]),
                      ),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _title(String t, [String? sub]) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600, height: 1.35)),
        if (sub != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(sub, style: const TextStyle(color: Wf.vaultMuted, fontSize: 15, height: 1.7))),
      ]);

  Widget _welcome() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('وين\nفلوسي؟', textAlign: TextAlign.center, style: TextStyle(fontFamily: WfText.brand, fontSize: 64, color: Colors.white, height: 1.25)),
          SizedBox(height: 18),
          Text('خلّونا نرتّب فلوس البيت\nبثلاث دقايق.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18, height: 1.6)),
          SizedBox(height: 8),
          Text('رقم واحد كل يوم: شكد باقي إلكم هالأسبوع.', textAlign: TextAlign.center, style: TextStyle(color: Wf.vaultMuted, fontSize: 15)),
        ]),
      );

  Widget _field(TextEditingController c, String label) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextField(
          controller: c,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Wf.vaultMuted), fillColor: Colors.white10),
        ),
      );

  Widget _who() => ListView(padding: const EdgeInsets.fromLTRB(22, 18, 22, 0), children: [
        _title('منو وياكم بالبيت؟', 'كل واحد يسجّل من موبايله، والأرقام تتحدث عند الكل.'),
        _field(_me, 'اسمك'),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('شريك حياتي وياي', style: TextStyle(color: Colors.white)),
          value: _hasPartner,
          onChanged: (v) => setState(() => _hasPartner = v),
        ),
        if (_hasPartner) _field(_partner, 'اسمها أو اسمه'),
        const SizedBox(height: 10),
        for (var i = 0; i < _kids.length; i++) _field(_kids[i], 'اسم الطفل ${i + 1} (اختياري)'),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            onPressed: _kids.length >= 5 ? null : () => setState(() => _kids.add(TextEditingController())),
            icon: const Icon(Icons.add, color: Wf.vaultMint),
            label: const Text('طفل ثاني', style: TextStyle(color: Wf.vaultMint)),
          ),
        ),
      ]);

  Widget _choice<T>(List<T> values, T selected, String Function(T) label, ValueChanged<T> onTap) => Wrap(spacing: 8, runSpacing: 8, children: [
        for (final v in values)
          ChoiceChip(
            label: Text(label(v)),
            selected: v == selected,
            onSelected: (_) => setState(() => onTap(v)),
            labelStyle: TextStyle(color: v == selected ? const Color(0xFF0B231F) : Colors.white, fontFamily: WfText.ui),
            selectedColor: Colors.white,
            backgroundColor: Colors.transparent,
            side: const BorderSide(color: Colors.white38),
            showCheckmark: false,
          ),
      ]);

  Widget _salaryStep() => ListView(padding: const EdgeInsets.fromLTRB(22, 18, 22, 0), children: [
        _title('شكد الراتب، ومتى ينزل؟'),
        const SizedBox(height: 12),
        Align(alignment: AlignmentDirectional.centerStart, child: Odometer(value: _salary, style: WfText.money(48, color: Colors.white))),
        const SizedBox(height: 8),
        _choice<int>(const [750000, 1000000, 1250000, 1500000, 2000000], _salary, (v) => formatAmount(v), (v) => _salary = v),
        TextButton(
          onPressed: () async {
            final c = TextEditingController();
            final v = await showDialog<int>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('الراتب بالضبط'),
                content: TextField(controller: c, keyboardType: TextInputType.number, autofocus: true, decoration: const InputDecoration(suffixText: 'د.ع')),
                actions: [FilledButton(onPressed: () => Navigator.pop(context, int.tryParse(c.text.replaceAll(',', ''))), child: const Text('تمام'))],
              ),
            );
            c.dispose();
            if (v != null && v > 0) setState(() => _salary = v);
          },
          child: const Text('رقم ثاني', style: TextStyle(color: Wf.vaultMint)),
        ),
        const SizedBox(height: 14),
        const Text('ينزل كل شهر بيوم', style: TextStyle(color: Wf.vaultMuted)),
        const SizedBox(height: 8),
        _choice<int>(const [1, 5, 10, 15, 20, 25], _payDay, (v) => '$v', (v) => _payDay = v),
      ]);

  Widget _fixedStep() => ListView(padding: const EdgeInsets.fromLTRB(22, 18, 22, 0), children: [
        _title('شنو الثابت كل شهر؟', 'هذني تنحسب وحدها كل شهر، ما تسجلوها.'),
        const SizedBox(height: 10),
        for (final f in _fixed)
          _fixedRow(f.name, f.amount == 0 ? 'اكتبوا المبلغ' : formatAmount(f.amount), f.on, (v) => setState(() => f.on = v), onEdit: () async {
            final v = await _ask(f.name, f.amount);
            if (v != null) setState(() => f.amount = v);
          }),
        _fixedRow('الظروف', formatAmount(_envelopes), _envelopes > 0, (v) => setState(() => _envelopes = v ? 130000 : 0), sub: 'العيد، المدارس، الصيف، العلاج'),
        _fixedRow('الادخار أول شي', '$_save%', _save > 0, (v) => setState(() => _save = v ? 10 : 0), sub: 'من الراتب، للخزنة'),
      ]);

  Future<int?> _ask(String title, int current) async {
    final c = TextEditingController(text: current == 0 ? '' : '$current');
    final v = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: TextField(controller: c, keyboardType: TextInputType.number, autofocus: true, decoration: const InputDecoration(suffixText: 'د.ع بالشهر')),
        actions: [FilledButton(onPressed: () => Navigator.pop(context, int.tryParse(c.text.replaceAll(',', ''))), child: const Text('تمام'))],
      ),
    );
    c.dispose();
    return v;
  }

  Widget _fixedRow(String name, String value, bool on, ValueChanged<bool> onChanged, {String? sub, VoidCallback? onEdit}) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: .07), borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
              if (sub != null) Text(sub, style: const TextStyle(color: Wf.vaultMuted, fontSize: 12)),
            ]),
          ),
          TextButton(onPressed: onEdit, child: Text(value, style: WfText.money(15, weight: FontWeight.w500, color: Colors.white))),
          Switch(value: on, onChanged: onChanged),
        ]),
      );

  Widget _reveal() {
    final weekly = weeklyAllowance(_plan, DateTime.now());
    final notes = breakdown(weekly);
    return ListView(padding: const EdgeInsets.fromLTRB(22, 18, 22, 0), children: [
      _title('هذي رزمة أسبوعكم'),
      SizedBox(
        height: 190,
        child: _step == 4
            ? Stack(alignment: Alignment.center, children: [
                for (var i = 0; i < notes.length; i++)
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(milliseconds: 600 + i * 140),
                    curve: Interval(i * 140 / (600 + i * 140), 1, curve: const SpringCurve(damping: .55)),
                    builder: (_, t, child) => Opacity(
                      opacity: t.clamp(0, 1),
                      child: Transform.translate(
                        offset: Offset((((i * 53) % 9) - 4) * 1.6 * (i == notes.length - 1 ? 0 : 1), -260 * (1 - t) - (notes.length - 1 - i).clamp(0, 6) * 7.0),
                        child: Transform.rotate(angle: (1 - t) * -.2 + (i == notes.length - 1 ? 0 : (((i * 37) % 7) - 3) * .014), child: child),
                      ),
                    ),
                    child: Banknote(denomination: notes[i], width: 258),
                  ),
              ])
            : const SizedBox.shrink(),
      ),
      Align(alignment: AlignmentDirectional.centerStart, child: Odometer(value: _step == 4 ? weekly : 0, style: WfText.money(44, color: Colors.white))),
      const Text('كل أسبوع تنزل رزمة جديدة. اللي يبقى يوم الجمعة يروح للخزنة.', style: TextStyle(color: Wf.vaultMuted, fontSize: 14, height: 1.7)),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: .08), borderRadius: BorderRadius.circular(16)),
        child: Text(
          'الادخار ${formatAmount(_plan.saveFirst)} · الظروف ${formatAmount(_envelopes)} · الثابت ${formatAmount(_plan.fixedBills)} · للصرف ${formatAmount(_plan.spendable)} بالشهر',
          style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.7),
        ),
      ),
    ]);
  }
}
