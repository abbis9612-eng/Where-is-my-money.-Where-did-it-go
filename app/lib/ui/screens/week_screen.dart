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
import '../../domain/barakah.dart';
import '../widgets/barakah_card.dart';
import '../../domain/zakat.dart';
import '../theme/theme.dart';
import '../widgets/banknote.dart';
import '../widgets/common.dart';
import '../widgets/odometer.dart';
import '../widgets/wf_icons.dart';
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
    final w = snap.week;
    return DecoratedBox(
      decoration: BoxDecoration(gradient: Wf.glow(Theme.of(context).brightness)),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(snap: snap),
                  if (snap.isDemo) const _DemoBanner(),
                  _Hero(snap: snap),
                  _DayStrip(week: w),
                  if (snap.inbox.isNotEmpty) _InboxCard(snap: snap),
                  _TodayList(snap: snap),
                  _EnvelopeStrip(snap: snap),
                  _QuickRow(snap: snap),
                  const SizedBox(height: 6),
                  _RowButton(
                    icon: WfGlyph.bag,
                    title: 'ناوين تشترون شي؟',
                    subtitle: 'اكتبوا سعره ونگلكم يمشي ويا الأسبوع لو لا',
                    onTap: () => showWfSheet(context, (_) => const AffordSheet(), heightFactor: .9),
                  ),
                  BarakahCard(place: w.over ? BarakahPlace.over : BarakahPlace.daily, day: snap.now),
                  if (isFitrSeason(snap.now)) BarakahCard(place: BarakahPlace.fitr, day: snap.now),
                  SizedBox(height: 24, child: ColoredBox(color: wf.bg.withValues(alpha: 0))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The one number that matters, in thousands, with the notes it would be.
class _Hero extends StatelessWidget {
  const _Hero({required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final w = snap.week;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final green = dark ? wf.mint : Wf.vaultGreen;
    final left = w.left.abs();
    final big = left >= 1000;
    final notes = breakdown(w.over ? 0 : w.left).toSet().toList()..sort();
    final fan = notes.reversed.take(3).toList().reversed.toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            w.over ? 'يا ${snap.me.displayName}، تعدّيتوا مسموح الأسبوع بـ' : '${_hello(snap.now)} يا ${snap.me.displayName}، باقي إلكم',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: wf.mute, height: 1.5),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: Odometer(
                          value: big ? left ~/ 1000 : left,
                          prefix: w.over ? '-' : '',
                          style: WfText.money(88, weight: FontWeight.w500, color: w.over ? wf.alert : green, height: 1.05),
                          semanticsSuffix: big ? 'ألف دينار' : 'دينار',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(big ? 'ألف' : 'دينار', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: wf.ink)),
                  ],
                ),
              ),
              if (fan.isNotEmpty) _NoteFan(denominations: fan),
            ],
          ),
          const SizedBox(height: 4),
          Text.rich(
            w.over
                ? const TextSpan(text: 'خففوا لحد الجمعة، واللي زاد ينقص من الأسبوع الجاي')
                : TextSpan(children: [
                    TextSpan(text: w.daysLeft <= 1 ? 'هذا آخر يوم، تگدرون تصرفون ' : 'تكفيكم لحد الجمعة إذا صرفتوا '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(color: dark ? const Color(0x249FD8C4) : const Color(0xFFE3F2EC), borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          w.daysLeft <= 1 ? inThousands(floorTo(w.perDay, 1000)) : '${inThousands(floorTo(w.perDay, 1000))} باليوم',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: green, height: 1.5),
                        ),
                      ),
                    ),
                  ]),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: wf.ink, height: 1.6),
          ),
          const SizedBox(height: 2),
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'صرفتوا '),
              TextSpan(text: inThousands(w.spent), style: WfText.money(13, weight: FontWeight.w600, color: wf.ink)),
              const TextSpan(text: ' من '),
              TextSpan(text: inThousands(w.budget), style: WfText.money(13, weight: FontWeight.w600, color: wf.ink)),
              TextSpan(text: w.carried > 0 ? ' مال هالأسبوع (وياها ${inThousands(w.carried)} زايدة من الأسبوع الفات)' : ' مال هالأسبوع'),
            ]),
            style: TextStyle(fontSize: 13, color: wf.mute, height: 1.5),
          ),
        ],
      ),
    );
  }

  static String _hello(DateTime now) => now.hour < 12 ? 'صباح الخير' : 'مساء الخير';
}

/// Three real notes fanned out beside the number.
class _NoteFan extends StatelessWidget {
  const _NoteFan({required this.denominations});
  final List<int> denominations;

