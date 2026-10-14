import 'package:flutter_test/flutter_test.dart';
import 'package:ween_floosi/domain/barakah.dart';

void main() {
  test('every place has texts and ids are unique', () {
    for (final p in BarakahPlace.values) {
      expect(kBarakahTexts.where((t) => t.places.contains(p)), isNotEmpty, reason: p.name);
    }
    expect(kBarakahTexts.map((t) => t.id).toSet().length, kBarakahTexts.length);
  });

  test('every hadith and du\'a names its collection and number', () {
    for (final t in kBarakahTexts.where((t) => t.kind != BarakahKind.quran)) {
      expect(t.source, startsWith('رواه'), reason: t.id);
      expect(RegExp(r'\(\d+\)').hasMatch(t.source), isTrue, reason: t.id);
      final inSahihayn = t.source.contains('البخاري (') || t.source.contains('مسلم (');
      expect(inSahihayn || t.grade.isNotEmpty, isTrue, reason: '${t.id}: outside Bukhari/Muslim needs a grade');
    }
  });

  test('corrections from verification stay corrected', () {
    String text(String id) => kBarakahTexts.firstWhere((t) => t.id == id).text;
    expect(text('h_kilu'), 'كيلوا طعامكم يُبارك لكم'); // no «فيه» in Bukhari 2128
    expect(text('d_hamm'), contains('والجبن والبخل'));
    expect(kBarakahTexts.firstWhere((t) => t.id == 'h_akhfaha').source, 'رواه البخاري (1423)');
    expect(kBarakahTexts.any((t) => t.text.contains('لا زكاة في مال حتى يحول')), isFalse, reason: 'weak chain when shown alone');
  });

  test('the same text all day, rotating by day', () {
    final a = barakahFor(BarakahPlace.daily, DateTime(2026, 10, 14, 8));
    final b = barakahFor(BarakahPlace.daily, DateTime(2026, 10, 14, 22));
    final c = barakahFor(BarakahPlace.daily, DateTime(2026, 10, 15, 8));
    expect(a!.id, b!.id);
    expect(c!.id, isNot(a.id));
  });
}
