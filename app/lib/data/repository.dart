/// All reads and writes go through here. Writes mark rows dirty for sync and
/// never hard-delete; undo is a soft delete.
library;

import 'dart:async';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../core/money.dart';
import '../domain/budget.dart';
import '../domain/categories.dart';
import '../domain/sms_parser.dart';
import 'database.dart';
import 'snapshot.dart';

typedef Clock = DateTime Function();

class ExpenseDraft {
  const ExpenseDraft({
    required this.label,
    required this.categoryKey,
    required this.amountMinor,
    this.currency = Currency.iqd,
    this.walletId,
    this.memberId,
    this.source = 'manual',
    this.occurredAt,
    this.note = '',
  });

  final String label;
  final String categoryKey;
  final int amountMinor;
  final Currency currency;
  final String? walletId;
  final String? memberId;
  final String source;
  final DateTime? occurredAt;
  final String note;
}

class BillSetup {
  const BillSetup(this.name, this.icon, this.amount, this.categoryKey, {this.day = 1, this.amps, this.pricePerAmp});
  final String name;
  final String icon;
  final int amount;
  final String categoryKey;
  final int day;
  final int? amps;
  final int? pricePerAmp;
}

class HouseholdSetup {
  const HouseholdSetup({
    required this.familyName,
    required this.meName,
    this.partnerName,
    this.kidNames = const [],
    required this.salary,
    required this.payDay,
    required this.savePercent,
    required this.bills,
    this.envelopesMonthly = 0,
    this.usdRate = 1520,
  });

  final String familyName;
  final String meName;
  final String? partnerName;
  final List<String> kidNames;
  final int salary;
  final int payDay;
  final int savePercent;
  final List<BillSetup> bills;

  /// Monthly amount spread over the default envelopes (Eid, school, summer, health).
  final int envelopesMonthly;
  final int usdRate;
}

class Repository {
  Repository(this.db, {Clock? clock}) : now = clock ?? DateTime.now;

  final AppDatabase db;
  final Clock now;
  final _uuid = const Uuid();

  String newId() => _uuid.v7();

  // ---------------------------------------------------------------- settings

  Future<String?> getValue(String key) async =>
      (await (db.select(db.keyValues)..where((t) => t.key.equals(key))).getSingleOrNull())?.value;

  Future<void> setValue(String key, String value) =>
      db.into(db.keyValues).insertOnConflictUpdate(KeyValuesCompanion.insert(key: key, value: value));

  Stream<String?> watchValue(String key) =>
      (db.select(db.keyValues)..where((t) => t.key.equals(key))).watchSingleOrNull().map((r) => r?.value);

  Future<String?> householdId() => getValue('household_id');

  Future<bool> hasHousehold() async => (await householdId()) != null;

  // ------------------------------------------------------------- onboarding

