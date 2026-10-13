library;

import 'dart:math';

import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'database.dart';

/// Opens the on-device database encrypted with SQLite3MultipleCiphers. The
/// key is random per install and lives in the Android Keystore.
Future<AppDatabase> openAppDatabase() async {
  const storage = FlutterSecureStorage();
  var key = await storage.read(key: 'db_key');
  if (key == null) {
    final rnd = Random.secure();
    key = List.generate(32, (_) => rnd.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
    await storage.write(key: 'db_key', value: key);
  }
  final passphrase = key;
  return AppDatabase(driftDatabase(
    name: 'ween_floosi',
    native: DriftNativeOptions(
      shareAcrossIsolates: true,
      setup: (db) {
        // Fails fast if the build were ever linked against plain SQLite.
        db.select('SELECT sqlite3mc_version()');
        db.execute("PRAGMA key = '$passphrase';");
      },
    ),
  ));
}