  @override
  Widget build(BuildContext context) {
    const turns = [-.2, -.08, .09];
    const tops = [40.0, 24.0, 6.0];
    final list = denominations.length == 1
        ? [denominations.first, denominations.first, denominations.first]
        : denominations.length == 2
        ? [denominations.first, denominations.first, denominations.last]
        : denominations;
    return ExcludeSemantics(
      child: SizedBox(
        width: 124,
        height: 96,
        child: Stack(clipBehavior: Clip.none, children: [
          for (var i = 0; i < 3; i++)
            Positioned(
              left: 4.0 + i * 3,
              top: tops[i],
              child: Transform.rotate(angle: turns[i], child: MiniNote(list[i], width: 110, showLabel: i == 2)),
            ),
        ]),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('وين فلوسي', style: TextStyle(fontFamily: WfText.brand, fontSize: 23, color: wf.brand, height: 1.25)),
                Text(_date(snap.now), style: TextStyle(fontSize: 12, color: wf.mute, height: 1.4)),
              ],
            ),
          ),
          Tooltip(
            message: 'سعر الدولار اليوم',
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: wf.surface.withValues(alpha: .7), borderRadius: BorderRadius.circular(99), border: Border.all(color: wf.line)),
              child: Row(children: [
                Text('الدولار ', style: TextStyle(color: wf.mute, fontSize: 12)),
                Text(formatAmount(snap.household.usdRate), style: WfText.money(12, weight: FontWeight.w500, color: wf.ink)),
              ]),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            tooltip: dark ? 'الوضع النهاري' : 'الوضع الليلي',
            onPressed: () => ref.read(themeModeProvider.notifier).set(dark ? ThemeMode.light : ThemeMode.dark),
            icon: Icon(dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, color: wf.mute, size: 20),
          ),
          Semantics(
            button: true,
            label: 'أنت ${snap.me.displayName}. افتحوا العائلة',
            excludeSemantics: true,
            child: GestureDetector(
              onTap: () => ref.read(tabProvider.notifier).go(3),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: dark ? const Color(0xFF8C6D2B) : const Color(0xFFE3D3A6), width: 1.5)),
                child: MemberAvatar(snap.me, size: 36),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _months = ['كانون الثاني', 'شباط', 'آذار', 'نيسان', 'أيار', 'حزيران', 'تموز', 'آب', 'أيلول', 'تشرين الأول', 'تشرين الثاني', 'كانون الأول'];
  static const _days = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
  static String _date(DateTime d) => '${_days[d.weekday - 1]}، ${d.day} ${_months[d.month - 1]}';
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
                        WfIcon(WfGlyph.small, size: 22, color: wf.tintInk, background: wf.tint),
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
    final wf = Wf.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final n = snap.inbox.length;
    final tileBg = dark ? const Color(0xFF15302A) : Colors.white;
    final amounts = snap.inbox.take(3).map((x) => inThousands(roundTo(x.amountMinor, 1000))).join(' · ');
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Material(
        color: dark ? const Color(0x1AE9C979) : wf.warnBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: dark ? const BorderSide(color: Color(0x40E9C979)) : BorderSide.none,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => showWfSheet(context, (_) => const InboxSheet(), heightFactor: .78),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Stack(clipBehavior: Clip.none, children: [
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: tileBg, borderRadius: BorderRadius.circular(14)),
                    child: WfIcon(WfGlyph.qiInbox, size: 28, color: dark ? wf.gold : Wf.vaultGreen, background: tileBg),
                  ),
                  PositionedDirectional(
                    top: -5,
                    end: -5,
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 20),
                      height: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: const Color(0xFFC4553A), borderRadius: BorderRadius.circular(10)),
                      child: Text('$n', style: const TextStyle(fontFamily: WfText.num, fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white, height: 1.2)),
                    ),
                  ),
                ]),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n == 1 ? 'صرفة من الكي كارد تنتظركم' : 'صرفات من الكي كارد تنتظركم',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, height: 1.4),
                      ),
                      Text(amounts, style: TextStyle(fontSize: 12.5, color: dark ? const Color(0xFFD9C79A) : const Color(0xFF6B5A2B), height: 1.4)),
                    ],
                  ),
                ),
                Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: dark ? const Color(0xFFE9C979) : const Color(0xFF111714), borderRadius: BorderRadius.circular(12)),
                  child: Text('أكّدوها', style: TextStyle(color: dark ? const Color(0xFF2B1D00) : Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
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
    final fill = dark ? const Color(0xFF3E9C84) : const Color(0xFF1B675B);
    final hot = dark ? const Color(0xFFD9765A) : const Color(0xFFC4553A);
    final track = dark ? const Color(0x14FFFFFF) : const Color(0xFFEEF2F0);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Row(
        children: [
          for (var i = 0; i < 7; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            Expanded(
              child: Semantics(
                label: i > week.todayIndex ? '${kArabicWeekdays[i]}، بعد ما إجا' : '${kArabicWeekdays[i]}، صرفتوا ${formatAmount(week.dayTotals[i])}',
                excludeSemantics: true,
                child: Column(
                  children: [
                    Container(
                      height: 28,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: i > week.todayIndex ? Colors.transparent : track,
                        borderRadius: BorderRadius.circular(8),
                        border: i > week.todayIndex
                            ? Border.all(color: dark ? const Color(0xFF2C4A42) : const Color(0xFFD3DBD7))
                            : i == week.todayIndex
                            ? Border.all(color: dark ? const Color(0xFFF2A88F) : wf.ink, width: 2)
                            : null,
                      ),
                      alignment: Alignment.bottomCenter,
                      child: i > week.todayIndex
                          ? null
                          : TweenAnimationBuilder<double>(
                              tween: Tween(end: (week.dayTotals[i] / (share * 1.25)).clamp(0.0, 1.0)),
                              duration: const Duration(milliseconds: 600),
                              curve: const SpringCurve(),
                              builder: (_, v, _) => FractionallySizedBox(
                                heightFactor: v,
                                widthFactor: 1,
                                child: ColoredBox(color: week.dayTotals[i] > share ? hot : fill),
                              ),
                            ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      i > week.todayIndex ? '—' : _k(week.dayTotals[i]),
                      style: WfText.money(
                        11.5,
                        weight: i == week.todayIndex ? FontWeight.w600 : FontWeight.w400,
                        color: i > week.todayIndex ? wf.faint : (week.dayTotals[i] > share ? (dark ? const Color(0xFFF2A88F) : const Color(0xFFA6412A)) : wf.ink),
                        height: 1.3,
                      ),
                    ),
                    Text(
                      i == week.todayIndex ? 'اليوم' : kArabicWeekdays[i],
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 10.5,
                        height: 1.4,
                        color: i == week.todayIndex ? wf.ink : (i > week.todayIndex ? wf.faint : wf.mute),
                        fontWeight: i == week.todayIndex ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Day totals in thousands: a small column reads "26", not "26,000".
  String _k(int v) => v == 0 ? '0' : v < 1000 ? formatAmount(v) : '${(v / 1000).round()}';
}

class _RowButton extends StatelessWidget {
  const _RowButton({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final WfGlyph icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    return WfCard(
      radius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      onTap: onTap,
      child: Row(
        children: [
          WfIconTile(icon, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.4)),
                Text(subtitle, style: TextStyle(fontSize: 12, color: wf.mute, height: 1.4), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Icon(Icons.chevron_left, color: wf.mute),
        ],
      ),
    );
  }
}

/// The family's envelopes at a glance; tapping opens the envelopes tab.
class _EnvelopeStrip extends ConsumerWidget {
  const _EnvelopeStrip({required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final list = [
      ...snap.envelopes.where((e) => e.envelope.kind == 'vault'),
      ...snap.envelopes.where((e) => e.envelope.kind != 'vault' && e.envelope.kind != 'sadaqa'),
    ].take(3).toList();
    if (list.isEmpty) return const SizedBox.shrink();
    final card = dark ? wf.surface : Colors.white;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            const Padding(padding: EdgeInsetsDirectional.only(start: 4), child: Text('ظروفكم', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
            const Spacer(),
            TextButton(
              onPressed: () => ref.read(tabProvider.notifier).go(1),
              style: TextButton.styleFrom(foregroundColor: dark ? wf.mint : Wf.vaultGreen, minimumSize: const Size(48, 40)),
              child: const Text('كل الظروف ←', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ]),
          Row(
            children: [
              for (var i = 0; i < list.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: Material(
                    color: card,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: wf.line)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => ref.read(tabProvider.notifier).go(1),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              WfIcon(list[i].envelope.kind == 'vault' ? WfGlyph.vault : WfGlyph.envelopes, size: 22, color: dark ? wf.mint : Wf.vaultGreen, background: card),
                              const SizedBox(width: 6),
                              Expanded(child: Text(list[i].envelope.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: wf.mute))),
                            ]),
                            const SizedBox(height: 4),
                            Text(inThousands(list[i].balance), maxLines: 1, style: WfText.money(17, weight: FontWeight.w500, color: wf.ink, height: 1.3)),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: list[i].envelope.targetMinor <= 0 ? 0 : list[i].progress,
                                minHeight: 6,
                                backgroundColor: dark ? const Color(0x14FFFFFF) : const Color(0xFFEEF2F0),
                                color: list[i].envelope.kind == 'vault' ? wf.gold : (dark ? const Color(0xFF3E9C84) : const Color(0xFF1B675B)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
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
        SectionTitle('صرفات اليوم', trailing: total == 0 ? null : 'المجموع ${inThousands(total)}', padding: const EdgeInsets.fromLTRB(20, 16, 20, 2)),
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
                  WfIconTile(glyphForCategory(x.categoryKey ?? 'other'), size: 42),
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
