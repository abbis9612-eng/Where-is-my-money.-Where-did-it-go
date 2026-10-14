/// «لمسة بركة»: a small, verified set of Quran verses, hadith and du'a about
/// money, each shown where it fits (payday, Friday, a debt, going over the
/// week) instead of as a library nobody opens.
///
/// Every hadith carries its collection, number and grade. Only sahih and
/// hasan texts are included; the set was checked against dorar.net and
/// sunnah.com (see docs/07-barakah-sources.md). Change a text only with its
/// source.
library;

enum BarakahKind { quran, hadith, dua }

/// Where a text is shown.
enum BarakahPlace { daily, payday, friday, over, debt, family, kid, zakat, fitr, sadaqa }

class BarakahText {
  const BarakahText({
    required this.id,
    required this.kind,
    required this.text,
    required this.source,
    this.grade = '',
    this.note = '',
    required this.places,
  });

  final String id;
  final BarakahKind kind;

  /// The exact wording (a verse with its tashkeel, a hadith as narrated).
  final String text;

  /// "سبأ: 39", "رواه البخاري (1442) ومسلم (1010)".
  final String source;

  /// Empty for the Quran and for Bukhari/Muslim; otherwise who graded it.
  final String grade;

  /// One plain sentence on what it means for the family's money.
  final String note;
  final Set<BarakahPlace> places;

  String get citation => grade.isEmpty ? source : '$source، $grade';
}

/// The same text all day, a different one the next day.
BarakahText? barakahFor(BarakahPlace place, DateTime day, {List<BarakahText> from = kBarakahTexts}) {
  final list = from.where((t) => t.places.contains(place)).toList();
  if (list.isEmpty) return null;
  final n = DateTime.utc(day.year, day.month, day.day).millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
  return list[n % list.length];
}

const kBarakahTexts = <BarakahText>[];
