/// Reads bank and card text messages into pending items the family confirms
/// with one tap.
///
/// The exact Qi Card message format is not public. These rules recognise the
/// common shapes of Arabic and English debit, withdrawal and credit messages
/// (amount + currency + merchant). They must be checked against real messages
/// from the family's phones before release; unknown messages are ignored, not
/// guessed.
library;

import '../core/money.dart';

enum SmsKind { purchase, withdrawal, credit }

class SmsTransaction {
  const SmsTransaction({required this.kind, required this.amountMinor, required this.currency, this.merchant});

  final SmsKind kind;
  final int amountMinor;
  final Currency currency;
  final String? merchant;
}

/// Senders treated as banks. People can add more in settings.
const kDefaultBankSenders = ['Qi', 'QiCard', 'Qi Card', 'SuperQi', 'Rafidain', 'Rasheed', 'FIB', 'ZainCash', 'AsiaHawala'];

bool isBankSender(String sender, {List<String> senders = kDefaultBankSenders}) {
  final s = sender.toLowerCase().replaceAll(' ', '');
  return senders.any((k) => s.contains(k.toLowerCase().replaceAll(' ', '')));
}

final _amount = RegExp(
  r'(?:(IQD|USD|د\.?ع|دينار|\$)\s*([\d٠-٩][\d٠-٩,٬\.]*))|(?:([\d٠-٩][\d٠-٩,٬\.]*)\s*(IQD|USD|د\.?ع|دينار|دولار|\$))',
  caseSensitive: false,
);
final _withdrawal = RegExp(r'سحب|ATM|withdraw|cash ?out', caseSensitive: false);
final _credit = RegExp(r'إيداع|ايداع|اضافة|إضافة|تحويل وارد|راتب|credited|deposit|received', caseSensitive: false);
final _purchase = RegExp(r'خصم|شراء|دفع|debit|purchase|POS|paid|spent', caseSensitive: false);
final _merchantStrong = RegExp(r'(?:لدى|عند|\bat\b|@)\s*([^\n.,،]{2,40})', caseSensitive: false);
final _merchantWeak = RegExp(r'(?:\s|^)(?:في|من)\s+([^\n.,،]{2,40})', caseSensitive: false);
final _otp = RegExp(r'OTP|رمز التحقق|verification code|كلمة المرور', caseSensitive: false);

String _ascii(String s) {
  const eastern = '٠١٢٣٤٥٦٧٨٩';
  return s.split('').map((c) {
    final i = eastern.indexOf(c);
    return i >= 0 ? '$i' : c;
  }).join();
}

SmsTransaction? parseBankSms(String body) {
  if (_otp.hasMatch(body)) return null;
  final m = _amount.firstMatch(body);
  if (m == null) return null;
  final curRaw = (m.group(1) ?? m.group(4) ?? '').toUpperCase();
  final numRaw = _ascii(m.group(2) ?? m.group(3) ?? '').replaceAll(RegExp(r'[,٬]'), '');
  final value = double.tryParse(numRaw);
  if (value == null || value <= 0) return null;
  final currency = (curRaw == 'USD' || curRaw == r'$' || curRaw == 'دولار') ? Currency.usd : Currency.iqd;
  final amountMinor = currency == Currency.usd ? (value * 100).round() : value.round();

  final SmsKind kind;
  if (_withdrawal.hasMatch(body)) {
    kind = SmsKind.withdrawal;
  } else if (_credit.hasMatch(body) && !_purchase.hasMatch(body)) {
    kind = SmsKind.credit;
  } else if (_purchase.hasMatch(body)) {
    kind = SmsKind.purchase;
  } else {
    return null;
  }

  String? merchant;
  final tail = body.substring(m.end);
  final mm = _merchantStrong.firstMatch(tail) ?? _merchantWeak.firstMatch(tail);
  if (mm != null) merchant = mm.group(1)!.trim();
  return SmsTransaction(kind: kind, amountMinor: amountMinor, currency: currency, merchant: merchant);
}

/// Guesses a category from the merchant name. Falls back to "other".
String guessCategoryForMerchant(String? merchant) {
  if (merchant == null) return 'other';
  final m = merchant.toLowerCase();
  const rules = <String, List<String>>{
    'health': ['pharm', 'صيدلية', 'hospital', 'مستشفى', 'clinic', 'عيادة', 'lab', 'مختبر'],
    'fuel': ['fuel', 'petrol', 'station', 'محطة', 'وقود'],
    'eating_out': ['rest', 'مطعم', 'cafe', 'كافيه', 'burger', 'pizza', 'shawarma'],
    'groceries': ['market', 'ماركت', 'mall', 'مول', 'hyper', 'store', 'super'],
    'phone_net': ['asiacell', 'zain', 'korek', 'earthlink', 'انترنت'],
    'clothes': ['fashion', 'ملابس', 'shoes'],
  };
  for (final e in rules.entries) {
    if (e.value.any(m.contains)) return e.key;
  }
  return 'other';
}