  Future<void> createHousehold(HouseholdSetup s, {bool demo = false}) async {
    final t = now();
    final hid = newId();
    String id() => newId();

    await db.transaction(() async {
      await db.into(db.households).insert(HouseholdsCompanion.insert(
            id: hid, householdId: hid, createdAt: t, updatedAt: t, name: s.familyName,
            usdRate: Value(s.usdRate), inviteCode: Value(_inviteCode()),
          ));

      final meId = id();
      await db.into(db.members).insert(MembersCompanion.insert(
            id: meId, householdId: hid, createdAt: t, updatedAt: t,
            displayName: s.meName, role: 'owner', letter: _letter(s.meName), colorIndex: const Value(0),
            freeAllowance: const Value(35000), sortOrder: const Value(0),
          ));
      String? partnerId;
      if (s.partnerName != null) {
        partnerId = id();
        await db.into(db.members).insert(MembersCompanion.insert(
              id: partnerId, householdId: hid, createdAt: t, updatedAt: t,
              displayName: s.partnerName!, role: 'member', letter: _letter(s.partnerName!), colorIndex: const Value(1),
              freeAllowance: const Value(42000), sortOrder: const Value(1),
            ));
      }
      final kidIds = <String>[];
      for (var i = 0; i < s.kidNames.length; i++) {
        final kid = id();
        kidIds.add(kid);
        await db.into(db.members).insert(MembersCompanion.insert(
              id: kid, householdId: hid, createdAt: t, updatedAt: t,
              displayName: s.kidNames[i], role: 'child', letter: _letter(s.kidNames[i]), colorIndex: Value(2 + i),
              sortOrder: Value(2 + i),
            ));
        await db.into(db.kidProfiles).insert(KidProfilesCompanion.insert(
              id: id(), householdId: hid, createdAt: t, updatedAt: t, memberId: kid,
              goalName: const Value('الدراجة'), goalMinor: const Value(60000),
            ));
      }

      Future<void> wallet(String name, String kind, {String currency = 'IQD', String? owner}) =>
          db.into(db.wallets).insert(WalletsCompanion.insert(
                id: id(), householdId: hid, createdAt: t, updatedAt: t, name: name, kind: kind,
                currency: Value(currency), ownerMemberId: Value(owner),
              ));
      await wallet('كي كارد', 'qi_card');
      await wallet('كاش ${s.meName}', 'cash', owner: meId);
      if (partnerId != null) await wallet('كاش ${s.partnerName}', 'cash', owner: partnerId);
      await wallet('دولار البيت', 'cash', currency: 'USD');

      var order = 0;
      for (final c in kDefaultCategories) {
        await db.into(db.categories).insert(CategoriesCompanion.insert(
              id: id(), householdId: hid, createdAt: t, updatedAt: t, key: c.key, name: c.name,
              kind: c.kind.name, groupName: c.group.name, isFixed: Value(c.fixed),
              keywords: Value(c.keywords.join(',')), sortOrder: Value(order++),
            ));
      }

      Future<void> envelope(String name, String kind, {int target = 0, int monthly = 0, bool locked = false, int note = 10000, String? member, int sort = 0}) =>
          db.into(db.envelopes).insert(EnvelopesCompanion.insert(
                id: id(), householdId: hid, createdAt: t, updatedAt: t, name: name, kind: kind,
                targetMinor: Value(target), monthlyMinor: Value(monthly), locked: Value(locked),
                noteDenomination: Value(note), memberId: Value(member), sortOrder: Value(sort),
              ));
      await envelope('خزنة العائلة', 'vault', target: 1000000, locked: true, note: 25000);
      final per = s.envelopesMonthly ~/ 4;
      await envelope('العيد', 'sinking', target: 200000, monthly: per, note: 5000, sort: 2);
      await envelope('المدارس', 'sinking', target: 250000, monthly: per, note: 10000, sort: 3);
      await envelope('مولدة الصيف', 'sinking', target: 420000, monthly: per, note: 1000, sort: 4);
      await envelope('العلاج', 'sinking', target: 150000, monthly: s.envelopesMonthly - per * 3, note: 500, sort: 5);
      for (var i = 0; i < kidIds.length; i++) {
        await envelope('مستقبل ${s.kidNames[i]}', 'goal', target: 1000000, note: 25000, member: kidIds[i], sort: 1);
      }

      await db.into(db.plans).insert(PlansCompanion.insert(
            id: id(), householdId: hid, createdAt: t, updatedAt: t, salary: s.salary,
            savePercent: Value(s.savePercent), payDay: Value(s.payDay),
          ));

      for (final b in s.bills) {
        await db.into(db.bills).insert(BillsCompanion.insert(
              id: id(), householdId: hid, createdAt: t, updatedAt: t, name: b.name, icon: b.icon,
              amountMinor: b.amount, dayOfMonth: b.day, categoryKey: b.categoryKey,
              amps: Value(b.amps), pricePerAmp: Value(b.pricePerAmp),
            ));
      }

      await setValue('household_id', hid);
      await setValue('me_member_id', meId);
      if (demo) await setValue('demo', '1');
    });
  }

  String _letter(String name) => name.trim().isEmpty ? '؟' : name.trim().substring(0, 1);

  String _inviteCode() {
    const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final r = newId().replaceAll('-', '');
    final b = StringBuffer('WF-');
    for (var i = 0; i < 4; i++) {
      b.write(alphabet[int.parse(r.substring(r.length - 2 * (i + 1), r.length - 2 * i), radix: 16) % alphabet.length]);
    }
    return b.toString();
  }

  // ----------------------------------------------------------------- reads

  /// Rebuilds the snapshot whenever any table changes.
  Stream<Snapshot?> watchSnapshot() {
    late StreamController<Snapshot?> controller;
    StreamSubscription<Set<TableUpdate>>? sub;
    Timer? debounce;
    var loading = false;
    var again = false;

    Future<void> emit() async {
      if (loading) {
        again = true;
        return;
      }
      loading = true;
      try {
        controller.add(await loadSnapshot());
      } catch (e, st) {
        controller.addError(e, st);
      } finally {
        loading = false;
        if (again) {
          again = false;
          unawaited(emit());
        }
      }
    }

    controller = StreamController<Snapshot?>(
      onListen: () {
        emit();
        sub = db.tableUpdates().listen((_) {
          debounce?.cancel();
          debounce = Timer(const Duration(milliseconds: 16), emit);
        });
      },
      onCancel: () async {
        debounce?.cancel();
        await sub?.cancel();
      },
    );
    return controller.stream;
  }

