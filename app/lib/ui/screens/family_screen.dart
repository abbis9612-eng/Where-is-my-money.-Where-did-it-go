library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../data/database.dart';
import '../../data/snapshot.dart';
import '../../domain/budget.dart';
import '../../domain/rosca.dart' as d;
import '../../state/providers.dart';
import '../theme/theme.dart';
import '../widgets/common.dart';
import 'friday_screen.dart';
import 'kid_screen.dart';
import 'settings_screen.dart';

class FamilyScreen extends ConsumerWidget {
  const FamilyScreen({super.key, required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final adults = snap.adults;
    final spent = [for (final m in adults) snap.spentByMember[m.id] ?? 0];
    final total = spent.fold(0, (a, b) => a + b);
    return SafeArea(
      bottom: false,
      child: ListView(padding: const EdgeInsets.only(bottom: 28), children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 8, 0),
          child: Row(children: [
            Text('العائلة', style: Theme.of(context).textTheme.headlineSmall),
            const Spacer(),
            IconButton(
              tooltip: 'الإعدادات',
              onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const SettingsScreen())),
              icon: const Icon(Icons.settings_outlined),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: Row(children: [
            for (var i = 0; i < adults.length; i++) ...[
              if (i > 0) const SizedBox(width: 10),
              Expanded(child: _MemberCard(member: adults[i], spent: spent[i])),
            ],
          ]),
        ),
        if (total > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Semantics(
              label: [for (var i = 0; i < adults.length; i++) '${adults[i].displayName} ${formatAmount(spent[i])}'].join('، '),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: 8,
                  child: Row(children: [
                    for (var i = 0; i < adults.length; i++)
                      if (spent[i] > 0)
                        Expanded(flex: math.max(1, spent[i] * 1000 ~/ total), child: Container(color: wf.memberColor(adults[i].colorIndex), margin: const EdgeInsetsDirectional.only(end: 2))),
                  ]),
                ),
              ),
            ),
          ),
        for (final k in snap.kids) _KidCard(kid: k),
        const SectionTitle('الجمعية', trailing: 'ما نمسك فلوس، بس نرتّب'),
        if (snap.roscas.isEmpty)
          _EmptyAction(text: 'عندكم جمعية؟ سجّلوها حتى تعرفون دوركم ومتى تدفعون.', action: 'أضيفوا جمعية', onTap: () => _addRosca(context, ref))
        else
          for (final r in snap.roscas) _RoscaCard(rosca: r, now: snap.now),
        SectionTitle('الديون', trailing: 'بيناتنا وبين الأهل والأصدقاء', padding: const EdgeInsets.fromLTRB(20, 22, 20, 8)),
        _DebtSummary(debts: snap.debts),
        _DebtList(debts: snap.debts),
        SectionTitle('الفواتير الثابتة', trailing: '${formatAmount(snap.fixedBillsTotal)} بالشهر', padding: const EdgeInsets.fromLTRB(20, 22, 20, 8)),
        _Bills(bills: snap.bills, now: snap.now),
        const SectionTitle('عاداتنا', padding: EdgeInsets.fromLTRB(20, 22, 20, 8)),
        WfCard(
          padding: EdgeInsets.zero,
          child: Column(children: [
            _Row(
              icon: Icons.event_outlined,
              title: 'جلسة الجمعة',
              subtitle: 'دقيقتين: الباقي للخزنة وسؤال واحد',
              trailing: OutlinedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const FridayScreen(), fullscreenDialog: true)),
                child: const Text('افتحوها'),
              ),
            ),
            Divider(height: 1, color: wf.line),
            _Row(
              icon: Icons.add_card_outlined,
              title: 'أضيفوا دين',
              subtitle: 'إلنا أو علينا',
              trailing: OutlinedButton(onPressed: () => _addDebt(context, ref), child: const Text('أضيفوا')),
            ),
          ]),
        ),
      ]),
    );
  }

  Future<void> _addRosca(BuildContext context, WidgetRef ref) async {
    final r = await showDialog<_RoscaInput>(context: context, builder: (_) => const _RoscaDialog());
    if (r == null) return;
    final now = DateTime.now();
    await ref.read(repositoryProvider).addRosca(
          name: r.name, organizer: r.organizer, members: r.members, contribution: r.contribution,
          startYear: now.year, startMonth: now.month, myTurn: r.myTurn,
        );
  }

  Future<void> _addDebt(BuildContext context, WidgetRef ref) async {
    final r = await showDialog<(String, bool, int)>(context: context, builder: (_) => const _DebtDialog());
    if (r == null) return;
    await ref.read(repositoryProvider).addDebt(person: r.$1, theyOweUs: r.$2, amount: r.$3);
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member, required this.spent});
  final Member member;
  final int spent;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: wf.surface, borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          MemberAvatar(member, size: 34),
          const SizedBox(width: 8),
          Flexible(child: Text(member.displayName, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
        ]),
        const SizedBox(height: 6),
        Text('صرف من فلوس البيت', style: TextStyle(fontSize: 12, color: wf.mute)),
        Text(formatAmount(spent), style: WfText.money(20, weight: FontWeight.w500, color: wf.ink, height: 1.4)),
        const SizedBox(height: 4),
        Row(children: [
          Icon(Icons.lock_outline, size: 13, color: wf.mute),
          const SizedBox(width: 4),
          Text('حرّ ${formatAmount(member.freeAllowance)}', style: TextStyle(fontSize: 12, color: wf.mute)),
        ]),
      ]),
    );
  }
}

