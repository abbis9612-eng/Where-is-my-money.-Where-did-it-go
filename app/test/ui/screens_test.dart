@Tags(['golden'])
library;

// Renders every main screen with the demo family and saves screenshots
// (run with --update-goldens to refresh them in test/ui/goldens/).
import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ween_floosi/data/database.dart';
import 'package:ween_floosi/data/demo.dart';
import 'package:ween_floosi/data/repository.dart';
import 'package:ween_floosi/state/providers.dart';
import 'package:ween_floosi/ui/screens/add_sheet.dart';
import 'package:ween_floosi/ui/screens/afford_sheet.dart';
import 'package:ween_floosi/ui/screens/friday_screen.dart';
import 'package:ween_floosi/ui/screens/giving_screen.dart';
import 'package:ween_floosi/ui/screens/inbox_sheet.dart';
import 'package:ween_floosi/ui/screens/kid_screen.dart';
import 'package:ween_floosi/ui/screens/onboarding_screen.dart';
import 'package:ween_floosi/ui/screens/pocket_sheet.dart';
import 'package:ween_floosi/ui/shell.dart';
import 'package:ween_floosi/ui/theme/theme.dart';
import 'package:ween_floosi/ui/widgets/common.dart';

Future<void> _loadFonts() async {
  Future<void> family(String name, List<String> files) async {
    final loader = FontLoader(name);
    for (final f in files) {
      loader.addFont(rootBundle.load('assets/fonts/$f'));
    }
    await loader.load();
  }

  await family('PlexArabic', ['IBMPlexSansArabic-Regular.ttf', 'IBMPlexSansArabic-Medium.ttf', 'IBMPlexSansArabic-SemiBold.ttf', 'IBMPlexSansArabic-Bold.ttf']);
  await family('Readex', ['ReadexPro-Light.ttf', 'ReadexPro-Regular.ttf', 'ReadexPro-Medium.ttf', 'ReadexPro-SemiBold.ttf']);
  await family('Ruqaa', ['ArefRuqaa-Bold.ttf']);
  final icons = File('${Platform.environment['FLUTTER_ROOT'] ?? '/opt/sdk/flutter'}/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf');
  if (icons.existsSync()) {
    final loader = FontLoader('MaterialIcons')..addFont(Future.value(ByteData.sublistView(icons.readAsBytesSync())));
    await loader.load();
  }
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  final clock = DateTime(2026, 10, 13, 9, 41);
  late AppDatabase db;
  late Repository repo;

  setUpAll(_loadFonts);

  Future<void> boot(WidgetTester tester, {bool dark = false, bool seed = true, Widget? home, Future<void> Function()? setup}) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.runAsync(() async {
      db = AppDatabase(NativeDatabase.memory());
      repo = Repository(db, clock: () => clock);
      if (seed) await seedDemo(repo);
      // Writes must happen before the app listens: a query started in the
      // fake clock holds the database until the next pump.
      if (setup != null) await setup();
    });
    await tester.pumpWidget(ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db), repositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar', 'IQ'),
        supportedLocales: const [Locale('ar', 'IQ')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: buildTheme(Brightness.light),
        darkTheme: buildTheme(Brightness.dark),
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        home: home ?? const RootGate(),
      ),
    ));
    await settle(tester);
  }

  /// Unmounts the app (cancelling streams) and closes the database outside
  /// the fake clock, otherwise drift waits forever.
  Future<void> done(WidgetTester tester) async {
    Toaster.hide();
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 5));
    await tester.runAsync(() => db.close());
  }

  Future<void> shot(WidgetTester tester, String name) async {
    await settle(tester);
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/$name.png'));
  }

  Future<void> sheet(WidgetTester tester, Widget child, String name, {double h = .9}) async {
    final ctx = tester.element(find.byType(Shell));
    showWfSheet(ctx, (_) => child, heightFactor: h);
    await shot(tester, name);
  }

  testWidgets('week', (tester) async {
    await boot(tester);
    await shot(tester, '01_week');
    await tester.drag(find.byType(CustomScrollView).first, const Offset(0, -500));
    await shot(tester, '02_week_lower');
    await done(tester);
  });

  testWidgets('week dark', (tester) async {
    await boot(tester, dark: true);
    await shot(tester, '03_week_dark');
    await done(tester);
  });

  testWidgets('add keypad and sentence', (tester) async {
    await boot(tester);
    await sheet(tester, const AddSheet(), '04_add_keypad');
    for (final k in ['2', '4', '000']) {
      await tester.tap(find.descendant(of: find.byType(Keypad), matching: find.text(k)), warnIfMissed: false);
      await tester.pump();
    }
    await shot(tester, '05_add_24000');
    await tester.enterText(find.byType(TextField), 'صمون 2 وخضرة 5 وبنزين 25');
    await shot(tester, '06_add_sentence');
    await done(tester);
  });

  testWidgets('afford', (tester) async {
    await boot(tester);
    await sheet(tester, const AffordSheet(initial: 45000), '07_afford_tight');
    await done(tester);
  });

  testWidgets('inbox', (tester) async {
    await boot(tester);
    await sheet(tester, const InboxSheet(), '08_inbox', h: .78);
    await done(tester);
  });

  testWidgets('pocket', (tester) async {
    await boot(tester);
    await sheet(tester, const PocketSheet(), '09_pocket');
    await done(tester);
  });

  testWidgets('tabs', (tester) async {
    await boot(tester);
    final container = ProviderScope.containerOf(tester.element(find.byType(Shell)));
    container.read(tabProvider.notifier).go(1);
    await shot(tester, '10_envelopes');
    container.read(tabProvider.notifier).go(2);
    await shot(tester, '11_report');
    container.read(tabProvider.notifier).go(3);
    await shot(tester, '12_family');
    await done(tester);
  });

  testWidgets('kid', (tester) async {
    await boot(tester);
    final kid = (await tester.runAsync(() => repo.loadSnapshot()))!.kids.single.member.id;
    Navigator.of(tester.element(find.byType(Shell))).push(MaterialPageRoute<void>(builder: (_) => KidScreen(memberId: kid)));
    await shot(tester, '13_kid');
    await done(tester);
  });

  testWidgets('friday', (tester) async {
    await boot(tester);
    Navigator.of(tester.element(find.byType(Shell))).push(MaterialPageRoute<void>(builder: (_) => const FridayScreen()));
    await shot(tester, '14_friday');
    await done(tester);
  });

  testWidgets('giving', (tester) async {
    await boot(tester, setup: () async {
      final eid = await repo.addSadaqaEnvelope(10000);
      final s = (await repo.loadSnapshot())!;
      await repo.runPayday(salary: 1250000, savePercent: 10, walletId: s.walletOfKind('qi_card')!.id);
      await repo.giveSadaqa(eid, 4000);
      await repo.setValue('zakat_inputs', '{"g21":"40","gPrice":"150000","sPrice":"2000","basis":"gold","deduct":false}');
      await repo.setValue('zakat_start', '2026-03-01T00:00:00.000');
    });
    Navigator.of(tester.element(find.byType(Shell))).push(MaterialPageRoute<void>(builder: (_) => const GivingScreen()));
    await shot(tester, '16_giving');
    await tester.drag(find.byType(ListView).last, const Offset(0, -900));
    await shot(tester, '17_zakat');
    await tester.drag(find.byType(ListView).last, const Offset(0, -900));
    await shot(tester, '18_zakat_fitr');
    await done(tester);
  });

  testWidgets('onboarding', (tester) async {
    await boot(tester, seed: false, home: const OnboardingScreen());
    await shot(tester, '15_onboarding');
    await done(tester);
  });
}

/// Pumps frames for a while; endless animations (the rosette) never settle.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 30; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 10)));
    await tester.pump(const Duration(milliseconds: 100));
  }
}
