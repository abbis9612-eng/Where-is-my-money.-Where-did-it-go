/// Turns what Iraqi families say or type into expense items, on the device.
///
/// Examples it handles:
///   "صرفت عشرين ألف مولدة"           -> generator 20,000
///   "صمون 2 وخضرة 5 وبنزين 25"       -> three items: 2,000 / 5,000 / 25,000
///   "دفعت ورقة للطبيب"               -> health, $100 (ورقة is a $100 note)
///   "ماما صرفت ربع مليون ملابس"       -> clothes 250,000, paid by mum
///   "خمسين دولار بنزين"               -> fuel, $50
///
/// Bare numbers below 250 mean thousands ("خبز 2" is 2,000 dinars), which is
/// how prices are spoken. Anything the rules cannot read is left for the
/// optional cloud parser.
library;

import '../core/money.dart';
import 'categories.dart';

class ParsedItem {
  const ParsedItem({
    required this.label,
    required this.categoryKey,
    required this.amountMinor,
    required this.currency,
    this.fromSlang = false,
  });

  /// The word the person used, e.g. "صمون".
  final String label;
  final String categoryKey;
  final int amountMinor;
  final Currency currency;

  /// True when the amount came from slang such as "ورقة" (a $100 note).
  final bool fromSlang;

  @override
  String toString() => 'ParsedItem($label, $categoryKey, $amountMinor ${currency.code})';
}

class ParseResult {
  const ParseResult(this.items, {this.memberHint});

  final List<ParsedItem> items;

  /// 'mum' or 'dad' when the sentence names who paid ("ماما صرفت ...").
  final String? memberHint;

  bool get isEmpty => items.isEmpty;
}

const Map<String, int> _numberWords = {
  'صفر': 0,
  'واحد': 1, 'وحدة': 1, 'وحده': 1,
  'اثنين': 2, 'ثنين': 2, 'اثنان': 2,
  'ثلاث': 3, 'ثلاثة': 3, 'تلاث': 3, 'تلاثة': 3, 'ثلاثه': 3,
  'أربع': 4, 'اربع': 4, 'أربعة': 4, 'اربعة': 4, 'اربعه': 4,
  'خمس': 5, 'خمسة': 5, 'خمسه': 5,
  'ست': 6, 'ستة': 6, 'سته': 6,
  'سبع': 7, 'سبعة': 7, 'سبعه': 7,
  'ثمان': 8, 'ثمانية': 8, 'ثمنية': 8, 'ثمانيه': 8,
  'تسع': 9, 'تسعة': 9, 'تسعه': 9,
  'عشر': 10, 'عشرة': 10, 'عشره': 10,
  'احدعش': 11, 'اطنعش': 12, 'ثلطعش': 13, 'خمسطعش': 15,
  'عشرين': 20, 'ثلاثين': 30, 'تلاثين': 30, 'أربعين': 40, 'اربعين': 40,
  'خمسين': 50, 'ستين': 60, 'سبعين': 70, 'ثمانين': 80, 'تسعين': 90,
  'مية': 100, 'ميه': 100, 'مئة': 100, 'مائة': 100, 'ميتين': 200,
  'ثلاثمية': 300, 'تلثمية': 300, 'اربعمية': 400, 'خمسمية': 500, 'ستمية': 600, 'سبعمية': 700, 'ثمنمية': 800, 'تسعمية': 900,
};

const _thousand = {'ألف', 'الف', 'آلاف', 'الاف', 'ألاف', 'الآف'};
const _twoThousand = {'ألفين', 'الفين'};
const _million = {'مليون', 'ملايين'};
const _quarter = {'ربع'};
const _half = {'نص', 'نصف'};
const _dollarNote = {'ورقة', 'ورقه', 'ورقتين'};
const _dollarWords = {'دولار', 'دولارات', r'$'};
const _dinarWords = {'دينار', 'د.ع', 'دنانير'};
const _mum = {'ماما', 'أم', 'زوجتي', 'مرتي', 'الماما'};
const _dad = {'بابا', 'أبو', 'زوجي', 'رجلي', 'البابا'};

String _normalizeDigits(String s) {
  const eastern = '٠١٢٣٤٥٦٧٨٩';
  const persian = '۰۱۲۳۴۵۶۷۸۹';
  final b = StringBuffer();
  for (final ch in s.runes) {
    final c = String.fromCharCode(ch);
    final e = eastern.indexOf(c);
    final p = persian.indexOf(c);
    if (e >= 0) {
      b.write(e);
    } else if (p >= 0) {
      b.write(p);
    } else if (c == '٫') {
      b.write('.');
    } else if (c == '٬') {
      b.write(',');
    } else {
      b.write(c);
    }
  }
  return b.toString();
}