class _KidCard extends StatelessWidget {
  const _KidCard({required this.kid});
  final KidView kid;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return WfCard(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      color: wf.kidBg,
      radius: 22,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => KidScreen(memberId: kid.member.id), fullscreenDialog: true)),
      child: Row(children: [
        SizedBox(width: 46, height: 56, child: CustomPaint(painter: JarIconPainter(color: wf.kid, fill: wf.surface))),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('حصالة ${kid.member.displayName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text('بالحصالة ${formatAmount(kid.save)} · ${kid.profile.goalName} ${(kid.goalProgress * 100).round()}%', style: TextStyle(fontSize: 12, color: wf.mute)),
            const SizedBox(height: 6),
            ClipRRect(borderRadius: BorderRadius.circular(3), child: LinearProgressIndicator(value: kid.goalProgress, minHeight: 6, color: wf.kid, backgroundColor: wf.kid.withValues(alpha: .15))),
          ]),
        ),
        Icon(Icons.chevron_left, color: wf.mute),
      ]),
    );
  }
}

class JarIconPainter extends CustomPainter {
  JarIconPainter({required this.color, required this.fill});
  final Color color, fill;
  @override
  void paint(Canvas c, Size s) {
    final sx = s.width / 120, sy = s.height / 150;
    final jar = Path()
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
    c.drawPath(jar, Paint()..color = fill);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(18 * sx, 104 * sy, 84 * sx, 40 * sy), const Radius.circular(6)), Paint()..color = color.withValues(alpha: .85));
    c.drawPath(jar, Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * sx);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(26 * sx, 16 * sy, 68 * sx, 14 * sy), const Radius.circular(4)), Paint()..color = color);
  }

  @override
  bool shouldRepaint(JarIconPainter o) => o.color != color;
}