  Future<Snapshot?> loadSnapshot() async {
    final hid = await householdId();
    if (hid == null) return null;
    final t = now();
    final household = await (db.select(db.households)..where((h) => h.id.equals(hid))).getSingle();
    final meId = await getValue('me_member_id');

    final members = await (db.select(db.members)
          ..where((m) => m.householdId.equals(hid) & m.deletedAt.isNull())
          ..orderBy([(m) => OrderingTerm(expression: m.sortOrder)]))
        .get();
    final me = members.firstWhere((m) => m.id == meId, orElse: () => members.first);
    final categories = await (db.select(db.categories)
          ..where((c) => c.householdId.equals(hid) & c.deletedAt.isNull())
          ..orderBy([(c) => OrderingTerm(expression: c.sortOrder)]))
        .get();
    final plan = await (db.select(db.plans)..where((p) => p.householdId.equals(hid) & p.deletedAt.isNull())).getSingle();
    final bills = await (db.select(db.bills)
          ..where((b) => b.householdId.equals(hid) & b.deletedAt.isNull())
          ..orderBy([(b) => OrderingTerm(expression: b.dayOfMonth)]))
        .get();
    final debts = await (db.select(db.debts)..where((d) => d.householdId.equals(hid) & d.deletedAt.isNull())).get();
    final roscas = await (db.select(db.roscas)..where((r) => r.householdId.equals(hid) & r.deletedAt.isNull())).get();

    // Envelope balances.
    final envRows = await (db.select(db.envelopes)
          ..where((e) => e.householdId.equals(hid) & e.deletedAt.isNull())
          ..orderBy([(e) => OrderingTerm(expression: e.sortOrder)]))
        .get();
    final envBal = <String, int>{};
    final envTx = await (db.select(db.txns)
          ..where((x) => x.householdId.equals(hid) & x.deletedAt.isNull() & x.envelopeId.isNotNull() & x.kind.isIn(['envelope_in', 'envelope_out'])))
        .get();
    for (final x in envTx) {
      envBal[x.envelopeId!] = (envBal[x.envelopeId!] ?? 0) + (x.kind == 'envelope_in' ? x.amountBase : -x.amountBase);
    }
    final envelopes = [for (final e in envRows) EnvelopeView(e, envBal[e.id] ?? 0)];

    // Wallets.
    final walletRows = await (db.select(db.wallets)..where((w) => w.householdId.equals(hid) & w.deletedAt.isNull())).get();
    final wallets = <WalletView>[];
    for (final w in walletRows) {
      final b = await walletBalance(w.id);
      wallets.add(WalletView(w, b.balance, counted: b.counted));
    }

    // Kids.
    final kids = <KidView>[];
    for (final m in members.where((m) => m.role == 'child')) {
      final profile = await (db.select(db.kidProfiles)..where((k) => k.memberId.equals(m.id) & k.deletedAt.isNull())).getSingleOrNull();
      if (profile == null) continue;
      final entries = await (db.select(db.kidEntries)..where((k) => k.memberId.equals(m.id) & k.deletedAt.isNull())).get();
      int jar(String j) => entries.where((e) => e.jar == j).fold(0, (a, e) => a + e.amountMinor);
      final matched = entries.where((e) => e.kind == 'match').fold(0, (a, e) => a + e.amountMinor);
      kids.add(KidView(member: m, profile: profile, spend: jar('spend'), save: jar('save'), give: jar('give'), matched: matched));
    }

    // Week.
    final snapshotPlan = MonthlyPlan(
      salary: plan.salary,
      savePercent: plan.savePercent,
      envelopesMonthly: envelopes.where((e) => e.envelope.kind != 'vault').fold(0, (a, e) => a + e.envelope.monthlyMinor),
      fixedBills: bills.where((b) => b.active).fold(0, (a, b) => a + b.amountMinor),
      payDay: plan.payDay,
    );
    final allowance = weeklyAllowance(snapshotPlan, t);
    final ws = weekStartOf(t);
    final carried = await carriedInto(ws);
    final weekTx = await (db.select(db.txns)
          ..where((x) =>
              x.householdId.equals(hid) & x.deletedAt.isNull() & x.countsInWeek.equals(true) &
              x.occurredAt.isBiggerOrEqualValue(ws) & x.occurredAt.isSmallerThanValue(ws.add(const Duration(days: 7)))))
        .get();
    final week = computeWeek(
      now: t,
      allowance: allowance,
      carried: carried,
      variableSpending: weekTx.map((x) => DatedAmount(x.occurredAt, x.amountBase)),
    );
    final byMember = <String, int>{};
    for (final x in weekTx) {
      if (x.memberId != null) byMember[x.memberId!] = (byMember[x.memberId!] ?? 0) + x.amountBase;
    }

    final recent = await (db.select(db.txns)
          ..where((x) => x.householdId.equals(hid) & x.deletedAt.isNull() & x.kind.isIn(['expense', 'income']))
          ..orderBy([(x) => OrderingTerm(expression: x.occurredAt, mode: OrderingMode.desc)])
          ..limit(30))
        .get();

    final inbox = await (db.select(db.inboxItems)
          ..where((i) => i.status.equals('pending'))
          ..orderBy([(i) => OrderingTerm(expression: i.receivedAt, mode: OrderingMode.desc)]))
        .get();

    return Snapshot(
      now: t,
      household: household,
      me: me,
      members: members,
      wallets: wallets,
      categories: categories,
      envelopes: envelopes,
      plan: plan,
      bills: bills,
      debts: debts,
      roscas: roscas,
      kids: kids,
      week: week,
      weeklyAllowance: allowance,
      recent: recent,
      inbox: inbox,
      quickPicks: await quickPicks(hid),
      spentByMember: byMember,
      isDemo: (await getValue('demo')) == '1',
    );
  }

