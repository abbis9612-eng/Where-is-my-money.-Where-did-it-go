library;

/// "9:41 الصبح", "4:15 العصر" — how people say the time.
String spokenTime(DateTime d) {
  final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
  final part = d.hour < 12
      ? 'الصبح'
      : d.hour < 15
          ? 'الظهر'
          : d.hour < 18
              ? 'العصر'
              : 'بالليل';
  return '$h:${d.minute.toString().padLeft(2, '0')} $part';
}

String daysWord(int n) => n == 1 ? 'يوم' : n == 2 ? 'يومين' : '$n أيام';

/// "ل" + "الدراجة" is written "للدراجة".
String withLam(String word) => word.startsWith('ال') ? 'لل${word.substring(2)}' : 'ل$word';
