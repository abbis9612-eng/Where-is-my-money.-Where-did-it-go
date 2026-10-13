/// Reads bank messages from the phone's SMS inbox (Android only), with the
/// family's permission. Google Play allows READ_SMS for "SMS-based money
/// management" apps after the Permissions Declaration form is approved.
library;

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/repository.dart';
import '../domain/sms_parser.dart';

class SmsReader {
  static const _channel = MethodChannel('ween_floosi/sms');

  static Future<bool> granted() => Permission.sms.isGranted;

  static Future<bool> request() async => (await Permission.sms.request()).isGranted;

  /// Pulls new bank messages into the inbox. Returns how many were added.
  static Future<int> scan(Repository repo) async {
    if (await repo.getValue('sms_enabled') != '1') return 0;
    if (!await granted()) return 0;
    final since = int.tryParse(await repo.getValue('sms_last') ?? '') ??
        DateTime.now().subtract(const Duration(days: 3)).millisecondsSinceEpoch;
    final List<dynamic> rows;
    try {
      rows = await _channel.invokeMethod<List<dynamic>>('readInbox', {'since': since}) ?? const [];
    } on PlatformException {
      return 0;
    } on MissingPluginException {
      return 0;
    }
    var newest = since;
    final messages = <({String key, String sender, String body, DateTime at})>[];
    for (final r in rows.cast<Map<dynamic, dynamic>>()) {
      final sender = '${r['address'] ?? ''}';
      final date = (r['date'] as num?)?.toInt() ?? 0;
      if (date > newest) newest = date;
      if (!isBankSender(sender)) continue;
      messages.add((key: 'sms-${r['id']}', sender: sender, body: '${r['body'] ?? ''}', at: DateTime.fromMillisecondsSinceEpoch(date)));
    }
    final added = await repo.addSmsMessages(messages);
    await repo.setValue('sms_last', '$newest');
    return added;
  }
}