  /// What a wallet should hold: last count, plus everything recorded after it.
  Future<({int balance, bool counted})> walletBalance(String walletId) async {
    final rows = await (db.select(db.txns)
          ..where((x) => x.deletedAt.isNull() & (x.walletId.equals(walletId) | x.toWalletId.equals(walletId)))
          ..orderBy([(x) => OrderingTerm(expression: x.occurredAt), (x) => OrderingTerm(expression: x.createdAt)]))
        .get();
    var bal = 0;
    var counted = false;
    for (final x in rows) {
      final v = x.amountMinor;
      switch (x.kind) {
        case 'adjust':
          bal = v;
          counted = true;
        case 'expense':
          if (x.walletId == walletId) bal -= v;
        case 'income':
          if (x.walletId == walletId) bal += v;
        case 'transfer':
          if (x.walletId == walletId) bal -= v;
          if (x.toWalletId == walletId) bal += _convertForWallet(x);
        case 'envelope_in':
          if (x.walletId == walletId) bal -= v;
        case 'envelope_out':
          if (x.walletId == walletId) bal += v;
      }
    }
    return (balance: bal, counted: counted);
  }

  int _convertForWallet(Txn x) => x.amountMinor;

  Future<int> carriedInto(DateTime weekStart) async {
    final prev = weekStart.subtract(const Duration(days: 7));
    final c = await (db.select(db.weekCloses)..where((w) => w.weekStart.equals(prev) & w.deletedAt.isNull())).getSingleOrNull();
    return c?.carried ?? 0;
  }

  /// Things bought the same way at least twice in the last two months.
  Future<List<QuickPick>> quickPicks(String hid) async {
    final since = now().subtract(const Duration(days: 60));
    final rows = await (db.select(db.txns)
          ..where((x) =>
              x.householdId.equals(hid) & x.deletedAt.isNull() & x.kind.equals('expense') &
              x.source.isNotIn(['recurring', 'pocket']) & x.occurredAt.isBiggerOrEqualValue(since) & x.currency.equals('IQD')))
        .get();
    final groups = <String, List<Txn>>{};
    for (final x in rows) {
      groups.putIfAbsent('${x.label}|${x.amountMinor}', () => []).add(x);
    }
    final picks = groups.values.where((g) => g.length >= 2).map((g) {
      g.sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
      final x = g.first;
      return QuickPick(label: x.label, categoryKey: x.categoryKey ?? 'other', amount: x.amountMinor, walletId: x.walletId, times: g.length);
    }).toList();
    // Habits from the last two weeks first, then by how often.
    final recent = now().subtract(const Duration(days: 14));
    int score(QuickPick p) => p.times + (groups['${p.label}|${p.amount}']!.any((x) => x.occurredAt.isAfter(recent)) ? 100 : 0);
    picks.sort((a, b) => score(b).compareTo(score(a)));
    return picks.take(5).toList();
  }

