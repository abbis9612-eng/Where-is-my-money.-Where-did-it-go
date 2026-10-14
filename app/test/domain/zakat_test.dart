import 'package:flutter_test/flutter_test.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:ween_floosi/domain/zakat.dart';

void main() {
  test('below the gold nisab owes nothing', () {
    // 85 g × 150,000 = 12,750,000 nisab.
    final r = computeZakat(const ZakatInput(cash: 10000000, goldPricePerGram: 150000));
    expect(r.nisab, 12750000);
    expect(r.reached, isFalse);
    expect(r.due, 0);
  });

  test('cash plus 21k gold at its pure weight reaches the nisab', () {
    // 40 g of 21k = 35 g pure = 5,250,000; with 10,000,000 cash = 15,250,000.
    final r = computeZakat(const ZakatInput(cash: 10000000, gold21: 40, goldPricePerGram: 150000));
    expect(r.wealth, 15250000);
    expect(r.reached, isTrue);
    expect(r.due, 381250);
  });

  test('silver basis has a lower nisab', () {
    final i = const ZakatInput(cash: 3000000, goldPricePerGram: 150000, silverPricePerGram: 2000);
    expect(computeZakat(i).reached, isFalse);
    final s = computeZakat(i.copyWith(basis: NisabBasis.silver));
    expect(s.nisab, 1190000);
    expect(s.due, 75000);
  });

  test('debts: receivable added, payable deducted only when chosen', () {
    const base = ZakatInput(cash: 20000000, receivable: 1000000, payable: 5000000, goldPricePerGram: 150000);
    expect(computeZakat(base).wealth, 21000000);
    expect(computeZakat(base.copyWith(deductPayable: true)).wealth, 16000000);
  });

  test('no price means the nisab cannot be judged', () {
    final r = computeZakat(const ZakatInput(cash: 50000000));
    expect(r.missingPrice, isTrue);
    expect(r.due, 0);
  });

  test('hawl is one Hijri year (354 or 355 days)', () {
    final start = DateTime(2026, 10, 14);
    final next = nextHawl(start);
    final h1 = HijriCalendar.fromDate(start), h2 = HijriCalendar.fromDate(next);
    expect(h2.hYear, h1.hYear + 1);
    expect(h2.hMonth, h1.hMonth);
    expect(next.difference(start).inDays, inInclusiveRange(353, 356));
  });

  test('zakat al-fitr counts everyone', () {
    expect(fitrTotal(people: 3, perPerson: 3000), 9000);
    expect(fitrTotal(people: 3, perPerson: 0), 0);
  });
}