String _stripPrefix(String w) {
  // Definite article and attached prepositions: الصمون، للطبيب، بالمولدة، وخضرة
  for (final p in const ['وال', 'بال', 'لل', 'ال', 'ب']) {
    if (w.length > p.length + 2 && w.startsWith(p)) return w.substring(p.length);
  }
  return w;
}

class _CatMatch {
  const _CatMatch(this.key, this.label);
  final String key;
  final String label;
}

_CatMatch? _category(String word, List<CategorySeed> cats) {
  final bare = _stripPrefix(word);
  for (final c in cats) {
    for (final k in c.keywords) {
      if (word == k || bare == k || bare == _stripPrefix(k)) return _CatMatch(c.key, k);
    }
  }
  // Prefix match only for longer keywords, so "مول" (mall) never swallows "مولدة".
  for (final c in cats) {
    for (final k in c.keywords) {
      final kk = _stripPrefix(k);
      if (kk.length >= 4 && bare.startsWith(kk)) return _CatMatch(c.key, k);
    }
  }
  return null;
}

enum _T { number, keyword }

class _Tok {
  _Tok.number(this.value, {this.explicit = false, this.currency, this.slang = false})
      : type = _T.number,
        key = null,
        label = null;
  _Tok.keyword(this.key, this.label)
      : type = _T.keyword,
        value = 0,
        explicit = false,
        currency = null,
        slang = false;

  final _T type;
  final double value;
  final bool explicit;
  Currency? currency;
  final bool slang;
  final String? key;
  final String? label;
}

class _NumBuilder {
  double total = 0;
  double group = 0;
  bool any = false;
  bool explicit = false;

  void add(double n) {
    group += n;
    any = true;
  }

  void scale(double m) {
    any = true;
    explicit = true;
    final base = group == 0 ? 1.0 : group;
    total += base * m;
    group = 0;
  }

  double get value => total + group;
}