class _RoscaCard extends ConsumerWidget {
  const _RoscaCard({required this.rosca, required this.now});
  final Rosca rosca;
  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final r = d.Rosca(
      members: rosca.membersCount, contribution: rosca.contribution, startYear: rosca.startYear,
      startMonth: rosca.startMonth, myTurn: rosca.myTurn, paidRounds: rosca.paidRounds,
    );
    final nextPay = r.monthOfRound(rosca.paidRounds + 1);
    return WfCard(
      radius: 24,
      child: Row(children: [
        SizedBox.square(
          dimension: 132,
          child: Stack(alignment: Alignment.center, children: [
            CustomPaint(size: const Size.square(132), painter: _RoscaClock(rosca, ink: wf.vault, gold: wf.gold, empty: wf.sunk, warn: wf.warn)),
            Column(mainAxisSize: MainAxisSize.min, children: [
              Text('${rosca.myTurn}', style: WfText.money(18, weight: FontWeight.w500, color: wf.ink)),
              Text('دوركم\nمن ${rosca.membersCount}', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: wf.mute, height: 1.3)),
            ]),
          ]),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(rosca.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            Text('${rosca.membersCount} أشخاص · كل شهر ${formatAmount(rosca.contribution)}${rosca.organizer.isEmpty ? '' : ' · تجمعها ${rosca.organizer}'}', style: TextStyle(fontSize: 12, color: wf.mute, height: 1.5)),
            const SizedBox(height: 4),
            Text.rich(TextSpan(children: [
              TextSpan(text: 'دوركم ب${iraqiMonthName(r.myPayoutMonth.month)}: تقبضون '),
              TextSpan(text: formatAmount(r.payout), style: TextStyle(fontFamily: WfText.num, color: wf.goldInk, fontWeight: FontWeight.w600)),
            ]), style: const TextStyle(fontSize: 13, height: 1.5)),
            Text('دفعتوا ${rosca.paidRounds} من ${rosca.membersCount}${rosca.paidRounds < rosca.membersCount ? ' · الدفعة الجاية 1 ${iraqiMonthName(nextPay.month)}' : ''}', style: TextStyle(fontSize: 12, color: wf.mute, height: 1.5)),
            if (rosca.warning.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: wf.warnBg, borderRadius: BorderRadius.circular(10)),
                child: Text(rosca.warning, style: TextStyle(fontSize: 12, color: wf.warn)),
              ),
            if (rosca.paidRounds < rosca.membersCount)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(onPressed: () => ref.read(repositoryProvider).payRoscaRound(rosca.id), child: const Text('دفعنا هالشهر')),
              ),
          ]),
        ),
      ]),
    );
  }

}

class _RoscaClock extends CustomPainter {
  _RoscaClock(this.r, {required this.ink, required this.gold, required this.empty, required this.warn});
  final Rosca r;
  final Color ink, gold, empty, warn;

  @override
  void paint(Canvas c, Size s) {
    final center = s.center(Offset.zero);
    final rad = s.width * .4;
    for (var i = 0; i < r.membersCount; i++) {
      final a = -math.pi / 2 + i * 2 * math.pi / r.membersCount;
      final p = center + Offset(math.cos(a), math.sin(a)) * rad;
      final mine = i == r.myTurn - 1;
      final paid = i < r.paidRounds;
      c.drawCircle(p, mine ? 10 : 7, Paint()..color = mine ? gold : (paid ? ink : empty));
    }
    final sweep = r.paidRounds / r.membersCount * 2 * math.pi - .3;
    if (sweep > 0) {
      c.drawArc(Rect.fromCircle(center: center, radius: rad * .72), -math.pi / 2, sweep, false, Paint()
        ..color = ink.withValues(alpha: .5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round);
    }
  }

  @override
  bool shouldRepaint(_RoscaClock o) => o.r != r || o.ink != ink;
}

class _DebtSummary extends StatelessWidget {
  const _DebtSummary({required this.debts});
  final List<Debt> debts;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    int open(Debt d) => d.forgiven ? 0 : d.amountMinor - d.paidMinor;
    final owedToUs = debts.where((d) => d.direction == 'in').fold(0, (a, d) => a + open(d));
    final weOwe = debts.where((d) => d.direction == 'out').fold(0, (a, d) => a + open(d));
    Widget box(String k, int v, Color fg, Color bg) => Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(k, style: TextStyle(fontSize: 12, color: fg)),
              Text(formatAmount(v), style: WfText.money(18, weight: FontWeight.w500, color: fg, height: 1.4)),
            ]),
          ),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [box('إلنا', owedToUs, wf.ok, wf.okBg), const SizedBox(width: 8), box('علينا', weOwe, wf.alert, wf.alertBg)]),
    );
  }
}

