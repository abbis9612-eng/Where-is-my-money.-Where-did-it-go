/// الجمعية: a rotating savings group. The app only keeps the schedule and who
/// paid; it never holds or moves money.
library;

import 'budget.dart';

class Rosca {
  const Rosca({
    required this.members,
    required this.contribution,
    required this.startYear,
    required this.startMonth,
    required this.myTurn,
    required this.paidRounds,
  });

  final int members;

  /// What each member pays every round.
  final int contribution;
  final int startYear;

  /// Month of round 1 (1–12).
  final int startMonth;

  /// Our position in the order, 1-based.
  final int myTurn;

  /// Rounds we have paid so far.
  final int paidRounds;

  int get payout => members * contribution;

  DateTime monthOfRound(int round) => DateTime(startYear, startMonth + round - 1, 1);

  DateTime get myPayoutMonth => monthOfRound(myTurn);

  int get roundsLeftToPay => members - paidRounds;

  /// Paid in so far minus received so far.
  int netPosition({required int currentRound}) {
    final paidIn = paidRounds * contribution;
    final received = currentRound >= myTurn ? payout : 0;
    return received - paidIn;
  }

  /// Round number for [day] (1-based), or 0 before the first round.
  int roundAt(DateTime day) {
    final months = (day.year - startYear) * 12 + day.month - startMonth;
    return months < 0 ? 0 : (months + 1).clamp(0, members);
  }

  String payoutLabel() => '${iraqiMonthName(myPayoutMonth.month)} ${myPayoutMonth.year}';
}