ParseResult parseExpenseText(String input, {List<CategorySeed> categories = kDefaultCategories}) {
  final text = _normalizeDigits(input)
      .replaceAll(RegExp(r'[،؛!?؟]'), ' ')
      .replaceAllMapped(RegExp(r'(\d),(\d{3})'), (m) => '${m[1]}${m[2]}')
      .replaceAll(RegExp(r'(\d)(ألف|الف|آلاف)'), r'$1 $2')
      .replaceAll(r'$', r' $ ');
  final raw = text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
  final expenseCats = categories.where((c) => c.kind == CategoryKind.expense).toList();

  String? member;
  final toks = <_Tok>[];
  _NumBuilder? nb;

  void flush() {
    final b = nb;
    if (b != null && b.any) toks.add(_Tok.number(b.value, explicit: b.explicit));
    nb = null;
  }

  for (var i = 0; i < raw.length; i++) {
    var w = raw[i];
    // Leading "و" joins words: "وخضرة", "وعشرين". Keep it only when the rest is not meaningful.
    if (w.length > 1 && w.startsWith('و')) {
      final rest = w.substring(1);
      if (_numberWords.containsKey(rest) ||
          _thousand.contains(rest) ||
          _twoThousand.contains(rest) ||
          _million.contains(rest) ||
          _quarter.contains(rest) ||
          _half.contains(rest) ||
          _dollarNote.contains(rest) ||
          RegExp(r'^\d').hasMatch(rest) ||
          _category(rest, expenseCats) != null) {
        w = rest;
      }
    }

    if (_mum.contains(w)) {
      member ??= 'mum';
      continue;
    }
    if (_dad.contains(w)) {
      member ??= 'dad';
      continue;
    }

    final digits = RegExp(r'^\d+(\.\d+)?$');
    if (digits.hasMatch(w)) {
      flush();
      nb = _NumBuilder()..add(double.parse(w));
      continue;
    }
    if (_dollarNote.contains(w)) {
      flush();
      final count = w == 'ورقتين' ? 2 : 1;
      toks.add(_Tok.number(100.0 * count, explicit: true, currency: Currency.usd, slang: true));
      continue;
    }
    if (_dollarWords.contains(w)) {
      flush();
      for (var j = toks.length - 1; j >= 0; j--) {
        if (toks[j].type == _T.number) {
          toks[j].currency ??= Currency.usd;
          break;
        }
      }
      continue;
    }
    if (_dinarWords.contains(w)) {
      flush();
      continue;
    }
    if (_quarter.contains(w) || _half.contains(w)) {
      final f = _quarter.contains(w) ? 0.25 : 0.5;
      final next = i + 1 < raw.length ? raw[i + 1] : '';
      if (_million.contains(next) || _thousand.contains(next)) {
        // "ربع مليون", "نص مليون"
        flush();
        nb = _NumBuilder()
          ..any = true
          ..group = f;
        continue;
      }
      if (nb != null && nb!.any) {
        // "مليون ونص" -> half of the last scale
        final last = nb!.total;
        if (last >= 1000000) {
          nb!.total += 500000 * (f * 2);
        } else if (last >= 1000) {
          nb!.total += 1000 * f;
        } else {
          nb!.add(f);
        }
        continue;
      }
      flush();
      toks.add(_Tok.number(f == 0.25 ? 250 : 500, explicit: true));
      continue;
    }
    if (_twoThousand.contains(w)) {
      if (nb != null && nb!.any && nb!.explicit) {
        nb!.total += 2000;
      } else {
        flush();
        nb = _NumBuilder()..scale(2000);
      }
      continue;
    }
    if (_thousand.contains(w)) {
      nb ??= _NumBuilder();
      nb!.scale(1000);
      continue;
    }
    if (_million.contains(w)) {
      nb ??= _NumBuilder();
      nb!.scale(1000000);
      continue;
    }
    final n = _numberWords[w];
    if (n != null) {
      if (nb != null && nb!.any) {
        // "خمسة وعشرين" = 25, "مية وخمسين" = 150, "ألف وخمسمية" = 1,500
        nb!.add(n.toDouble());
      } else {
        flush();
        nb = _NumBuilder()..add(n.toDouble());
      }
      continue;
    }
    final cat = _category(w, expenseCats);
    if (cat != null) {
      flush();
      toks.add(_Tok.keyword(cat.key, cat.label));
      continue;
    }
    // Filler word ("صرفت", "على", "اليوم") ends any number in progress.
    flush();
  }
  flush();

  int amountOf(_Tok t) {
    final currency = t.currency ?? Currency.iqd;
    if (currency == Currency.usd) return (t.value * 100).round();
    final v = t.value;
    if (t.explicit || v >= 250) return v.round();
    return (v * 1000).round();
  }

  final items = <ParsedItem>[];
  final firstNum = toks.indexWhere((t) => t.type == _T.number);
  final firstKey = toks.indexWhere((t) => t.type == _T.keyword);

  if (firstKey < 0) {
    if (firstNum >= 0) {
      final t = toks[firstNum];
      items.add(ParsedItem(
          label: 'غيرها', categoryKey: 'other', amountMinor: amountOf(t), currency: t.currency ?? Currency.iqd, fromSlang: t.slang));
    }
    return ParseResult(items, memberHint: member);
  }

  // Either "number keyword number keyword" or "keyword number keyword number".
  final numberFirst = firstNum >= 0 && firstNum < firstKey;
  final usedNumbers = <int>{};
  for (var i = 0; i < toks.length; i++) {
    final k = toks[i];
    if (k.type != _T.keyword) continue;
    int? ni;
    if (numberFirst) {
      if (i > 0 && toks[i - 1].type == _T.number && !usedNumbers.contains(i - 1)) ni = i - 1;
      if (ni == null && i + 1 < toks.length && toks[i + 1].type == _T.number && !usedNumbers.contains(i + 1)) ni = i + 1;
    } else {
      if (i + 1 < toks.length && toks[i + 1].type == _T.number && !usedNumbers.contains(i + 1)) ni = i + 1;
      if (ni == null && i > 0 && toks[i - 1].type == _T.number && !usedNumbers.contains(i - 1)) ni = i - 1;
    }
    if (ni == null) {
      // Two keywords share one amount ("صمون وخضرة 5"): attach to the next item later.
      continue;
    }
    usedNumbers.add(ni);
    final t = toks[ni];
    items.add(ParsedItem(
      label: k.label!,
      categoryKey: k.key!,
      amountMinor: amountOf(t),
      currency: t.currency ?? Currency.iqd,
      fromSlang: t.slang,
    ));
  }
  return ParseResult(items.where((e) => e.amountMinor > 0).toList(), memberHint: member);
}
