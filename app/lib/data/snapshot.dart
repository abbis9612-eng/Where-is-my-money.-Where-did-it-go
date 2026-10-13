/// Read models the screens render. Built from the database in one pass so
/// every screen sees the same numbers.
library;

import '../domain/budget.dart';
import 'database.dart';

class EnvelopeView {
  const EnvelopeView(this.envelope, this.balance);
  final Envelope envelope;
  final int balance;
  double get progress => envelope.targetMinor <= 0 ? 0 : (balance / envelope.targetMinor).clamp(0, 1).toDouble();
}

class WalletView {
  const WalletView(this.wallet, this.balance, {required this.counted});
  final Wallet wallet;

  /// What should be in the wallet according to what was recorded.
  final int balance;

  /// False until the first count sets a starting point.
  final bool counted;
}

class KidView {
  const KidView({required this.member, required this.profile, required this.spend, required this.save, required this.give, required this.matched});
  final Member member;
  final KidProfile profile;
  final int spend;
  final int save;
  final int give;

  /// Part of [save] that parents added.
  final int matched;
  double get goalProgress => profile.goalMinor <= 0 ? 0 : (save / profile.goalMinor).clamp(0, 1).toDouble();
}

class QuickPick {
  const QuickPick({required this.label, required this.categoryKey, required this.amount, required this.walletId, required this.times});
  final String label;
  final String categoryKey;
  final int amount;
  final String? walletId;
  final int times;
}

class Snapshot {
  const Snapshot({
    required this.now,
    required this.household,
    required this.me,
    required this.members,
    required this.wallets,
    required this.categories,
    required this.envelopes,
    required this.plan,
    required this.bills,
    required this.debts,
    required this.roscas,
    required this.kids,
    required this.week,
    required this.weeklyAllowance,
    required this.recent,
    required this.inbox,
    required this.quickPicks,
    required this.spentByMember,
    required this.isDemo,
  });

  final DateTime now;
  final Household household;
  final Member me;
  final List<Member> members;
  final List<WalletView> wallets;
  final List<Category> categories;
  final List<EnvelopeView> envelopes;
  final Plan plan;
  final List<Bill> bills;
  final List<Debt> debts;
  final List<Rosca> roscas;
  final List<KidView> kids;
  final WeekStatus week;
  final int weeklyAllowance;

  /// Latest transactions, newest first.
  final List<Txn> recent;
  final List<InboxItem> inbox;
  final List<QuickPick> quickPicks;

  /// Variable spending this week per member id.
  final Map<String, int> spentByMember;
  final bool isDemo;

  List<Member> get adults => members.where((m) => m.role != 'child').toList();

  EnvelopeView? get vault {
    for (final e in envelopes) {
      if (e.envelope.kind == 'vault') return e;
    }
    return null;
  }

  Member? memberById(String? id) {
    for (final m in members) {
      if (m.id == id) return m;
    }
    return null;
  }

  Category? categoryByKey(String? key) {
    for (final c in categories) {
      if (c.key == key) return c;
    }
    return null;
  }

  String categoryName(String? key) => categoryByKey(key)?.name ?? 'غيرها';

  Wallet? walletOfKind(String kind, {String? ownerId}) {
    for (final w in wallets) {
      if (w.wallet.kind == kind && (ownerId == null || w.wallet.ownerMemberId == ownerId)) return w.wallet;
    }
    return null;
  }

  int get fixedBillsTotal => bills.where((b) => b.active).fold(0, (a, b) => a + b.amountMinor);
  int get envelopesMonthlyTotal =>
      envelopes.where((e) => e.envelope.kind != 'vault').fold(0, (a, e) => a + e.envelope.monthlyMinor);

  MonthlyPlan get monthlyPlan => MonthlyPlan(
        salary: plan.salary,
        savePercent: plan.savePercent,
        envelopesMonthly: envelopesMonthlyTotal,
        fixedBills: fixedBillsTotal,
        payDay: plan.payDay,
      );
}

class CategorySpend {
  const CategorySpend({required this.key, required this.name, required this.amount, required this.count, required this.isWant});
  final String key;
  final String name;
  final int amount;
  final int count;
  final bool isWant;
}

class MonthReport {
  const MonthReport({
    required this.year,
    required this.month,
    required this.income,
    required this.spent,
    required this.fromVault,
    required this.byCategory,
    required this.leak,
    required this.leakSaving,
  });

  final int year;
  final int month;
  final int income;
  final int spent;

  /// Money taken out of the vault this month to cover spending.
  final int fromVault;
  final List<CategorySpend> byCategory;

  /// The "want" spent most often, the clearest thing to cut.
  final CategorySpend? leak;

  /// Rough monthly saving if the leak happened once a week instead.
  final int leakSaving;

  int get gap => spent - income;
}
