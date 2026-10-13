/// The weekly allowance: one number a family can live by.
///
/// spendable per month = salary − save first − envelopes − fixed bills
/// weekly allowance   = spendable × 7 ÷ days in this pay cycle (rounded to 1,000)
/// left this week     = allowance + carried over − variable spending this week
/// about per day      = left ÷ days left including today (rounded down to 250)
///
/// Weeks run Saturday to Friday, the Iraqi week, so the Friday session closes it.
library;

import '../core/money.dart';

/// Saturday 00:00 of the week containing [day].
DateTime weekStartOf(DateTime day) {
  final d = DateTime(day.year, day.month, day.day);
  return d.subtract(Duration(days: dayIndexInWeek(d)));
}

/// 0 = Saturday … 6 = Friday.
int dayIndexInWeek(DateTime day) => (day.weekday + 1) % 7;

/// Days left in the week counting today (Saturday = 7, Friday = 1).
int daysLeftInWeek(DateTime day) => 7 - dayIndexInWeek(day);

const kArabicWeekdays = ['سبت', 'أحد', 'اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة'];

const kIraqiMonths = [
  'كانون الثاني', 'شباط', 'آذار', 'نيسان', 'أيار', 'حزيران',
  'تموز', 'آب', 'أيلول', 'تشرين الأول', 'تشرين الثاني', 'كانون الأول',
];

String iraqiMonthName(int month) => kIraqiMonths[(month - 1) % 12];

class MonthlyPlan {
  const MonthlyPlan({
    required this.salary,
    required this.savePercent,
    required this.envelopesMonthly,
    required this.fixedBills,
    required this.payDay,
  });

  /// Expected monthly income in dinars.
  final int salary;

  /// Share saved to the family vault the moment the salary lands.
  final int savePercent;
  final int envelopesMonthly;
  final int fixedBills;

  /// Day of month the salary arrives (1–28).
  final int payDay;

  int get saveFirst => salary * savePercent ~/ 100;

  int get spendable {
    final v = salary - saveFirst - envelopesMonthly - fixedBills;
    return v < 0 ? 0 : v;
  }

  MonthlyPlan copyWith({int? salary, int? savePercent, int? envelopesMonthly, int? fixedBills, int? payDay}) => MonthlyPlan(
        salary: salary ?? this.salary,
        savePercent: savePercent ?? this.savePercent,
        envelopesMonthly: envelopesMonthly ?? this.envelopesMonthly,
        fixedBills: fixedBills ?? this.fixedBills,
        payDay: payDay ?? this.payDay,
      );
}

/// The pay cycle containing [day]: from the last payday up to the next one.
({DateTime start, DateTime end}) payCycleOf(DateTime day, int payDay) {
  final d = DateTime(day.year, day.month, day.day);
  final pd = payDay.clamp(1, 28);
  final thisMonth = DateTime(d.year, d.month, pd);
  final start = d.isBefore(thisMonth) ? DateTime(d.year, d.month - 1, pd) : thisMonth;
  final end = DateTime(start.year, start.month + 1, pd);
  return (start: start, end: end);
}

int weeklyAllowance(MonthlyPlan plan, DateTime day) {
  final cycle = payCycleOf(day, plan.payDay);
  final days = cycle.end.difference(cycle.start).inHours ~/ 24;
  if (days <= 0) return 0;
  return roundTo(plan.spendable * 7 ~/ days, 1000);
}

class WeekStatus {
  const WeekStatus({
    required this.weekStart,
    required this.allowance,
    required this.carried,
    required this.spent,
    required this.dayTotals,
    required this.todayIndex,
  });

  final DateTime weekStart;
  final int allowance;
  final int carried;
  final int spent;

  /// Variable spending per day, Saturday first.
  final List<int> dayTotals;
  final int todayIndex;

  int get budget => allowance + carried;
  int get left => budget - spent;
  int get daysLeft => 7 - todayIndex;
  bool get over => left < 0;

  /// "About X a day" for the rest of the week, never more than is left.
  int get perDay => floorTo(left ~/ daysLeft, 250);

  /// Even daily share, used to colour days that went over.
  int get dailyShare => budget ~/ 7;
}

class DatedAmount {
  const DatedAmount(this.at, this.amount);
  final DateTime at;
  final int amount;
}

WeekStatus computeWeek({
  required DateTime now,
  required int allowance,
  required int carried,
  required Iterable<DatedAmount> variableSpending,
}) {
  final start = weekStartOf(now);
  final end = start.add(const Duration(days: 7));
  final totals = List<int>.filled(7, 0);
  var spent = 0;
  for (final e in variableSpending) {
    if (e.at.isBefore(start) || !e.at.isBefore(end)) continue;
    totals[dayIndexInWeek(e.at)] += e.amount;
    spent += e.amount;
  }
  return WeekStatus(
    weekStart: start,
    allowance: allowance,
    carried: carried,
    spent: spent,
    dayTotals: totals,
    todayIndex: dayIndexInWeek(now),
  );
}

/// How a salary is divided on payday, save first.
class PaydaySplit {
  const PaydaySplit({required this.save, required this.envelopes, required this.bills, required this.spend, required this.weekly});
  final int save;
  final int envelopes;
  final int bills;
  final int spend;
  final int weekly;
}

PaydaySplit splitSalary(MonthlyPlan plan, DateTime day) => PaydaySplit(
      save: plan.saveFirst,
      envelopes: plan.envelopesMonthly,
      bills: plan.fixedBills,
      spend: plan.spendable,
      weekly: weeklyAllowance(plan, day),
    );
