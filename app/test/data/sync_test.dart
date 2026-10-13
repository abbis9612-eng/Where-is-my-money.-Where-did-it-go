import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ween_floosi/data/database.dart';
import 'package:ween_floosi/data/repository.dart';
import 'package:ween_floosi/sync/sync_engine.dart';

/// In-memory server with the same rules as the Supabase trigger:
/// server timestamp on write, older updates ignored.
class FakeServer implements RemoteStore {
  final Map<String, Map<String, Map<String, Object?>>> tables = {};
  var _tick = 0;

  @override
  Future<void> upsert(String table, List<Map<String, Object?>> rows) async {
    final t = tables.putIfAbsent(table, () => {});
    for (final r in rows) {
      final old = t[r['id']];
      if (old != null && DateTime.parse(r['updated_at']! as String).isBefore(DateTime.parse(old['updated_at']! as String))) continue;
      _tick++;
      t[r['id']! as String] = {...r, 'server_updated_at': DateTime.utc(2026, 1, 1).add(Duration(milliseconds: _tick)).toIso8601String()};
    }
  }

  @override
  Future<List<Map<String, Object?>>> pullSince(String table, String cursor, {int limit = 500}) async {
    final rows = (tables[table]?.values ?? const <Map<String, Object?>>[])
        .where((r) => cursor.isEmpty || (r['server_updated_at']! as String).compareTo(cursor) > 0)
        .toList()
      ..sort((a, b) => (a['server_updated_at']! as String).compareTo(b['server_updated_at']! as String));
    return rows.take(limit).toList();
  }
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  test('two phones converge through the server, last write wins', () async {
    final server = FakeServer();
    var t = DateTime(2026, 10, 13, 9);
    final dbA = AppDatabase(NativeDatabase.memory());
    final dbB = AppDatabase(NativeDatabase.memory());
    final a = Repository(dbA, clock: () => t);
    final b = Repository(dbB, clock: () => t);

    await a.createHousehold(const HouseholdSetup(familyName: 'بيتنا', meName: 'بابا', partnerName: 'ماما', salary: 1250000, payDay: 1, savePercent: 10, bills: []));
    final ids = await a.addExpenses([const ExpenseDraft(label: 'بنزين', categoryKey: 'fuel', amountMinor: 20000)]);
    final first = await SyncEngine(dbA, server).syncOnce();
    expect(first.pushed, greaterThan(20));

    // Phone B joins: it learns the household id, then pulls everything.
    final hid = (await a.householdId())!;
    await b.setValue('household_id', hid);
    await b.setValue('me_member_id', (await a.loadSnapshot())!.members[1].id);
    await SyncEngine(dbB, server).syncOnce();
    final sb = (await b.loadSnapshot())!;
    expect(sb.household.name, 'بيتنا');
    expect(sb.members.map((m) => m.displayName), ['بابا', 'ماما']);
    expect((await dbB.select(dbB.txns).get()).single.amountMinor, 20000);

    // B spends; A sees it after both sync.
    t = t.add(const Duration(minutes: 5));
    await b.addExpenses([const ExpenseDraft(label: 'خبز', categoryKey: 'bread_veg', amountMinor: 1000)]);
    await SyncEngine(dbB, server).syncOnce();
    await SyncEngine(dbA, server).syncOnce();
    expect((await a.loadSnapshot())!.week.spent, 21000);

    // A deletes (soft) the generator later than B's last edit: the delete wins everywhere.
    t = t.add(const Duration(minutes: 5));
    await a.softDelete(ids);
    await SyncEngine(dbA, server).syncOnce();
    await SyncEngine(dbB, server).syncOnce();
    expect((await b.loadSnapshot())!.week.spent, 1000);

    // Nothing left to push after a full round.
    expect((await SyncEngine(dbA, server).syncOnce()).pushed, 0);

    await dbA.close();
    await dbB.close();
  });

  test('an older remote copy never overwrites a newer local edit', () async {
    final server = FakeServer();
    var t = DateTime(2026, 10, 13, 9);
    final db = AppDatabase(NativeDatabase.memory());
    final repo = Repository(db, clock: () => t);
    await repo.createHousehold(const HouseholdSetup(familyName: 'x', meName: 'بابا', salary: 1, payDay: 1, savePercent: 0, bills: []));
    await SyncEngine(db, server).syncOnce();
    t = t.add(const Duration(hours: 1));
    await repo.setUsdRate(1600); // local, newer, not yet pushed
    // Server still has the old row; pulling from scratch must keep 1600.
    await repo.setValue('cursor_households', '');
    await SyncEngine(db, server).syncOnce();
    expect((await repo.loadSnapshot())!.household.usdRate, 1600);
    await db.close();
  });
}
