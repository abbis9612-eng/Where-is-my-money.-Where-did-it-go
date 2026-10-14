/// Zakat on money (زكاة المال) and zakat al-fitr, as plain arithmetic.
///
/// The app computes on one well-known position and shows which; it never
/// rules on a family's case. Where scholars differ (nisab by gold or silver,
/// worn jewellery, deducting debts) the family chooses, and the screen says
/// to ask people of knowledge.
library;

import 'package:hijri/hijri_calendar.dart';

/// 20 mithqal of gold and 200 dirhams of silver, in grams.
const kGoldNisabGrams = 85.0;
const kSilverNisabGrams = 595.0;

/// A quarter of a tenth.
const kZakatRate = 0.025;

enum NisabBasis { gold, silver }

class ZakatInput {
  const ZakatInput({
    this.cash = 0,
    this.gold24 = 0,
    this.gold21 = 0,
    this.gold18 = 0,
    this.silverGrams = 0,
    this.receivable = 0,
    this.payable = 0,
    this.deductPayable = false,
    this.goldPricePerGram = 0,
    this.silverPricePerGram = 0,
    this.basis = NisabBasis.gold,
  });

  /// Dinars held: cash, cards, the vault and envelopes (USD already converted).
  final int cash;

  /// Gold weights in grams by karat.
  final double gold24;
  final double gold21;
  final double gold18;
  final double silverGrams;

  /// Money others owe the family and are able and willing to repay.
  final int receivable;

  /// Debts the family owes that are due now.
  final int payable;
  final bool deductPayable;

  /// Today's price of one gram of pure (24k) gold and of silver, in dinars.
  final int goldPricePerGram;
  final int silverPricePerGram;
  final NisabBasis basis;

  /// Gold counted by its pure content: 21k is 21/24 gold.
  double get pureGoldGrams => gold24 + gold21 * 21 / 24 + gold18 * 18 / 24;

  ZakatInput copyWith({
    int? cash,
    double? gold24,
    double? gold21,
    double? gold18,
    double? silverGrams,
    int? receivable,
    int? payable,
    bool? deductPayable,
    int? goldPricePerGram,
    int? silverPricePerGram,
    NisabBasis? basis,
  }) =>
      ZakatInput(
        cash: cash ?? this.cash,
        gold24: gold24 ?? this.gold24,
        gold21: gold21 ?? this.gold21,
        gold18: gold18 ?? this.gold18,
        silverGrams: silverGrams ?? this.silverGrams,
        receivable: receivable ?? this.receivable,
        payable: payable ?? this.payable,
        deductPayable: deductPayable ?? this.deductPayable,
        goldPricePerGram: goldPricePerGram ?? this.goldPricePerGram,
        silverPricePerGram: silverPricePerGram ?? this.silverPricePerGram,
        basis: basis ?? this.basis,
      );
}

class ZakatResult {
  const ZakatResult({required this.wealth, required this.nisab, required this.due, required this.missingPrice});

  /// Everything zakat is counted on, in dinars.
  final int wealth;

  /// The nisab in dinars at today's price; 0 when the price is unknown.
  final int nisab;

  /// 2.5% of [wealth] when it reaches the nisab, else 0.
  final int due;

  /// The nisab cannot be judged without the price of gold (or silver).
  final bool missingPrice;

  bool get reached => !missingPrice && wealth >= nisab && wealth > 0;
}

ZakatResult computeZakat(ZakatInput i) {
  final goldValue = (i.pureGoldGrams * i.goldPricePerGram).round();
  final silverValue = (i.silverGrams * i.silverPricePerGram).round();
  var wealth = i.cash + goldValue + silverValue + i.receivable;
  if (i.deductPayable) wealth -= i.payable;
  if (wealth < 0) wealth = 0;
  final price = i.basis == NisabBasis.gold ? i.goldPricePerGram : i.silverPricePerGram;
  final grams = i.basis == NisabBasis.gold ? kGoldNisabGrams : kSilverNisabGrams;
  if (price <= 0) return ZakatResult(wealth: wealth, nisab: 0, due: 0, missingPrice: true);
  final nisab = (grams * price).round();
  final due = wealth >= nisab && wealth > 0 ? (wealth * kZakatRate).ceil() : 0;
  return ZakatResult(wealth: wealth, nisab: nisab, due: due, missingPrice: false);
}

