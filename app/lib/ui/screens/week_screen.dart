library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../data/repository.dart';
import '../../data/snapshot.dart';
import '../../domain/banknotes.dart';
import '../../domain/budget.dart';
import '../../state/providers.dart';
import '../theme/theme.dart';
import '../widgets/banknote.dart';
import '../widgets/common.dart';
import '../widgets/odometer.dart';
import '../format.dart';
import 'afford_sheet.dart';
import 'inbox_sheet.dart';
import 'pocket_sheet.dart';

class WeekScreen extends ConsumerWidget {
  const WeekScreen({super.key, required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final t = Theme.of(context).textTheme;
    final w = snap.week;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(snap: snap),
                if (snap.isDemo) const _DemoBanner(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(w.over ? 'تعدّيتوا مسموح الأسبوع' : 'باقي إلكم هالأسبوع', style: t.bodyLarge?.copyWith(color: wf.mute, height: 1.4)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Odometer(
                            value: w.left.abs(),
                            prefix: w.over ? '-' : '',
                            style: WfText.money(58, color: w.over ? wf.alert : wf.ink),
                            semanticsSuffix: 'دينار',
                          ),
                          const SizedBox(width: 8),
                          Text('د.ع', style: t.bodyMedium?.copyWith(color: wf.mute)),
                        ],
                      ),
                      Text.rich(
                        w.over
                            ? TextSpan(text: 'خففوا لحد الجمعة، واللي زاد ينقص من الأسبوع الجاي')
                            : TextSpan(
                                children: [
                                  const TextSpan(text: 'يعني تگدرون تصرفون حوالي '),
                                  TextSpan(
                                    text: inThousands(floorTo(w.perDay, 1000)),
                                    style: WfText.money(15, weight: FontWeight.w600, color: wf.ink),
                                  ),
                                  TextSpan(text: ' باليوم، لحد الجمعة (${w.daysLeft == 1 ? 'باقي يوم واحد' : 'باقي ${w.daysLeft} أيام'})'),
                                ],
                              ),
                        style: t.bodyMedium?.copyWith(color: wf.mute, height: 1.5),
                      ),
                    ],
                  ),
                ),
                _WeekProgress(week: w),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: NoteStack(amount: w.left),
                ),
                if (!w.over && notesSentence(w.left).isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
                    child: Text(
                      'لو بجيبكم: ${notesSentence(w.left)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: wf.mute, height: 1.6),
                    ),
                  ),
                _QuickRow(snap: snap),
                if (snap.inbox.isNotEmpty) _InboxCard(snap: snap),
                _DayStrip(week: w),
                const SizedBox(height: 12),
                _RowButton(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: wf.ok,
                  title: 'ناوين تشترون شي؟',
                  subtitle: 'اكتبوا سعره ونگلكم يمشي ويا الأسبوع لو لا',
                  onTap: () => showWfSheet(context, (_) => const AffordSheet(), heightFactor: .9),
                ),
                _TodayList(snap: snap),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final mode = ref.watch(themeModeProvider);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 6, 12, 0),
      child: Row(
        children: [
          Text(
            'وين فلوسي',
            style: TextStyle(fontFamily: WfText.brand, fontSize: 27, color: wf.brand, height: 1.3),
          ),
          const Spacer(),
          IconButton(
            tooltip: dark ? 'الوضع النهاري' : 'الوضع الليلي',
            onPressed: () => ref.read(themeModeProvider.notifier).set(dark ? ThemeMode.light : ThemeMode.dark),
            icon: Icon(dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, color: wf.ink, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: wf.surface,
              side: BorderSide(color: wf.line),
            ),
          ),
          if (mode == ThemeMode.system) const SizedBox.shrink(),
          const SizedBox(width: 4),
          Tooltip(
            message: 'سعر الدولار اليوم',
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: wf.surface,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: wf.line),
              ),
              child: Row(
                children: [
                  Text(r'الدولار ', style: TextStyle(color: wf.mute, fontSize: 12)),
                  Text(
                    formatAmount(snap.household.usdRate),
                    style: WfText.money(12, weight: FontWeight.w500, color: wf.ink),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          Semantics(
            button: true,
            label: 'أنت ${snap.me.displayName}. افتحوا العائلة',
            excludeSemantics: true,
            child: GestureDetector(
              onTap: () => ref.read(tabProvider.notifier).go(3),
              child: Container(
                height: 34,
                padding: const EdgeInsetsDirectional.fromSTEB(3, 2, 10, 2),
                decoration: BoxDecoration(
                  color: wf.surface,
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(color: wf.line),
                ),
                child: Row(
                  children: [
                    MemberAvatar(snap.me, size: 28),
                    const SizedBox(width: 6),
                    Text(snap.me.displayName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoBanner extends StatelessWidget {
  const _DemoBanner();
  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: wf.warnBg, borderRadius: BorderRadius.circular(12)),
      child: Text('بيانات تجريبية. تگدرون تمسحوها وتبدون من العائلة ← الإعدادات', style: TextStyle(color: wf.warn, fontSize: 12)),
    );
  }
}

class _QuickRow extends ConsumerWidget {
  const _QuickRow({required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: Row(
            children: [
              Text('تسجيل سريع', style: t.titleMedium?.copyWith(fontSize: 14)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  snap.quickPicks.isEmpty ? 'الأشياء اللي تتكرر تطلع هنا' : 'دوسة وحدة تسجّلها بنفس مبلغ كل مرة',
                  style: t.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 62,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
            children: [
              for (final q in snap.quickPicks)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: Material(
                    color: wf.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: wf.line),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _quickLog(context, ref, q),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(6, 0, 14, 0),
                        child: Row(
                          children: [
                            MiniNote(denominationFor(q.amount), width: 40, showLabel: false),
                            const SizedBox(width: 8),
                            Text(q.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            const SizedBox(width: 8),
                            Text(
                              formatAmount(q.amount),
                              style: WfText.money(13, weight: FontWeight.w500, color: wf.mute),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              Material(
                color: wf.tint,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => showWfSheet(context, (_) => const PocketSheet(), heightFactor: .9),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Icon(Icons.account_balance_wallet_outlined, size: 20, color: wf.tintInk),
                        const SizedBox(width: 8),
                        Text(
                          'عدّ الجيب',
                          style: TextStyle(color: wf.tintInk, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _quickLog(BuildContext context, WidgetRef ref, QuickPick q) async {
    final repo = ref.read(repositoryProvider);
    final ids = await repo.addExpenses([
      ExpenseDraft(label: q.label, categoryKey: q.categoryKey, amountMinor: q.amount, walletId: q.walletId, memberId: snap.me.id, source: 'quick'),
    ]);
    if (!context.mounted) return;
    Toaster.show(context, 'انسجلت بدوسة: ${q.label} ${formatAmount(q.amount)}', onUndo: () => repo.softDelete(ids));
  }
}

class _InboxCard extends StatelessWidget {
  const _InboxCard({required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context) {
    final n = snap.inbox.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Material(
        color: Wf.vaultGreen,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => showWfSheet(context, (_) => const InboxSheet(), heightFactor: .78),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(colors: [Color(0xFFF2C14E), Color(0xFFD39A1F)]),
                  ),
                  child: const Text(
                    'Qi',
                    style: TextStyle(fontFamily: WfText.num, fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF2B1D00)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n == 1 ? 'صرفة من الكي كارد تنتظر تأكيدكم' : '$n صرفات من الكي كارد تنتظر تأكيدكم',
                        style: const TextStyle(color: Wf.vaultText, fontWeight: FontWeight.w600, fontSize: 15, height: 1.45),
                      ),
                      const Text('البنك بعث رسائل بيها. دوسوا هنا وأكّدوها حتى تنحسب', style: TextStyle(color: Wf.vaultMuted, fontSize: 12, height: 1.45)),
                    ],
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 26),
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Wf.vaultGold, borderRadius: BorderRadius.circular(13)),
                  child: Text(
                    '$n',
                    style: const TextStyle(fontFamily: WfText.num, fontWeight: FontWeight.w700, color: Color(0xFF2B1D00)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DayStrip extends StatelessWidget {
  const _DayStrip({required this.week});
  final WeekStatus week;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final share = week.dailyShare <= 0 ? 1 : week.dailyShare;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final anyOver = [for (var i = 0; i <= week.todayIndex && i < 7; i++) week.dayTotals[i] > share].contains(true);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Row(
              children: [
                const Text('صرف كل يوم', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    anyOver ? 'الأحمر = يوم صرفتوا بيه أكثر من ${inThousands(roundTo(share, 1000))}' : 'الأسبوع من السبت للجمعة',
                    style: TextStyle(fontSize: 12, color: wf.mute),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              for (var i = 0; i < 7; i++)
                Expanded(
                  child: Semantics(
                    label: i > week.todayIndex ? '${kArabicWeekdays[i]}، بعد ما إجا' : '${kArabicWeekdays[i]}، صرفتوا ${formatAmount(week.dayTotals[i])}',
                    excludeSemantics: true,
                    child: Column(
                      children: [
                        Container(
                          width: 26,
                          height: 36,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: i > week.todayIndex ? Colors.transparent : wf.surface,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: i == week.todayIndex ? wf.ink : wf.line, width: i == week.todayIndex ? 2 : 1),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: i > week.todayIndex
                              ? null
                              : TweenAnimationBuilder<double>(
                                  tween: Tween(end: (week.dayTotals[i] / (share * 1.4)).clamp(0.0, 1.0)),
                                  duration: const Duration(milliseconds: 600),
                                  curve: const SpringCurve(),
                                  builder: (_, v, _) => FractionallySizedBox(
                                    heightFactor: v,
                                    widthFactor: 1,
                                    child: ColoredBox(color: week.dayTotals[i] > share ? const Color(0xFFB4573F) : (dark ? wf.mint : wf.vault)),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          i == week.todayIndex ? 'اليوم' : kArabicWeekdays[i],
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.3,
                            color: i == week.todayIndex ? wf.ink : wf.mute,
                            fontWeight: i == week.todayIndex ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                        Text(
                          i > week.todayIndex ? ' ' : _k(week.dayTotals[i]),
                          style: WfText.money(11, weight: FontWeight.w500, color: wf.mute, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Day totals as thousands ("12k" is how people read a small column).
  String _k(int v) => v == 0
      ? '0'
      : v < 1000
      ? formatAmount(v)
      : '${(v / 1000).round()} ألف';
}

class _WeekProgress extends StatelessWidget {
  const _WeekProgress({required this.week});
  final WeekStatus week;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final budget = week.budget <= 0 ? 1 : week.budget;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: (week.spent / budget).clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: wf.sunk,
              color: week.over ? wf.alert : (dark ? wf.mint : wf.vault),
            ),
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'صرفتوا '),
                TextSpan(
                  text: inThousands(week.spent),
                  style: WfText.money(12, weight: FontWeight.w600, color: wf.ink),
                ),
                const TextSpan(text: ' من '),
                TextSpan(
                  text: inThousands(week.budget),
                  style: WfText.money(12, weight: FontWeight.w600, color: wf.ink),
                ),
                TextSpan(text: week.carried > 0 ? ' مال هالأسبوع (وياها ${inThousands(week.carried)} زايدة من الأسبوع الفات)' : ' مال هالأسبوع'),
              ],
            ),
            style: TextStyle(fontSize: 12, color: wf.mute, height: 1.5),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}

class _RowButton extends StatelessWidget {
  const _RowButton({required this.icon, required this.iconColor, required this.title, required this.subtitle, required this.onTap});
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return WfCard(
      radius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: wf.mute),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(Icons.chevron_left, color: wf.mute),
        ],
      ),
    );
  }
}

class _TodayList extends ConsumerWidget {
  const _TodayList({required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final today = DateTime(snap.now.year, snap.now.month, snap.now.day);
    final items = snap.recent.where((x) => x.kind == 'expense' && !x.occurredAt.isBefore(today)).toList();
    final total = items.fold(0, (a, x) => a + x.amountBase);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle('صرفات اليوم', trailing: formatAmount(total), padding: const EdgeInsets.fromLTRB(20, 18, 20, 2)),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text('ما صرفتوا شي اليوم بعد. دوسوا «صرفت» تحت، أو گولوها بالصوت.', style: TextStyle(color: wf.mute, fontSize: 14)),
          ),
        for (final x in items)
          Dismissible(
            key: ValueKey(x.id),
            direction: DismissDirection.startToEnd,
            background: Container(
              color: wf.alertBg,
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete_outline, color: wf.alert),
            ),
            onDismissed: (_) {
              final repo = ref.read(repositoryProvider);
              repo.softDelete([x.id]);
              HapticFeedback.mediumImpact();
              Toaster.show(context, 'انمسحت: ${x.label}', onUndo: () => repo.restore([x.id]));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              child: Row(
                children: [
                  if (snap.memberById(x.memberId) != null)
                    MemberAvatar(snap.memberById(x.memberId)!, size: 32)
                  else
                    CircleAvatar(radius: 16, backgroundColor: wf.sunk),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                x.label.isEmpty ? snap.categoryName(x.categoryKey) : x.label,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.45),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (_sourceLabel(x.source) != null) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(color: wf.sunk, borderRadius: BorderRadius.circular(6)),
                                child: Text(_sourceLabel(x.source)!, style: TextStyle(fontSize: 10, color: wf.mute, height: 1.7)),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          '${snap.memberById(x.memberId)?.displayName ?? ''}، ${spokenTime(x.occurredAt)}',
                          style: TextStyle(fontSize: 12, color: wf.mute, height: 1.45),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatMoney(x.amountMinor, Currency.fromCode(x.currency)),
                    style: WfText.money(16, weight: FontWeight.w500, color: wf.ink),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String? _sourceLabel(String s) => switch (s) {
    'quick' => 'دوسة',
    'voice' => 'صوت',
    'text' => 'كتابة',
    'sms' => 'رسالة',
    'pocket' => 'عدّ الجيب',
    _ => null,
  };
}
