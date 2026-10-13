/// Push/pull sync, table by table (ADR-4 in docs/02-spec.md).
///
/// Push: rows marked dirty are upserted; the server stamps server_updated_at
/// and ignores updates older than what it holds (last write wins per row).
/// Pull: rows with server_updated_at after this phone's cursor, applied when
/// they are at least as new as the local copy. Nothing is ever hard-deleted.
library;

import 'package:drift/drift.dart';

import '../data/database.dart';

abstract class RemoteStore {
  Future<void> upsert(String table, List<Map<String, Object?>> rows);

  /// Rows changed after [cursor] (a server timestamp, empty for "from the start"),
  /// oldest first.
  Future<List<Map<String, Object?>>> pullSince(String table, String cursor, {int limit = 500});
}

class SyncReport {
  int pushed = 0;
  int pulled = 0;
  @override
  String toString() => 'pushed $pushed, pulled $pulled';
}

class SyncEngine {
  SyncEngine(this.db, this.remote);
  final AppDatabase db;
  final RemoteStore remote;

  static const _batch = 500;

  Set<String> _cols(TableInfo t, DriftSqlType type) =>
      {for (final c in t.$columns) if (c.type == type) c.name};

  Map<String, Object?> _toRemote(TableInfo t, Map<String, Object?> row) {
    final dates = _cols(t, DriftSqlType.dateTime);
    final bools = _cols(t, DriftSqlType.bool);
    final out = <String, Object?>{};
    row.forEach((k, v) {
      if (k == 'dirty') return;
      if (v != null && dates.contains(k)) {
        out[k] = DateTime.fromMillisecondsSinceEpoch((v as int) * 1000, isUtc: true).toIso8601String();
      } else if (v != null && bools.contains(k)) {
        out[k] = v == 1 || v == true;
      } else {
        out[k] = v;
      }
    });
    return out;
  }

  Map<String, Object?> _toLocal(TableInfo t, Map<String, Object?> row) {
    final names = {for (final c in t.$columns) c.name};
    final dates = _cols(t, DriftSqlType.dateTime);
    final bools = _cols(t, DriftSqlType.bool);
    final out = <String, Object?>{};
    row.forEach((k, v) {
      if (!names.contains(k)) return; // server-only columns
      if (v != null && dates.contains(k)) {
        out[k] = DateTime.parse(v as String).millisecondsSinceEpoch ~/ 1000;
      } else if (v != null && bools.contains(k)) {
        out[k] = (v == true || v == 1) ? 1 : 0;
      } else {
        out[k] = v;
      }
    });
    out['dirty'] = 0;
    return out;
  }

  Future<SyncReport> syncOnce() async {
    final report = SyncReport();
    for (final t in db.syncedTables) {
      report.pushed += await _push(t);
    }
    for (final t in db.syncedTables) {
      report.pulled += await _pull(t);
    }
    return report;
  }

  Future<int> _push(TableInfo t) async {
    var total = 0;
    while (true) {
      final rows = await db.customSelect('SELECT * FROM ${t.actualTableName} WHERE dirty = 1 LIMIT $_batch', readsFrom: {t}).get();
      if (rows.isEmpty) break;
      await remote.upsert(t.actualTableName, [for (final r in rows) _toRemote(t, r.data)]);
      for (final r in rows) {
        // Only clear the flag if nobody edited the row while we were pushing.
        await db.customUpdate(
          'UPDATE ${t.actualTableName} SET dirty = 0 WHERE id = ? AND updated_at = ?',
          variables: [Variable.withString(r.data['id'] as String), Variable.withInt(r.data['updated_at'] as int)],
          updates: {t},
        );
      }
      total += rows.length;
      if (rows.length < _batch) break;
    }
    return total;
  }

  Future<int> _pull(TableInfo t) async {
    final key = 'cursor_${t.actualTableName}';
    var cursor = (await (db.select(db.keyValues)..where((k) => k.key.equals(key))).getSingleOrNull())?.value ?? '';
    var total = 0;
    while (true) {
      final rows = await remote.pullSince(t.actualTableName, cursor, limit: _batch);
      if (rows.isEmpty) break;
      await db.transaction(() async {
        for (final r in rows) {
          final local = _toLocal(t, r);
          final existing = await db
              .customSelect('SELECT updated_at, dirty FROM ${t.actualTableName} WHERE id = ?', variables: [Variable.withString(local['id'] as String)])
              .getSingleOrNull();
          final keepLocal = existing != null && (existing.data['updated_at'] as int) > (local['updated_at'] as int);
          if (!keepLocal) {
            final cols = local.keys.toList();
            await db.customInsert(
              'INSERT OR REPLACE INTO ${t.actualTableName} (${cols.join(', ')}) VALUES (${List.filled(cols.length, '?').join(', ')})',
              variables: [for (final c in cols) _variable(local[c])],
              updates: {t},
            );
          }
        }
      });
      cursor = rows.last['server_updated_at'] as String;
      await db.into(db.keyValues).insertOnConflictUpdate(KeyValuesCompanion.insert(key: key, value: cursor));
      total += rows.length;
      if (rows.length < _batch) break;
    }
    return total;
  }

  Variable _variable(Object? v) => switch (v) {
        null => const Variable(null),
        int() => Variable.withInt(v),
        String() => Variable.withString(v),
        double() => Variable.withReal(v),
        _ => Variable(v),
      };
}