class _DebtList extends ConsumerWidget {
  const _DebtList({required this.debts});
  final List<Debt> debts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final open = debts.where((d) => !d.forgiven && d.paidMinor < d.amountMinor).toList();
    if (open.isEmpty) return const SizedBox(height: 4);
    return WfCard(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      padding: EdgeInsets.zero,
      child: Column(children: [
        for (var i = 0; i < open.length; i++) ...[
          if (i > 0) Divider(height: 1, color: wf.line),
          _Row(
            leading: CircleAvatar(
              radius: 18,
              backgroundColor: open[i].direction == 'in' ? wf.okBg : wf.alertBg,
              child: Text(open[i].personName.substring(0, 1), style: TextStyle(color: open[i].direction == 'in' ? wf.ok : wf.alert, fontWeight: FontWeight.w600)),
            ),
            title: open[i].personName,
            subtitle: open[i].note.isEmpty ? (open[i].direction == 'in' ? 'إلنا' : 'علينا') : open[i].note,
            value: formatAmount(open[i].amountMinor - open[i].paidMinor),
            trailing: PopupMenuButton<String>(
              tooltip: 'خيارات',
              onSelected: (v) async {
                final repo = ref.read(repositoryProvider);
                final d = open[i];
                switch (v) {
                  case 'remind':
                    Toaster.show(context, 'رسالة جاهزة للواتساب: «هلا ${d.personName}، بس للتذكير بالـ${formatAmount(d.amountMinor - d.paidMinor)}، على راحتك»');
                  case 'paid':
                    await repo.payDebt(d.id, d.amountMinor - d.paidMinor);
                  case 'half':
                    await repo.payDebt(d.id, (d.amountMinor - d.paidMinor) ~/ 2);
                  case 'forgive':
                    await repo.forgiveDebt(d.id);
                }
              },
              itemBuilder: (_) => [
                if (open[i].direction == 'in') const PopupMenuItem(value: 'remind', child: Text('ذكّروه بلطف')),
                const PopupMenuItem(value: 'paid', child: Text('تسدّد كله')),
                const PopupMenuItem(value: 'half', child: Text('تسدّد نصه')),
                if (open[i].direction == 'in') const PopupMenuItem(value: 'forgive', child: Text('سامحناه')),
              ],
            ),
          ),
        ],
      ]),
    );
  }
}

class _Bills extends ConsumerWidget {
  const _Bills({required this.bills, required this.now});
  final List<Bill> bills;
  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    if (bills.isEmpty) return const SizedBox.shrink();
    return WfCard(
      padding: EdgeInsets.zero,
      child: Column(children: [
        for (var i = 0; i < bills.length; i++) ...[
          if (i > 0) Divider(height: 1, color: wf.line),
          _bill(context, ref, bills[i]),
        ],
      ]),
    );
  }

  Widget _bill(BuildContext context, WidgetRef ref, Bill b) {
    final wf = Wf.of(context);
    final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    final posted = b.lastPosted == month;
    final daysTo = b.dayOfMonth - now.day;
    final (String label, Color fg, Color bg) = posted
        ? ('تسجلت', wf.ok, wf.okBg)
        : daysTo <= 0
            ? ('اليوم', wf.warn, wf.warnBg)
            : daysTo <= 3
                ? (daysTo == 1 ? 'باچر' : 'بعد ${daysTo == 2 ? 'يومين' : '$daysTo أيام'}', wf.warn, wf.warnBg)
                : ('${b.dayOfMonth} بالشهر', wf.ok, wf.okBg);
    final sub = b.amps != null ? '${b.amps} أمبير × ${formatAmount(b.pricePerAmp ?? 0)} · دوسوا تغيرون السعر' : 'يتسجل وحده كل شهر';
    return InkWell(
      onTap: () async {
        if (b.amps != null) {
          final r = await showDialog<(int, int)>(context: context, builder: (_) => _AmpDialog(amps: b.amps!, price: b.pricePerAmp ?? 0));
          if (r != null) await ref.read(repositoryProvider).updateGeneratorBill(b.id, amps: r.$1, pricePerAmp: r.$2);
        }
      },
      child: _Row(
        icon: billIcon(b.icon),
        title: b.name,
        subtitle: sub,
        value: formatAmount(b.amountMinor),
        badge: (label, fg, bg),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({this.icon, this.leading, required this.title, required this.subtitle, this.value, this.trailing, this.badge});
  final IconData? icon;
  final Widget? leading;
  final String title;
  final String subtitle;
  final String? value;
  final Widget? trailing;
  final (String, Color, Color)? badge;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: [
        leading ??
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: wf.sunk, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, size: 19, color: wf.ink),
            ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.45)),
            Text(subtitle, style: TextStyle(fontSize: 12, color: wf.mute, height: 1.45)),
          ]),
        ),
        if (value != null)
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(value!, style: WfText.money(15, weight: FontWeight.w500, color: wf.ink, height: 1.4)),
            if (badge != null)
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(color: badge!.$3, borderRadius: BorderRadius.circular(99)),
                child: Text(badge!.$1, style: TextStyle(fontSize: 11, color: badge!.$2, height: 1.7)),
              ),
          ]),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ]),
    );
  }
}

