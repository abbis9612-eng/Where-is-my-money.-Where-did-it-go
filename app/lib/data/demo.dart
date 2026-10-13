/// Sample family used when someone chooses "جرّبوا ببيانات تجريبية" at first
/// launch, and by tests and screenshots. Clearly flagged as demo in the UI and
/// removable from settings.
library;

import 'package:drift/drift.dart';

import '../domain/budget.dart';
import 'database.dart';
import 'repository.dart';

Future<void> seedDemo(Repository repo) async {
  await repo.createHousehold(
    const HouseholdSetup(
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
        BillSetup('الإنترنت', 'wifi', 35000, 'phone_net', day: 20),
        BillSetup('رصيد الموبايلات', 'phone', 20000, 'phone_net', day: 1),
        BillSetup('نقل المدرسة', 'bus', 15000, 'other', day: 1),
      ],
    ),
    demo: true,
  );

  final snap = (await repo.loadSnapshot())!;
  final db = repo.db;
  final now = repo.now();
  final dad = snap.members.firstWhere((m) => m.role == 'owner').id;
  final mum = snap.members.firstWhere((m) => m.role == 'member').id;
  final kid = snap.members.firstWhere((m) => m.role == 'child').id;
  final card = snap.walletOfKind('qi_card')!.id;
  final dadCash = snap.walletOfKind('cash', ownerId: dad)!.id;
  final mumCash = snap.walletOfKind('cash', ownerId: mum)!.id;
  final vault = snap.vault!.envelope.id;

  Future<void> tx(DateTime at, String kind, int amount, {String? cat, String label = '', String? member, String? wallet, String? toWallet, String? envelope, String source = 'manual', bool counts = false}) async {
    await db.into(db.txns).insert(TxnsCompanion.insert(
          id: repo.newId(), householdId: snap.household.id, createdAt: at, updatedAt: at, kind: kind,
          amountMinor: amount, amountBase: amount, categoryKey: Value(cat), label: Value(label), memberId: Value(member),
          walletId: Value(wallet), toWalletId: Value(toWallet), envelopeId: Value(envelope), occurredAt: at,
          source: Value(source), countsInWeek: Value(counts),
        ));
  }

  // Envelope balances built up over earlier months.
  final longAgo = DateTime(now.year, now.month - 3, 2);
  // 435,000 saved, minus the 60,000 taken last month = 375,000 today.
  await tx(longAgo, 'envelope_in', 435000, envelope: vault, source: 'payday');
  for (final e in snap.envelopes) {
    final bal = switch (e.envelope.name) {
      'العيد' => 120000,
      'المدارس' => 90000,
      'مولدة الصيف' => 140000,
      'العلاج' => 60000,
      _ => e.envelope.kind == 'goal' ? 210000 : 0,
    };
    if (bal > 0 && e.envelope.kind != 'vault') await tx(longAgo, 'envelope_in', bal, envelope: e.envelope.id, source: 'payday');
  }

  // Last month, for the "where did it go" report: income 1,250,000, spent 1,310,000.
  final lm = DateTime(now.year, now.month - 1, 1);
  await tx(DateTime(lm.year, lm.month, 1, 9), 'income', 1250000, cat: 'salary', label: 'راتب', member: dad, wallet: card, source: 'payday');
  await tx(DateTime(lm.year, lm.month, 28, 20), 'envelope_out', 60000, envelope: vault, label: 'من الخزنة');
  final monthly = <(String, String, int, int)>[
    ('groceries', 'بقالة', 420000, 31),
    ('kid', 'حفاظات وحليب', 160000, 8),
    ('generator', 'المولدة', 150000, 2),
    ('eating_out', 'مطعم', 135000, 14),
    ('fuel', 'بنزين', 120000, 4),
    ('other', 'غيرها', 325000, 9),
  ];
  for (final (cat, label, total, count) in monthly) {
    final each = total ~/ count;
    for (var i = 0; i < count; i++) {
      final day = 1 + (i * 29 ~/ count);
      // Real spending varies; equal amounts would look like a repeated habit.
      final wobble = ((i % 3) - 1) * 1250;
      final amount = i == count - 1 ? total - (each * (count - 1) + _wobbleSum(count - 1)) : each + wobble;
      await tx(DateTime(lm.year, lm.month, day, 10 + i % 8), 'expense', amount, cat: cat, label: label, member: i.isEven ? dad : mum, wallet: i.isEven ? dadCash : card);
    }
  }

  // This week: Saturday 26,000, Sunday 19,000, Monday 6,500 and today 31,500.
  final ws = weekStartOf(now);
  Future<void> spend(int dayIdx, int hour, String cat, String label, int amount, String member, String wallet, {String source = 'manual'}) {
    final at = ws.add(Duration(days: dayIdx, hours: hour));
    return tx(at.isAfter(now) ? now.subtract(const Duration(minutes: 30)) : at, 'expense', amount,
        cat: cat, label: label, member: member, wallet: wallet, source: source, counts: true);
  }

  final today = dayIndexInWeek(now);
  if (today >= 1) {
    await spend(0, 9, 'bread_veg', 'صمون وخضرة', 7500, dad, dadCash, source: 'quick');
    await spend(0, 18, 'groceries', 'بقالة', 18500, mum, card);
  }
  if (today >= 2) {
    await spend(1, 9, 'bread_veg', 'صمون وخضرة', 7500, dad, dadCash, source: 'quick');
    await spend(1, 17, 'fuel', 'بنزين', 11500, dad, dadCash);
  }
  if (today >= 3) {
    await spend(2, 13, 'health', 'صيدلية', 6500, mum, mumCash);
  }
  await spend(today, 7, 'bread_veg', 'صمون وخضرة', 7500, dad, dadCash, source: 'quick');
  await spend(today, 8, 'kid', 'حفاظات وحليب', 24000, mum, card, source: 'sms');

  // Earlier repeats so one-tap suggestions appear.
  // Kept inside this month so last month's report stays exactly as designed.
  for (var i = 1; i <= 3; i++) {
    final fuelDay = ws.subtract(Duration(days: i * 2));
    final breadDay = ws.subtract(Duration(days: i * 2 + 1));
    if (fuelDay.month == now.month) {
      await tx(fuelDay, 'expense', 25000, cat: 'fuel', label: 'بنزين', member: dad, wallet: dadCash, source: 'manual');
    }
    if (breadDay.month == now.month) {
      await tx(breadDay, 'expense', 1000, cat: 'bread_veg', label: 'خبز', member: dad, wallet: dadCash, source: 'manual');
    }
  }

  // Cash counted at the start of the week.
  await tx(ws.add(const Duration(hours: 1)), 'adjust', 98500, wallet: dadCash, member: dad, source: 'pocket', label: 'عدّ الجيب');
  await tx(ws.add(const Duration(hours: 1)), 'adjust', 45000, wallet: mumCash, member: mum, source: 'pocket', label: 'عدّ الجيب');

  // Bank messages waiting for a tap.
  await repo.addSmsMessages([
    (key: 'demo-1', sender: 'Qi Card', body: 'تم خصم 12,500 د.ع من بطاقتك لدى SHIFA PHARMACY', at: now.subtract(const Duration(minutes: 29))),
    (key: 'demo-2', sender: 'Qi Card', body: 'Purchase of IQD 18,000 at AL REEM REST', at: now.subtract(const Duration(hours: 12))),
    (key: 'demo-3', sender: 'Qi Card', body: 'Purchase of IQD 25,000 at KARRADA FUEL STATION', at: now.subtract(const Duration(hours: 15))),
  ]);

  await repo.addDebt(person: 'أبو حسن', theyOweUs: true, amount: 50000, note: 'سلفة من آب');
  await repo.addDebt(person: 'خالد', theyOweUs: false, amount: 100000, note: 'نرجعها بالراتب الجاي');
  await repo.addRosca(name: 'جمعية بيت أبو علي', organizer: 'أم علي', members: 10, contribution: 100000, startYear: now.year, startMonth: now.month - 3 < 1 ? now.month + 9 : now.month - 3, myTurn: 7);
  final r = (await (db.select(db.roscas)).get()).first;
  for (var i = 0; i < 4; i++) {
    await repo.payRoscaRound(r.id);
  }
  await (db.update(db.roscas)..where((x) => x.id.equals(r.id))).write(const RoscasCompanion(warning: Value('أبو مهدي قبض دوره وتأخر بدفعة الشهر الماضي')));

  await repo.kidAllowance(kid, 5000);
  await repo.kidDeposit(kid, 'save', 10000);
  await repo.kidDeposit(kid, 'save', 2000);
  await repo.kidDeposit(kid, 'give', 1000);
  await repo.kidDeposit(kid, 'spend', 500);
}

int _wobbleSum(int n) {
  var sum = 0;
  for (var i = 0; i < n; i++) {
    sum += ((i % 3) - 1) * 1250;
  }
  return sum;
}