  Future<MonthReport> monthReport(int year, int month) async {
    final hid = (await householdId())!;
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);
    final rows = await (db.select(db.txns)
          ..where((x) =>
              x.householdId.equals(hid) & x.deletedAt.isNull() &
              x.occurredAt.isBiggerOrEqualValue(start) & x.occurredAt.isSmallerThanValue(end)))
        .get();
    final cats = await (db.select(db.categories)..where((c) => c.householdId.equals(hid))).get();
    final vaultIds = (await (db.select(db.envelopes)..where((e) => e.householdId.equals(hid) & e.kind.equals('vault'))).get()).map((e) => e.id).toSet();
    var income = 0;
    var fromVault = 0;
    final amounts = <String, int>{};
    final counts = <String, int>{};
    for (final x in rows) {
      if (x.kind == 'income') income += x.amountBase;
      if (x.kind == 'envelope_out' && vaultIds.contains(x.envelopeId)) fromVault += x.amountBase;
      if (x.kind == 'expense') {
        final k = x.categoryKey ?? 'other';
        amounts[k] = (amounts[k] ?? 0) + x.amountBase;
        counts[k] = (counts[k] ?? 0) + 1;
      }
    }
    String name(String k) => cats.where((c) => c.key == k).map((c) => c.name).firstOrNull ?? categoryByKey(k).name;
    bool want(String k) => (cats.where((c) => c.key == k).map((c) => c.groupName).firstOrNull ?? categoryByKey(k).group.name) == 'wants';
    final list = amounts.entries
        .map((e) => CategorySpend(key: e.key, name: name(e.key), amount: e.value, count: counts[e.key] ?? 0, isWant: want(e.key)))
        .toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));
    final wants = list.where((c) => c.isWant && c.key != 'other' && c.key != 'small' && c.count >= 6).toList()
      ..sort((a, b) => b.count.compareTo(a.count));
    final leak = wants.firstOrNull;
    var saving = 0;
    if (leak != null) {
      final weeks = (end.difference(start).inDays / 7).round();
      final avg = leak.amount ~/ leak.count;
      saving = roundTo(avg * (leak.count - weeks), 1000);
    }
    return MonthReport(
      year: year,
      month: month,
      income: income,
      spent: list.fold(0, (a, c) => a + c.amount),
      fromVault: fromVault,
      byCategory: list,
      leak: leak,
      leakSaving: saving < 0 ? 0 : saving,
    );
  }

  // ---------------------------------------------------------------- writes

  Future<Household> _household() async {
    final hid = (await householdId())!;
    return (db.select(db.households)..where((h) => h.id.equals(hid))).getSingle();
  }

  Future<bool> _isFixed(String hid, String categoryKey) async {
    final c = await (db.select(db.categories)..where((x) => x.householdId.equals(hid) & x.key.equals(categoryKey))).getSingleOrNull();
    return c?.isFixed ?? false;
  }

  /// Records expenses; returns their ids so the caller can offer undo.
  Future<List<String>> addExpenses(List<ExpenseDraft> drafts) async {
    final h = await _household();
    final t = now();
    final ids = <String>[];
    await db.transaction(() async {
      for (final d in drafts) {
        final rate = d.currency == Currency.usd ? h.usdRate : 1;
        final id = newId();
        final fixed = await _isFixed(h.id, d.categoryKey);
        await db.into(db.txns).insert(TxnsCompanion.insert(
              id: id, householdId: h.id, createdAt: t, updatedAt: t, kind: 'expense',
              amountMinor: d.amountMinor, currency: Value(d.currency.code), fxRate: Value(rate),
              amountBase: toBaseIqd(d.amountMinor, d.currency, h.usdRate),
              walletId: Value(d.walletId), categoryKey: Value(d.categoryKey), memberId: Value(d.memberId),
              occurredAt: d.occurredAt ?? t, label: Value(d.label), note: Value(d.note), source: Value(d.source),
              countsInWeek: Value(!fixed && d.source != 'recurring'),
            ));
        ids.add(id);
      }
    });
    return ids;
  }

  Future<void> softDelete(List<String> txnIds) async {
    final t = now();
    await (db.update(db.txns)..where((x) => x.id.isIn(txnIds)))
        .write(TxnsCompanion(deletedAt: Value(t), updatedAt: Value(t), dirty: const Value(true)));
  }

  Future<void> restore(List<String> txnIds) async {
    final t = now();
    await (db.update(db.txns)..where((x) => x.id.isIn(txnIds)))
        .write(TxnsCompanion(deletedAt: const Value(null), updatedAt: Value(t), dirty: const Value(true)));
  }

  Future<String> _insertTxn({
    required String kind,
    required int amount,
    String? walletId,
    String? toWalletId,
    String? envelopeId,
    String? categoryKey,
    String? memberId,
    String label = '',
    String source = 'manual',
    Currency currency = Currency.iqd,
  }) async {
    final h = await _household();
    final t = now();
    final id = newId();
    await db.into(db.txns).insert(TxnsCompanion.insert(
          id: id, householdId: h.id, createdAt: t, updatedAt: t, kind: kind, amountMinor: amount,
          currency: Value(currency.code), fxRate: Value(currency == Currency.usd ? h.usdRate : 1),
          amountBase: toBaseIqd(amount, currency, h.usdRate), walletId: Value(walletId), toWalletId: Value(toWalletId),
          envelopeId: Value(envelopeId), categoryKey: Value(categoryKey), memberId: Value(memberId),
          occurredAt: t, label: Value(label), source: Value(source),
        ));
    return id;
  }

  Future<String> addIncome({required int amount, required String walletId, String categoryKey = 'salary', String label = 'راتب', String? memberId}) =>
      _insertTxn(kind: 'income', amount: amount, walletId: walletId, categoryKey: categoryKey, label: label, memberId: memberId, source: 'payday');

  Future<String> moveToEnvelope(String envelopeId, int amount, {String? fromWalletId, String source = 'manual'}) =>
      _insertTxn(kind: 'envelope_in', amount: amount, envelopeId: envelopeId, walletId: fromWalletId, source: source, label: 'للظرف');

  Future<String> takeFromEnvelope(String envelopeId, int amount, {String? toWalletId}) =>
      _insertTxn(kind: 'envelope_out', amount: amount, envelopeId: envelopeId, walletId: toWalletId, label: 'من الظرف');

  /// Adds categories introduced after this household was created.
  Future<void> ensureDefaultCategories() async {
    final hid = await householdId();
    if (hid == null) return;
    final have = {for (final c in await (db.select(db.categories)..where((c) => c.householdId.equals(hid))).get()) c.key};
    final t = now();
    var order = have.length;
    for (final c in kDefaultCategories.where((c) => !have.contains(c.key))) {
      await db.into(db.categories).insert(CategoriesCompanion.insert(
            id: newId(), householdId: hid, createdAt: t, updatedAt: t, key: c.key, name: c.name,
            kind: c.kind.name, groupName: c.group.name, isFixed: Value(c.fixed),
            keywords: Value(c.keywords.join(',')), sortOrder: Value(order++),
          ));
    }
  }

  // ----------------------------------------------------------------- giving

  /// The charity envelope: filled from each salary, emptied as it is given.
  Future<String> addSadaqaEnvelope(int monthly) async {
    final hid = (await householdId())!;
    final t = now();
    final count = await (db.select(db.envelopes)..where((e) => e.householdId.equals(hid))).get();
    final id = newId();
    await db.into(db.envelopes).insert(EnvelopesCompanion.insert(
          id: id, householdId: hid, createdAt: t, updatedAt: t, name: 'الصدقة', kind: 'sadaqa',
          monthlyMinor: Value(monthly), noteDenomination: const Value(1000), sortOrder: Value(count.length + 1),
        ));
    return id;
  }

  /// Records charity given out of the charity envelope.
  Future<String> giveSadaqa(String envelopeId, int amount, {String label = 'صدقة'}) async {
    final me = await getValue('me_member_id');
    return _insertTxn(kind: 'envelope_out', amount: amount, envelopeId: envelopeId, label: label, memberId: me, source: 'sadaqa', categoryKey: 'sadaqa');
  }

  /// Charity given since [from], from the envelope and logged as spending.
  Future<int> sadaqaGivenSince(DateTime from) async {
    final hid = await householdId();
    if (hid == null) return 0;
    final rows = await (db.select(db.txns)
          ..where((x) =>
              x.householdId.equals(hid) & x.deletedAt.isNull() & x.categoryKey.equals('sadaqa') & x.occurredAt.isBiggerOrEqualValue(from) & x.kind.isIn(['envelope_out', 'expense'])))
        .get();
    return rows.fold<int>(0, (a, x) => a + x.amountBase);
  }

  /// Pay yourself first: salary in, vault and envelopes funded before anything else.
  Future<void> runPayday({required int salary, required int savePercent, required String walletId}) async {
    final snap = (await loadSnapshot())!;
    await db.transaction(() async {
      await (db.update(db.plans)..where((p) => p.id.equals(snap.plan.id))).write(PlansCompanion(
            salary: Value(salary), savePercent: Value(savePercent), updatedAt: Value(now()), dirty: const Value(true)));
      await addIncome(amount: salary, walletId: walletId, memberId: snap.me.id);
      final vault = snap.vault;
      final save = salary * savePercent ~/ 100;
      if (vault != null && save > 0) await moveToEnvelope(vault.envelope.id, save, fromWalletId: walletId, source: 'payday');
      for (final e in snap.envelopes) {
        if (e.envelope.kind == 'vault' || e.envelope.monthlyMinor <= 0) continue;
        await moveToEnvelope(e.envelope.id, e.envelope.monthlyMinor, fromWalletId: walletId, source: 'payday');
      }
    });
  }

  /// Friday: what is left goes to the vault, the rest is carried into next week.
  Future<void> closeWeek({required DateTime weekStart, required int leftover, required int toVault, String? envelopeId}) async {
    final snap = (await loadSnapshot())!;
    final t = now();
    await db.transaction(() async {
      final target = envelopeId ?? snap.vault?.envelope.id;
      if (toVault > 0 && target != null) {
        await moveToEnvelope(target, toVault, source: 'friday');
      }
      final existing = await (db.select(db.weekCloses)..where((w) => w.weekStart.equals(weekStart) & w.householdId.equals(snap.household.id))).getSingleOrNull();
      final carried = leftover - toVault < 0 ? 0 : leftover - toVault;
      if (existing == null) {
        await db.into(db.weekCloses).insert(WeekClosesCompanion.insert(
              id: newId(), householdId: snap.household.id, createdAt: t, updatedAt: t, weekStart: weekStart,
              leftover: leftover, toVault: toVault, carried: carried,
            ));
      } else {
        await (db.update(db.weekCloses)..where((w) => w.id.equals(existing.id))).write(WeekClosesCompanion(
              leftover: Value(leftover), toVault: Value(existing.toVault + toVault), carried: Value(carried),
              updatedAt: Value(t), dirty: const Value(true)));
      }
    });
  }

  /// Counting cash: the first count sets the starting point; later counts
  /// record the gap as small spending, so cash never needs item-by-item entry.
  Future<({int gap, String? txnId})> countWallet({required String walletId, required int counted, String? memberId, bool logGap = true}) async {
    final b = await walletBalance(walletId);
    final gap = b.balance - counted;
    String? txnId;
    if (b.counted && gap > 0 && logGap) {
      final ids = await addExpenses([
        ExpenseDraft(label: 'أشياء صغيرة', categoryKey: 'small', amountMinor: gap, walletId: walletId, memberId: memberId, source: 'pocket', note: 'من عدّ الجيب'),
      ]);
      txnId = ids.first;
    }
    await _insertTxn(kind: 'adjust', amount: counted, walletId: walletId, memberId: memberId, source: 'pocket', label: 'عدّ الجيب');
    return (gap: b.counted ? gap : 0, txnId: txnId);
  }

  /// ATM withdrawal or cash taken from the card: a move, not spending.
  Future<String> withdrawCash({required String fromWalletId, required String toWalletId, required int amount, String? memberId}) =>
      _insertTxn(kind: 'transfer', amount: amount, walletId: fromWalletId, toWalletId: toWalletId, memberId: memberId, label: 'سحب كاش');

  // ------------------------------------------------------------ bank inbox

  /// Adds parsed bank messages; duplicates (same message key) are ignored.
  Future<int> addSmsMessages(Iterable<({String key, String sender, String body, DateTime at})> messages) async {
    var added = 0;
    for (final m in messages) {
      final parsed = parseBankSms(m.body);
      if (parsed == null) continue;
      final seen = await (db.select(db.inboxItems)..where((i) => i.smsKey.equals(m.key))).getSingleOrNull();
      if (seen != null) continue;
      await db.into(db.inboxItems).insert(
            InboxItemsCompanion.insert(
              id: newId(), smsKey: m.key, sender: m.sender, body: m.body, receivedAt: m.at,
              kind: parsed.kind.name, amountMinor: parsed.amountMinor, currency: parsed.currency.code,
              merchant: Value(parsed.merchant),
              suggestedCategory: parsed.kind == SmsKind.purchase ? guessCategoryForMerchant(parsed.merchant) : (parsed.kind == SmsKind.credit ? 'other_income' : 'transfer'),
            ),
            mode: InsertMode.insertOrIgnore,
          );
      added++;
    }
    return added;
  }

  Future<String?> acceptInbox(String inboxId, {required String categoryKey, String? memberId, String source = 'sms'}) async {
    final item = await (db.select(db.inboxItems)..where((i) => i.id.equals(inboxId))).getSingle();
    final snap = (await loadSnapshot())!;
    final card = snap.walletOfKind('qi_card');
    final currency = Currency.fromCode(item.currency);
    String? txnId;
    switch (item.kind) {
      case 'purchase':
        final ids = await addExpenses([
          ExpenseDraft(
            label: item.merchant ?? snap.categoryName(categoryKey),
            categoryKey: categoryKey,
            amountMinor: item.amountMinor,
            currency: currency,
            walletId: card?.id,
            memberId: memberId,
            source: source,
            occurredAt: item.receivedAt,
          ),
        ]);
        txnId = ids.first;
      case 'withdrawal':
        final cash = snap.walletOfKind('cash', ownerId: memberId ?? snap.me.id);
        if (card != null && cash != null) {
          txnId = await withdrawCash(fromWalletId: card.id, toWalletId: cash.id, amount: item.amountMinor, memberId: memberId);
        }
      case 'credit':
        if (card != null) {
          txnId = await _insertTxn(kind: 'income', amount: item.amountMinor, walletId: card.id, categoryKey: categoryKey, memberId: memberId, source: source, label: 'إيداع', currency: currency);
        }
    }
    await (db.update(db.inboxItems)..where((i) => i.id.equals(inboxId))).write(InboxItemsCompanion(status: const Value('accepted'), txnId: Value(txnId)));
    return txnId;
  }

  Future<void> dismissInbox(String inboxId) =>
      (db.update(db.inboxItems)..where((i) => i.id.equals(inboxId))).write(const InboxItemsCompanion(status: Value('dismissed')));

  Future<void> reopenInbox(String inboxId) =>
      (db.update(db.inboxItems)..where((i) => i.id.equals(inboxId))).write(const InboxItemsCompanion(status: Value('pending'), txnId: Value(null)));

  Future<void> addEnvelope({required String name, required int monthly, int target = 0, int note = 1000}) async {
    final hid = (await householdId())!;
    final t = now();
    final count = await (db.select(db.envelopes)..where((e) => e.householdId.equals(hid))).get();
    await db.into(db.envelopes).insert(EnvelopesCompanion.insert(
          id: newId(), householdId: hid, createdAt: t, updatedAt: t, name: name, kind: 'sinking',
          targetMinor: Value(target == 0 ? monthly * 12 : target), monthlyMinor: Value(monthly),
          noteDenomination: Value(note), sortOrder: Value(count.length + 1),
        ));
  }

  Future<void> setEnvelopeMonthly(String envelopeId, int monthly) => (db.update(db.envelopes)..where((e) => e.id.equals(envelopeId)))
      .write(EnvelopesCompanion(monthlyMinor: Value(monthly), updatedAt: Value(now()), dirty: const Value(true)));

  // ----------------------------------------------------------------- bills

  /// Posts this month's fixed bills on their day. Safe to call repeatedly.
  Future<int> postDueBills() async {
    final hid = await householdId();
    if (hid == null) return 0;
    final t = now();
    final month = '${t.year}-${t.month.toString().padLeft(2, '0')}';
    final due = await (db.select(db.bills)
          ..where((b) => b.householdId.equals(hid) & b.deletedAt.isNull() & b.active.equals(true) & b.dayOfMonth.isSmallerOrEqualValue(t.day)))
        .get();
    var posted = 0;
    for (final b in due.where((b) => b.lastPosted != month)) {
      await addExpenses([ExpenseDraft(label: b.name, categoryKey: b.categoryKey, amountMinor: b.amountMinor, source: 'recurring', occurredAt: DateTime(t.year, t.month, b.dayOfMonth))]);
      await (db.update(db.bills)..where((x) => x.id.equals(b.id)))
          .write(BillsCompanion(lastPosted: Value(month), updatedAt: Value(t), dirty: const Value(true)));
      posted++;
    }
    return posted;
  }

  Future<void> updateGeneratorBill(String billId, {required int amps, required int pricePerAmp}) =>
      (db.update(db.bills)..where((b) => b.id.equals(billId))).write(BillsCompanion(
            amps: Value(amps), pricePerAmp: Value(pricePerAmp), amountMinor: Value(amps * pricePerAmp),
            updatedAt: Value(now()), dirty: const Value(true)));

  Future<void> updateBillAmount(String billId, int amount) => (db.update(db.bills)..where((b) => b.id.equals(billId)))
      .write(BillsCompanion(amountMinor: Value(amount), updatedAt: Value(now()), dirty: const Value(true)));

  // ----------------------------------------------------------------- debts

  Future<void> addDebt({required String person, required bool theyOweUs, required int amount, String note = ''}) async {
    final hid = (await householdId())!;
    final t = now();
    await db.into(db.debts).insert(DebtsCompanion.insert(
          id: newId(), householdId: hid, createdAt: t, updatedAt: t, personName: person,
          direction: theyOweUs ? 'in' : 'out', amountMinor: amount, note: Value(note),
        ));
  }

  Future<void> payDebt(String debtId, int amount) async {
    final d = await (db.select(db.debts)..where((x) => x.id.equals(debtId))).getSingle();
    final paid = (d.paidMinor + amount).clamp(0, d.amountMinor);
    await (db.update(db.debts)..where((x) => x.id.equals(debtId)))
        .write(DebtsCompanion(paidMinor: Value(paid), updatedAt: Value(now()), dirty: const Value(true)));
  }

  Future<void> forgiveDebt(String debtId) => (db.update(db.debts)..where((x) => x.id.equals(debtId)))
      .write(DebtsCompanion(forgiven: const Value(true), updatedAt: Value(now()), dirty: const Value(true)));

  // ----------------------------------------------------------------- rosca

  Future<void> addRosca({required String name, String organizer = '', required int members, required int contribution, required int startYear, required int startMonth, required int myTurn}) async {
    final hid = (await householdId())!;
    final t = now();
    await db.into(db.roscas).insert(RoscasCompanion.insert(
          id: newId(), householdId: hid, createdAt: t, updatedAt: t, name: name, organizer: Value(organizer),
          membersCount: members, contribution: contribution, startYear: startYear, startMonth: startMonth, myTurn: myTurn,
        ));
  }

  Future<void> payRoscaRound(String roscaId) async {
    final r = await (db.select(db.roscas)..where((x) => x.id.equals(roscaId))).getSingle();
    if (r.paidRounds >= r.membersCount) return;
    await (db.update(db.roscas)..where((x) => x.id.equals(roscaId)))
        .write(RoscasCompanion(paidRounds: Value(r.paidRounds + 1), updatedAt: Value(now()), dirty: const Value(true)));
  }

  // ------------------------------------------------------------------- kid

  Future<void> kidDeposit(String memberId, String jar, int amount, {String label = ''}) async {
    final hid = (await householdId())!;
    final t = now();
    final profile = await (db.select(db.kidProfiles)..where((k) => k.memberId.equals(memberId))).getSingle();
    await db.transaction(() async {
      await db.into(db.kidEntries).insert(KidEntriesCompanion.insert(
            id: newId(), householdId: hid, createdAt: t, updatedAt: t, memberId: memberId, jar: jar,
            kind: 'deposit', amountMinor: amount, label: Value(label), occurredAt: t,
          ));
      if (jar == 'save' && profile.matchPercent > 0) {
        await db.into(db.kidEntries).insert(KidEntriesCompanion.insert(
              id: newId(), householdId: hid, createdAt: t, updatedAt: t, memberId: memberId, jar: 'save',
              kind: 'match', amountMinor: amount * profile.matchPercent ~/ 100, label: const Value('من بابا وماما'), occurredAt: t,
            ));
      }
    });
  }

  /// Returns false when the jar does not hold enough.
  Future<bool> kidSpend(String memberId, String jar, int amount, {String label = ''}) async {
    final entries = await (db.select(db.kidEntries)..where((k) => k.memberId.equals(memberId) & k.jar.equals(jar) & k.deletedAt.isNull())).get();
    final bal = entries.fold(0, (a, e) => a + e.amountMinor);
    if (bal < amount) return false;
    final hid = (await householdId())!;
    final t = now();
    await db.into(db.kidEntries).insert(KidEntriesCompanion.insert(
          id: newId(), householdId: hid, createdAt: t, updatedAt: t, memberId: memberId, jar: jar,
          kind: 'spend', amountMinor: -amount, label: Value(label), occurredAt: t,
        ));
    return true;
  }

  /// Weekly allowance split into the three jars (half spend, 40% save, 10% give).
  Future<void> kidAllowance(String memberId, int amount) async {
    final hid = (await householdId())!;
    final t = now();
    final spend = amount * 50 ~/ 100;
    final give = amount * 10 ~/ 100;
    final save = amount - spend - give;
    for (final e in [('spend', spend), ('save', save), ('give', give)]) {
      await db.into(db.kidEntries).insert(KidEntriesCompanion.insert(
            id: newId(), householdId: hid, createdAt: t, updatedAt: t, memberId: memberId, jar: e.$1,
            kind: 'allowance', amountMinor: e.$2, label: const Value('مصروف الأسبوع'), occurredAt: t,
          ));
    }
  }

  // --------------------------------------------------------------- general

  Future<void> setUsdRate(int rate) async {
    final h = await _household();
    await (db.update(db.households)..where((x) => x.id.equals(h.id)))
        .write(HouseholdsCompanion(usdRate: Value(rate), updatedAt: Value(now()), dirty: const Value(true)));
  }

  /// Wipes everything on this phone (used to leave demo mode).
  Future<void> wipeLocal() async {
    await db.transaction(() async {
      for (final t in db.allTables) {
        await db.delete(t).go();
      }
    });
  }
}