/// The same Hijri date one year later: zakat's year is lunar (about 354 days).
DateTime nextHawl(DateTime start) {
  final h = HijriCalendar.fromDate(start);
  final cal = HijriCalendar();
  final y = h.hYear + 1, m = h.hMonth;
  final first = cal.hijriToGregorian(y, m, 1);
  final nextFirst = m == 12 ? cal.hijriToGregorian(y + 1, 1, 1) : cal.hijriToGregorian(y, m + 1, 1);
  final len = nextFirst.difference(first).inDays;
  return cal.hijriToGregorian(y, m, h.hDay > len ? len : h.hDay);
}

/// Zakat al-fitr for everyone in the house, children included.
int fitrTotal({required int people, required int perPerson}) => people <= 0 || perPerson <= 0 ? 0 : people * perPerson;

/// True in the last ten days of Ramadan, when zakat al-fitr should be ready.
bool isFitrSeason(DateTime day) {
  final h = HijriCalendar.fromDate(day);
  return h.hMonth == 9 && h.hDay >= 20;
}

const kHijriMonths = [
  'محرّم', 'صفر', 'ربيع الأول', 'ربيع الآخر', 'جمادى الأولى', 'جمادى الآخرة',
  'رجب', 'شعبان', 'رمضان', 'شوّال', 'ذو القعدة', 'ذو الحجة',
];

String hijriLabel(DateTime day) {
  final h = HijriCalendar.fromDate(day);
  return '${h.hDay} ${kHijriMonths[h.hMonth - 1]} ${h.hYear}';
}

/// Points scholars differ on, said plainly. Sources in
/// docs/07-barakah-sources.md.
const kZakatNotes = <String>[
  'النصاب بالذهب 85 غرام ذهب خالص (عيار 24)، وبالفضة 595 غرام. الذهب عيار 21 ينحسب بوزنه الخالص: الوزن × 21 ÷ 24.',
  'نصاب الفلوس: جماعة من أهل العلم (منهم المجمع الفقهي برابطة العالم الإسلامي وهيئة كبار العلماء) يقدّرونه بالفضة لأنه أنفع للفقراء، '
      'وآخرون (منهم دار الإفتاء المصرية) يقدّرونه بالذهب. لهذا الاختيار قدامكم.',
  'ذهب الزينة اللي تلبسه المرأة: الحنفية يوجبون بيه الزكاة، وأغلب العلماء (المالكية والشافعية والحنابلة) ما يوجبونها. اكتبوه أو لا حسب القول اللي تتبعونه.',
  'الديون اللي إلكم: إذا اللي عليه الدين قادر وراضي يرجعها، تنحسب كل سنة. وإذا عاجز أو منكر، ما تنحسب لحد ما توصل.',
  'الديون اللي عليكم: الحنفية والحنابلة يخصمونها، والشافعية ما يخصمونها، والمالكية يخصمونها من الفلوس. لهذا الخصم اختياري.',
  'الحول سنة هجرية (حوالي 354 يوم) من يوم ما وصلت فلوسكم النصاب.',
];

/// Announced by the Iraqi Fiqh Council with the Sunni Endowment for
/// Ramadan 1447 (2026) as the minimum per person, in dinars.
const kFitrIraq1447 = 3000;

const kFitrSummary = 'تنطى عن كل فرد بالبيت، كبير وصغير، وأصلها صاع من الطعام (حوالي 3 كيلو). '
    'وقتها قبل صلاة العيد، ويجوز قبل العيد بيوم أو يومين. '
    'إخراجها فلوس: يجيزه الحنفية، وأغلب العلماء يرونها طعامًا. '
    'لرمضان 1447 أعلن المجمع الفقهي العراقي وديوان الوقف السني 3,000 دينار حدًّا أدنى عن الشخص.';