class _EmptyAction extends StatelessWidget {
  const _EmptyAction({required this.text, required this.action, required this.onTap});
  final String text;
  final String action;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => WfCard(
        child: Row(children: [
          Expanded(child: Text(text, style: TextStyle(color: Wf.of(context).mute, fontSize: 13, height: 1.6))),
          const SizedBox(width: 8),
          FilledButton(onPressed: onTap, child: Text(action)),
        ]),
      );
}

class _AmpDialog extends StatefulWidget {
  const _AmpDialog({required this.amps, required this.price});
  final int amps;
  final int price;
  @override
  State<_AmpDialog> createState() => _AmpDialogState();
}

class _AmpDialogState extends State<_AmpDialog> {
  late final _a = TextEditingController(text: '${widget.amps}');
  late final _p = TextEditingController(text: '${widget.price}');
  @override
  void dispose() {
    _a.dispose();
    _p.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('المولدة'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: _a, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'كم أمبير')),
          const SizedBox(height: 10),
          TextField(controller: _p, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'سعر الأمبير هالشهر', suffixText: 'د.ع')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              final a = int.tryParse(_a.text), p = int.tryParse(_p.text.replaceAll(',', ''));
              if (a == null || p == null || a <= 0 || p <= 0) return;
              Navigator.pop(context, (a, p));
            },
            child: const Text('احفظوا'),
          ),
        ],
      );
}

class _RoscaInput {
  const _RoscaInput(this.name, this.organizer, this.members, this.contribution, this.myTurn);
  final String name, organizer;
  final int members, contribution, myTurn;
}

class _RoscaDialog extends StatefulWidget {
  const _RoscaDialog();
  @override
  State<_RoscaDialog> createState() => _RoscaDialogState();
}

class _RoscaDialogState extends State<_RoscaDialog> {
  final _name = TextEditingController(text: 'جمعية');
  final _org = TextEditingController();
  final _n = TextEditingController(text: '10');
  final _amt = TextEditingController(text: '100000');
  final _turn = TextEditingController(text: '1');
  @override
  void dispose() {
    for (final c in [_name, _org, _n, _amt, _turn]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('جمعية جديدة'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: _name, decoration: const InputDecoration(labelText: 'الاسم')),
            const SizedBox(height: 8),
            TextField(controller: _org, decoration: const InputDecoration(labelText: 'منو يجمعها')),
            const SizedBox(height: 8),
            TextField(controller: _n, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'كم شخص')),
            const SizedBox(height: 8),
            TextField(controller: _amt, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'كل شهر', suffixText: 'د.ع')),
            const SizedBox(height: 8),
            TextField(controller: _turn, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'دورنا بالترتيب')),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              final n = int.tryParse(_n.text) ?? 0, a = int.tryParse(_amt.text.replaceAll(',', '')) ?? 0, t = int.tryParse(_turn.text) ?? 0;
              if (n < 2 || a <= 0 || t < 1 || t > n) return;
              Navigator.pop(context, _RoscaInput(_name.text.trim(), _org.text.trim(), n, a, t));
            },
            child: const Text('أضيفوها'),
          ),
        ],
      );
}

class _DebtDialog extends StatefulWidget {
  const _DebtDialog();
  @override
  State<_DebtDialog> createState() => _DebtDialogState();
}

class _DebtDialogState extends State<_DebtDialog> {
  final _who = TextEditingController();
  final _amt = TextEditingController();
  var _theyOwe = true;
  @override
  void dispose() {
    _who.dispose();
    _amt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('دين جديد'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Segmented<bool>(values: const [true, false], selected: _theyOwe, label: (v) => v ? 'إلنا' : 'علينا', onChanged: (v) => setState(() => _theyOwe = v)),
          const SizedBox(height: 10),
          TextField(controller: _who, decoration: const InputDecoration(labelText: 'منو')),
          const SizedBox(height: 8),
          TextField(controller: _amt, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'المبلغ', suffixText: 'د.ع')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              final a = int.tryParse(_amt.text.replaceAll(',', '')) ?? 0;
              if (_who.text.trim().isEmpty || a <= 0) return;
              Navigator.pop(context, (_who.text.trim(), _theyOwe, a));
            },
            child: const Text('أضيفوه'),
          ),
        ],
      );
}
