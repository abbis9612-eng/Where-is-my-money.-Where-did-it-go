import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/connection.dart';
import 'state/providers.dart';
import 'sync/sync_service.dart';
import 'ui/shell.dart';
import 'ui/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final text = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(const ['IBM Plex Sans Arabic', 'Readex Pro', 'Aref Ruqaa'], text);
  });
  final db = await openAppDatabase();
  await SyncService.initIfConfigured();
  runApp(ProviderScope(overrides: [databaseProvider.overrideWithValue(db)], child: const WeenFloosiApp()));
}

class WeenFloosiApp extends ConsumerWidget {
  const WeenFloosiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'وين فلوسي',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'IQ'),
      supportedLocales: const [Locale('ar', 'IQ'), Locale('ar')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: ref.watch(themeModeProvider),
      home: const RootGate(),
    );
  }
}
