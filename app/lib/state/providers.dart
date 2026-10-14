library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../data/repository.dart';
import '../data/snapshot.dart';

/// Overridden in main() with the opened, encrypted database.
final databaseProvider = Provider<AppDatabase>((ref) => throw UnimplementedError('database not opened'));

final repositoryProvider = Provider<Repository>((ref) => Repository(ref.watch(databaseProvider)));

final snapshotProvider = StreamProvider<Snapshot?>((ref) => ref.watch(repositoryProvider).watchSnapshot());

/// Month report; recomputed whenever the data changes.
final monthReportProvider = FutureProvider.family<MonthReport, (int, int)>((ref, ym) {
  ref.watch(snapshotProvider);
  return ref.watch(repositoryProvider).monthReport(ym.$1, ym.$2);
});

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final sub = ref.watch(repositoryProvider).watchValue('theme').listen((v) {
      state = switch (v) { 'dark' => ThemeMode.dark, 'light' => ThemeMode.light, _ => ThemeMode.system };
    });
    ref.onDispose(sub.cancel);
    return ThemeMode.system;
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await ref.read(repositoryProvider).setValue('theme', mode.name);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

/// Bottom tab index of the main shell.
class TabNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void go(int i) => state = i;
}

final tabProvider = NotifierProvider<TabNotifier, int>(TabNotifier.new);

/// «لمسة بركة» on or off (on unless the family turned it off).
final barakahOnProvider = StreamProvider<bool>((ref) => ref.watch(repositoryProvider).watchValue('barakah').map((v) => v != '0'));
