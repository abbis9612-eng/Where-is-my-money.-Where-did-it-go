import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:ween_floosi/data/database.dart';

void main() {
  test('the bundled SQLite is SQLite3MultipleCiphers and encrypts files', () async {
    final v = sqlite3.openInMemory();
    final row = v.select('SELECT sqlite3mc_version() AS v').first;
    expect(row['v'], isNotNull);
    v.close();

    final dir = await Directory.systemTemp.createTemp('wf');
    final file = File('${dir.path}/enc.sqlite');
    final db = AppDatabase(NativeDatabase(file, setup: (raw) => raw.execute("PRAGMA key = 'test-key';")));
    await db.into(db.keyValues).insert(KeyValuesCompanion.insert(key: 'secret', value: 'وين فلوسي'));
    await db.close();
    final bytes = await file.readAsBytes();
    expect(String.fromCharCodes(bytes.take(16)).startsWith('SQLite format 3'), isFalse, reason: 'header must be encrypted');

    final wrong = sqlite3.open(file.path);
    wrong.execute("PRAGMA key = 'wrong';");
    expect(() => wrong.select('SELECT * FROM key_values'), throwsA(isA<SqliteException>()));
    wrong.close();
    await dir.delete(recursive: true);
  });
}
