/// One reminder per habit, never more: research found extra reminders add
/// nothing and can backfire.
library;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../data/database.dart';

class Reminders {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static var _ready = false;

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails('habits', 'تذكيرات العادات', channelDescription: 'تذكير بعد العشا، وجلسة الجمعة، والفواتير', importance: Importance.defaultImportance),
  );

  static Future<void> init() async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Asia/Baghdad'));
    }
    await _plugin.initialize(settings: const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')));
    _ready = true;
  }

  static Future<bool> requestPermission() async {
    await init();
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    return await android?.requestNotificationsPermission() ?? false;
  }

  static tz.TZDateTime _next(int hour, int minute, {int? weekday}) {
    final now = tz.TZDateTime.now(tz.local);
    var t = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    while (t.isBefore(now) || (weekday != null && t.weekday != weekday)) {
      t = t.add(const Duration(days: 1));
    }
    return t;
  }

  /// Rebuilds every scheduled reminder from the current settings and bills.
  static Future<void> reschedule({required bool evening, required bool friday, required List<Bill> bills}) async {
    await init();
    await _plugin.cancelAll();
    if (evening) {
      await _plugin.zonedSchedule(
        id: 1,
        title: 'بعد العشا',
        body: 'دقيقة وحدة: نأكّد صرف اليوم ونعدّ الجيب',
        scheduledDate: _next(21, 30),
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
    if (friday) {
      await _plugin.zonedSchedule(
        id: 2,
        title: 'جلسة الجمعة',
        body: 'دقيقتين: الباقي للخزنة وسؤال واحد',
        scheduledDate: _next(19, 0, weekday: DateTime.friday),
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
    var id = 100;
    for (final b in bills.where((b) => b.active)) {
      final now = tz.TZDateTime.now(tz.local);
      final day = (b.dayOfMonth - 1).clamp(1, 28);
      var t = tz.TZDateTime(tz.local, now.year, now.month, day, 18);
      if (t.isBefore(now)) t = tz.TZDateTime(tz.local, now.year, now.month + 1, day, 18);
      await _plugin.zonedSchedule(
        id: id++,
        title: '${b.name} باچر',
        body: 'تنحسب وحدها من فلوس الشهر، بس تأكدوا الفلوس جاهزة',
        scheduledDate: t,
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
      );
    }
  }
}
