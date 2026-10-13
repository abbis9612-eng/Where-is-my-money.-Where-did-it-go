/// Supabase connection: email code sign-in, joining a family by invite code,
/// and background sync. The app works fully offline when no backend is set:
/// build with --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
library;

import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery, Variable;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repository.dart';
import 'sync_engine.dart';

class SupabaseRemote implements RemoteStore {
  SupabaseRemote(this.client);
  final SupabaseClient client;

  @override
  Future<void> upsert(String table, List<Map<String, Object?>> rows) => client.from(table).upsert(rows, onConflict: 'id');

  @override
  Future<List<Map<String, Object?>>> pullSince(String table, String cursor, {int limit = 500}) async {
    var q = client.from(table).select();
    if (cursor.isNotEmpty) q = q.gt('server_updated_at', cursor);
    final rows = await q.order('server_updated_at', ascending: true).limit(limit);
    return List<Map<String, Object?>>.from(rows);
  }
}

class SyncService {
  static const url = String.fromEnvironment('SUPABASE_URL');
  static const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  static bool get configured => url.isNotEmpty && anonKey.isNotEmpty;

  static bool _ready = false;
  static Timer? _debounce;
  static StreamSubscription<void>? _changes;
  static bool _running = false;

  static Future<void> initIfConfigured() async {
    if (!configured || _ready) return;
    await Supabase.initialize(url: url, publishableKey: anonKey);
    _ready = true;
  }

  static SupabaseClient get _client => Supabase.instance.client;

  static bool get signedIn => _ready && _client.auth.currentUser != null;
  static String? get email => _ready ? _client.auth.currentUser?.email : null;

  static Future<void> sendCode(String email) => _client.auth.signInWithOtp(email: email.trim(), shouldCreateUser: true);

  static Future<void> verifyCode(String email, String code) =>
      _client.auth.verifyOTP(email: email.trim(), token: code.trim(), type: OtpType.email);

  static Future<void> signOut() => _client.auth.signOut();

  /// After signing in on the phone that created the family: marks this
  /// phone's member as the signed-in user and pushes everything.
  static Future<SyncReport> linkAndSync(Repository repo) async {
    final uid = _client.auth.currentUser!.id;
    final me = await repo.getValue('me_member_id');
    if (me != null) {
      await repo.db.customUpdate(
        'UPDATE members SET user_id = ?, updated_at = ?, dirty = 1 WHERE id = ?',
        variables: [Variable.withString(uid), Variable.withInt(repo.now().millisecondsSinceEpoch ~/ 1000), Variable.withString(me)],
        updates: {repo.db.members},
      );
    }
    return syncNow(repo);
  }

  /// Second phone: joins with the invite code, replacing anything local.
  static Future<SyncReport> join(Repository repo, String code, String name) async {
    final res = await _client.rpc('join_household', params: {'code': code, 'member_name': name});
    final row = (res as List).first as Map<String, dynamic>;
    await repo.wipeLocal();
    await repo.setValue('household_id', row['household_id'] as String);
    await repo.setValue('me_member_id', row['member_id'] as String);
    return syncNow(repo);
  }

  /// Cloud fallback for sentences the on-device parser could not read.
  /// Sends only the sentence. Returns (label, category, amountMinor, currencyCode).
  static Future<List<(String, String, int, String)>> aiParse(String text) async {
    if (!signedIn) return const [];
    final res = await _client.functions.invoke('parse-expense', body: {'text': text});
    final items = (res.data as Map?)?['items'] as List? ?? const [];
    return [
      for (final i in items.cast<Map<String, dynamic>>())
        (i['label'] as String, i['category'] as String, (i['amount'] as num).toInt(), i['currency'] as String),
    ];
  }

  static Future<SyncReport> syncNow(Repository repo) async {
    if (!signedIn) return SyncReport();
    if (_running) return SyncReport();
    _running = true;
    try {
      final report = await SyncEngine(repo.db, SupabaseRemote(_client)).syncOnce();
      await repo.setValue('last_sync', repo.now().toIso8601String());
      return report;
    } finally {
      _running = false;
    }
  }

  /// Syncs a few seconds after local changes, and on app resume.
  static void start(Repository repo) {
    if (!configured) return;
    _changes?.cancel();
    _changes = repo.db.tableUpdates(const TableUpdateQuery.any()).listen((_) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(seconds: 4), () => syncNow(repo).catchError((_) => SyncReport()));
    });
  }
}
