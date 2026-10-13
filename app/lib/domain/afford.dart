/// "أكدر أشتريه؟" — can we buy it from this week's money?
library;

import '../core/money.dart';

enum AffordLevel { idle, yes, tight, no }

class AffordAnswer {
  const AffordAnswer({
    required this.level,
    required this.price,
    required this.left,
    required this.after,
    required this.perDayAfter,
    required this.maxComfortable,
    required this.weeksToSave,
  });

  final AffordLevel level;
  final int price;
  final int left;
  final int after;
  final int perDayAfter;

  /// The highest price that still leaves [minPerDay] for each remaining day.
  final int maxComfortable;

  /// Weeks to save for it at the suggested weekly saving.
  final int weeksToSave;

  int get shortBy => after < 0 ? -after : 0;
}

AffordAnswer canAfford({
  required int price,
  required int left,
  required int daysLeft,
  int minPerDay = 15000,
  int weeklySaving = 50000,
}) {
  final days = daysLeft < 1 ? 1 : daysLeft;
  final after = left - price;
  final perDay = floorTo(after < 0 ? 0 : after ~/ days, 250);
  final cap = floorTo(left - minPerDay * days, 1000);
  final AffordLevel level;
  if (price <= 0) {
    level = AffordLevel.idle;
  } else if (after >= 0 && perDay >= minPerDay) {
    level = AffordLevel.yes;
  } else if (after >= 0) {
    level = AffordLevel.tight;
  } else {
    level = AffordLevel.no;
  }
  return AffordAnswer(
    level: level,
    price: price,
    left: left,
    after: after,
    perDayAfter: perDay,
    maxComfortable: cap < 0 ? 0 : cap,
    weeksToSave: price <= 0 ? 0 : (price + weeklySaving - 1) ~/ weeklySaving,
  );
}
