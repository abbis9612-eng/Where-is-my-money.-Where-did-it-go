import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ween_floosi/core/money.dart';
import 'package:ween_floosi/data/database.dart';
import 'package:ween_floosi/data/demo.dart';
import 'package:ween_floosi/data/repository.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late AppDatabase db;
  late Repository repo;
  var clock = DateTime(2026, 10, 13, 9, 41); // a Tuesday

  setUp(() async {
    clock = DateTime(2026, 10, 13, 9, 41);
    db = AppDatabase(NativeDatabase.memory());
    repo = Repository(db, clock: () => clock);
  });
  tearDown(() => db.close());

  Future<void> basicHousehold() => repo.createHousehold(const HouseholdSetup(
        familyName: 'بيتنا',
        meName: 'بابا',
        partnerName: 'ماما',
        kidNames: ['حسن'],
        salary: 1250000,
        payDay: 1,
        savePercent: 10,
        envelopesMonthly: 130000,
        bills: [
          BillSetup('المولدة', 'bolt', 75000, 'generator', day: 15, amps: 6, pricePerAmp: 12500),
          BillSetup('الإنترنت', 'wifi', 35000, 'phone_net', day: 1),
          BillSetup('رصيد', 'phone', 20000, 'phone_net', day: 1),
          BillSetup('نقل', 'bus', 15000, 'other', day: 1),
        ],
      ));

  test('onboarding builds a full household', () async {
    expect(await repo.hasHousehold(), isFalse);
    await basicHousehold();
    final s = (await repo.loadSnapshot())!;
    expect(s.members.map((m) => m.role), ['owner', 'member', 'child']);
    expect(s.wallets.map((w) => w.wallet.kind), containsAll(['qi_card', 'cash']));
    expect(s.vault!.envelope.locked, isTrue);
    expect(s.fixedBillsTotal, 145000);
    expect(s.envelopesMonthlyTotal, 130000);
    expect(s.monthlyPlan.spendable, 850000);
    // 850,000 × 7 ÷ 31 → 192,000
    expect(s.weeklyAllowance, 192000);
    expect(s.week.left, 192000);
    expect(s.household.inviteCode, startsWith('WF-'));
    expect(s.kids.single.profile.goalMinor, 60000);
  });

  test('expenses reduce the week; fixed bills do not', () async {
    await basicHousehold();
    final s0 = (await repo.loadSnapshot())!;
    final ids = await repo.addExpenses([
      ExpenseDraft(label: 'صمون', categoryKey: 'bread_veg', amountMinor: 2000, memberId: s0.me.id),
      ExpenseDraft(label: 'بنزين', categoryKey: 'fuel', amountMinor: 25000, memberId: s0.me.id),
      const ExpenseDraft(label: 'مولدة', categoryKey: 'generator', amountMinor: 75000),
    ]);
    final s1 = (await repo.loadSnapshot())!;
    expect(s1.week.spent, 27000);
    expect(s1.week.left, 192000 - 27000);
    expect(s1.spentByMember[s0.me.id], 27000);

    await repo.softDelete(ids.take(1).toList());
    final s2 = (await repo.loadSnapshot())!;
    expect(s2.week.spent, 25000);
  });

  test('dollars are frozen at the rate of the day', () async {
    await basicHousehold();
    await repo.addExpenses([const ExpenseDraft(label: 'كتاب', categoryKey: 'other', amountMinor: 5000, currency: Currency.usd)]);
    await repo.setUsdRate(1600);
    final tx = (await db.select(db.txns).get()).single;
    expect(tx.amountBase, 76000);
    expect(tx.fxRate, 1520);
  });

  test('payday saves first and funds envelopes', () async {
    await basicHousehold();
    final s = (await repo.loadSnapshot())!;
    await repo.runPayday(salary: 1250000, savePercent: 10, walletId: s.walletOfKind('qi_card')!.id);
    final s2 = (await repo.loadSnapshot())!;
    expect(s2.vault!.balance, 125000);
    final eid = s2.envelopes.firstWhere((e) => e.envelope.name == 'العيد');
    expect(eid.balance, 32500);
    expect(s2.week.spent, 0, reason: 'income and set-asides are not spending');
  });

  test('friday close moves leftover to the vault and carries the rest', () async {
    await basicHousehold();
    final s = (await repo.loadSnapshot())!;
    await repo.closeWeek(weekStart: s.week.weekStart, leftover: 15000, toVault: 10000);
    expect((await repo.loadSnapshot())!.vault!.balance, 10000);
    clock = DateTime(2026, 10, 17, 10); // next Saturday
    final next = (await repo.loadSnapshot())!;
    expect(next.week.carried, 5000);
    expect(next.week.left, next.weeklyAllowance + 5000);
  });

  test('counting the wallet logs the gap as small spending', () async {
    await basicHousehold();
    final s = (await repo.loadSnapshot())!;
    final cash = s.walletOfKind('cash', ownerId: s.me.id)!.id;
    final first = await repo.countWallet(walletId: cash, counted: 64000, memberId: s.me.id);
    expect(first.gap, 0, reason: 'first count only sets the starting point');
    clock = clock.add(const Duration(hours: 5));
    final second = await repo.countWallet(walletId: cash, counted: 52000, memberId: s.me.id);
    expect(second.gap, 12000);
    final s2 = (await repo.loadSnapshot())!;
    expect(s2.week.spent, 12000);
    expect((await repo.walletBalance(cash)).balance, 52000);
  });

  test('ATM withdrawal is a move to cash, not spending', () async {
    await basicHousehold();
    final s = (await repo.loadSnapshot())!;
    final card = s.walletOfKind('qi_card')!.id;
    final cash = s.walletOfKind('cash', ownerId: s.me.id)!.id;
    await repo.countWallet(walletId: cash, counted: 10000);
    await repo.withdrawCash(fromWalletId: card, toWalletId: cash, amount: 100000);
    expect((await repo.walletBalance(cash)).balance, 110000);
    expect((await repo.loadSnapshot())!.week.spent, 0);
  });

  test('bank messages: dedupe, accept as expense, dismiss', () async {
    await basicHousehold();
    final msgs = [
      (key: 'a', sender: 'Qi Card', body: 'تم خصم 12,500 د.ع من بطاقتك لدى SHIFA PHARMACY', at: clock),
      (key: 'a', sender: 'Qi Card', body: 'تم خصم 12,500 د.ع من بطاقتك لدى SHIFA PHARMACY', at: clock),
      (key: 'b', sender: 'Qi Card', body: 'رمز التحقق 1234', at: clock),
      (key: 'c', sender: 'Qi Card', body: 'Purchase of IQD 18,000 at AL REEM REST', at: clock),
    ];
    expect(await repo.addSmsMessages(msgs), 2);
    var s = (await repo.loadSnapshot())!;
    expect(s.inbox, hasLength(2));
    final pharmacy = s.inbox.firstWhere((i) => i.merchant == 'SHIFA PHARMACY');
    expect(pharmacy.suggestedCategory, 'health');
    await repo.acceptInbox(pharmacy.id, categoryKey: 'health', memberId: s.me.id);
    await repo.dismissInbox(s.inbox.firstWhere((i) => i.id != pharmacy.id).id);
    s = (await repo.loadSnapshot())!;
    expect(s.inbox, isEmpty);
    expect(s.week.spent, 12500);
  });

  test('bills post once a month on their day', () async {
    await basicHousehold();
    expect(await repo.postDueBills(), 3); // day 1 bills; generator is on the 15th
    expect(await repo.postDueBills(), 0);
    clock = DateTime(2026, 10, 15, 8);
    expect(await repo.postDueBills(), 1);
    expect((await repo.loadSnapshot())!.week.spent, 0, reason: 'bills are not weekly spending');
  });

  test('generator bill is amps times price', () async {
    await basicHousehold();
    final bill = (await repo.loadSnapshot())!.bills.firstWhere((b) => b.categoryKey == 'generator');
    await repo.updateGeneratorBill(bill.id, amps: 8, pricePerAmp: 12000);
    final b2 = (await repo.loadSnapshot())!.bills.firstWhere((b) => b.id == bill.id);
    expect(b2.amountMinor, 96000);
  });

  test('kid jars with parent match', () async {
    await basicHousehold();
    final kid = (await repo.loadSnapshot())!.kids.single.member.id;
    await repo.kidAllowance(kid, 5000);
    await repo.kidDeposit(kid, 'save', 1000);
    var k = (await repo.loadSnapshot())!.kids.single;
    expect(k.spend, 2500);
    expect(k.give, 500);
    expect(k.save, 2000 + 1000 + 500);
    expect(k.matched, 500);
    expect(await repo.kidSpend(kid, 'spend', 3000), isFalse);
    expect(await repo.kidSpend(kid, 'spend', 1000), isTrue);
    k = (await repo.loadSnapshot())!.kids.single;
    expect(k.spend, 1500);
  });

  test('debts and rosca', () async {
    await basicHousehold();
    await repo.addDebt(person: 'أبو حسن', theyOweUs: true, amount: 50000);
    final d = (await repo.loadSnapshot())!.debts.single;
    await repo.payDebt(d.id, 20000);
    await repo.payDebt(d.id, 90000);
    expect((await repo.loadSnapshot())!.debts.single.paidMinor, 50000);
    await repo.addRosca(name: 'جمعية', members: 10, contribution: 100000, startYear: 2026, startMonth: 7, myTurn: 7);
    final r = (await repo.loadSnapshot())!.roscas.single;
    await repo.payRoscaRound(r.id);
    expect((await repo.loadSnapshot())!.roscas.single.paidRounds, 1);
  });

  test('demo family matches the design numbers', () async {
    await seedDemo(repo);
    final s = (await repo.loadSnapshot())!;
    expect(s.isDemo, isTrue);
    expect(s.week.dayTotals.take(4), [26000, 19000, 6500, 31500]);
    expect(s.week.spent, 83000);
    expect(s.vault!.balance, 375000);
    expect(s.inbox, hasLength(3));
    expect(s.quickPicks.map((q) => q.label), containsAll(['صمون وخضرة', 'بنزين', 'خبز']));
    final report = await repo.monthReport(2026, 9);
    expect(report.income, 1250000);
    expect(report.spent, 1310000);
    expect(report.fromVault, 60000);
    expect(report.leak?.key, 'eating_out');
    expect(report.leak?.count, 14);
    expect(report.leakSaving, inInclusiveRange(80000, 100000));
  });

  test('snapshot stream updates after a write', () async {
    await basicHousehold();
    final stream = repo.watchSnapshot();
    final values = <int>[];
    final sub = stream.listen((s) => values.add(s!.week.spent));
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await repo.addExpenses([const ExpenseDraft(label: 'خبز', categoryKey: 'bread_veg', amountMinor: 1000)]);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    await sub.cancel();
    expect(values.first, 0);
    expect(values.last, 1000);
  });
}
