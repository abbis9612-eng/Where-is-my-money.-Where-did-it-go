import 'package:flutter_test/flutter_test.dart';
import 'package:ween_floosi/core/money.dart';
import 'package:ween_floosi/domain/afford.dart';
import 'package:ween_floosi/domain/banknotes.dart';
import 'package:ween_floosi/domain/budget.dart';
import 'package:ween_floosi/domain/dialect_parser.dart';
import 'package:ween_floosi/domain/rosca.dart';
import 'package:ween_floosi/domain/sms_parser.dart';

void main() {
  group('money', () {
    test('groups thousands', () {
      expect(formatAmount(0), '0');
      expect(formatAmount(999), '999');
      expect(formatAmount(1000), '1,000');
      expect(formatAmount(1250000), '1,250,000');
      expect(formatAmount(-60000), '-60,000');
    });

    test('50 dollars at 1520 is 76,000 dinars', () {
      expect(toBaseIqd(5000, Currency.usd, 1520), 76000);
      expect(toBaseIqd(20000, Currency.iqd, 1520), 20000);
      expect(toBaseIqd(1, Currency.usd, 1520), 15); // 15.2 rounds to 15
    });

    test('formats dollars', () {
      expect(formatMoney(5000, Currency.usd), r'$50');
      expect(formatMoney(1250, Currency.usd), r'$12.50');
    });
  });

  group('banknotes', () {
    test('115,000 is four 25s, one 10, one 5', () {
      expect(breakdown(115000), [5000, 10000, 25000, 25000, 25000, 25000]);
    });

    test('spending 24,000 sends one 25 out and one 1,000 back', () {
      final d = diffNotes(115000, 91000);
      expect(d.removed, [25000]);
      expect(d.added, [1000]);
    });

    test('pays exactly when it can', () {
      final notes = breakdown(115000).reversed.toList();
      final pick = pickNotes(notes, 35000);
      expect(pick.total, 35000);
      expect(pick.changeFor(35000), 0);
    });

    test('covers the gap with the smallest note that fits', () {
      final notes = [25000, 25000, 10000];
      final pick = pickNotes(notes, 30000);
      expect(pick.total, 35000);
      expect(pick.changeFor(30000), 5000);
    });

    test('negative and tiny amounts give no notes', () {
      expect(breakdown(-5), isEmpty);
      expect(breakdown(200), isEmpty);
    });

    test('eastern digits', () => expect(easternDigits(25000), '٢٥٠٠٠'));
  });

  group('week', () {
    test('weeks start on Saturday', () {
      final tue = DateTime(2026, 10, 13, 9, 41);
      expect(weekStartOf(tue), DateTime(2026, 10, 10));
      expect(dayIndexInWeek(tue), 3);
      expect(daysLeftInWeek(tue), 4);
      expect(dayIndexInWeek(DateTime(2026, 10, 16)), 6); // Friday
      expect(dayIndexInWeek(DateTime(2026, 10, 17)), 0); // Saturday
    });

    test('pay cycle spans payday to payday', () {
      final c = payCycleOf(DateTime(2026, 10, 13), 1);
      expect(c.start, DateTime(2026, 10, 1));
      expect(c.end, DateTime(2026, 11, 1));
      final before = payCycleOf(DateTime(2026, 10, 3), 25);
      expect(before.start, DateTime(2026, 9, 25));
      expect(before.end, DateTime(2026, 10, 25));
    });

    test('save first comes out before the weekly allowance', () {
      const plan = MonthlyPlan(salary: 1250000, savePercent: 10, envelopesMonthly: 130000, fixedBills: 145000, payDay: 1);
      expect(plan.saveFirst, 125000);
      expect(plan.spendable, 850000);
      // 850,000 × 7 ÷ 31 days of October = 191,935 → 192,000
      expect(weeklyAllowance(plan, DateTime(2026, 10, 13)), 192000);
    });

    test('left, per day and day totals', () {
      final now = DateTime(2026, 10, 13, 12);
      final w = computeWeek(now: now, allowance: 198000, carried: 0, variableSpending: [
        DatedAmount(DateTime(2026, 10, 10, 10), 26000),
        DatedAmount(DateTime(2026, 10, 11, 10), 19000),
        DatedAmount(DateTime(2026, 10, 12, 10), 6500),
        DatedAmount(DateTime(2026, 10, 13, 8), 31500),
        DatedAmount(DateTime(2026, 10, 9, 10), 99999), // last week, ignored
      ]);
      expect(w.spent, 83000);
      expect(w.left, 115000);
      expect(w.daysLeft, 4);
      expect(w.perDay, 28750);
      expect(w.dayTotals, [26000, 19000, 6500, 31500, 0, 0, 0]);
    });

    test('over budget shows zero per day', () {
      final w = computeWeek(now: DateTime(2026, 10, 13), allowance: 10000, carried: 0, variableSpending: [DatedAmount(DateTime(2026, 10, 13), 15000)]);
      expect(w.over, isTrue);
      expect(w.perDay, 0);
    });

    test('Iraqi month names', () {
      expect(iraqiMonthName(10), 'تشرين الأول');
      expect(iraqiMonthName(1), 'كانون الثاني');
    });
  });

  group('afford', () {
    test('yes when each day keeps 15,000', () {
      final a = canAfford(price: 35000, left: 115000, daysLeft: 4);
      expect(a.level, AffordLevel.yes);
      expect(a.after, 80000);
      expect(a.perDayAfter, 20000);
    });

    test('tight suggests the comfortable price', () {
      final a = canAfford(price: 45000, left: 91000, daysLeft: 4);
      expect(a.level, AffordLevel.tight);
      expect(a.maxComfortable, 31000);
    });

    test('no when it is more than is left', () {
      final a = canAfford(price: 650000, left: 91000, daysLeft: 4);
      expect(a.level, AffordLevel.no);
      expect(a.shortBy, 559000);
      expect(a.weeksToSave, 13);
    });

    test('idle with no price', () => expect(canAfford(price: 0, left: 1, daysLeft: 1).level, AffordLevel.idle));
  });

  group('dialect parser', () {
    ParsedItem one(String s) {
      final r = parseExpenseText(s);
      expect(r.items, hasLength(1), reason: s);
      return r.items.single;
    }

    test('صرفت عشرين ألف مولدة', () {
      final i = one('صرفت عشرين ألف مولدة');
      expect(i.categoryKey, 'generator');
      expect(i.amountMinor, 20000);
      expect(i.currency, Currency.iqd);
    });

    test('several items in one sentence', () {
      final r = parseExpenseText('صمون 2 وخضرة 5 وبنزين 25');
      expect(r.items.map((e) => e.categoryKey), ['bread_veg', 'bread_veg', 'fuel']);
      expect(r.items.map((e) => e.amountMinor), [2000, 5000, 25000]);
      expect(r.items.map((e) => e.label), ['صمون', 'خضرة', 'بنزين']);
    });

    test('spoken numbers', () {
      expect(one('صرفت خمسة وعشرين بقالة').amountMinor, 25000);
      expect(one('صمون ألفين').amountMinor, 2000);
      expect(one('خضرة خمسة آلاف').amountMinor, 5000);
      expect(one('ملابس مية وخمسين').amountMinor, 150000);
      expect(one('ملابس ربع مليون').amountMinor, 250000);
      expect(one('مولدة ألف وخمسمية').amountMinor, 1500);
      expect(one('تصليح مليون ونص').amountMinor, 1500000);
      expect(one('حليب 3500').amountMinor, 3500);
      expect(one('حليب ٣٥٠٠').amountMinor, 3500);
      expect(one('بنزين 25,000').amountMinor, 25000);
    });

    test('voice transcript with several items', () {
      final r = parseExpenseText('صمون ألفين وخضرة خمسة آلاف وبنزين خمسة وعشرين');
      expect(r.items.map((e) => e.amountMinor), [2000, 5000, 25000]);
    });

    test('ورقة is a hundred dollars', () {
      final i = one('دفعت ورقة للطبيب');
      expect(i.categoryKey, 'health');
      expect(i.label, 'طبيب');
      expect(i.currency, Currency.usd);
      expect(i.amountMinor, 10000);
      expect(i.fromSlang, isTrue);
    });

    test('dollars', () {
      final i = one('خمسين دولار بنزين');
      expect(i.currency, Currency.usd);
      expect(i.amountMinor, 5000);
    });

    test('mall does not swallow generator', () {
      expect(one('مولدة 75').categoryKey, 'generator');
      expect(one('مول 40').categoryKey, 'groceries');
    });

    test('who paid', () {
      expect(parseExpenseText('ماما صرفت خمسة وعشرين خضرة').memberHint, 'mum');
      expect(parseExpenseText('بابا دفع بنزين 25').memberHint, 'dad');
    });

    test('amount without a known thing goes to other', () {
      final i = one('صرفت عشرة آلاف');
      expect(i.categoryKey, 'other');
      expect(i.amountMinor, 10000);
    });

    test('nothing to read', () => expect(parseExpenseText('هلو شلونكم').isEmpty, isTrue));
  });

  group('sms parser (sample shapes, to be checked against real messages)', () {
    test('Arabic purchase', () {
      final t = parseBankSms('تم خصم 12,500 د.ع من بطاقتك لدى SHIFA PHARMACY')!;
      expect(t.kind, SmsKind.purchase);
      expect(t.amountMinor, 12500);
      expect(t.currency, Currency.iqd);
      expect(t.merchant, 'SHIFA PHARMACY');
      expect(guessCategoryForMerchant(t.merchant), 'health');
    });

    test('English purchase in IQD', () {
      final t = parseBankSms('Purchase of IQD 18,000 at AL REEM REST. Balance ...')!;
      expect(t.kind, SmsKind.purchase);
      expect(t.amountMinor, 18000);
      expect(guessCategoryForMerchant(t.merchant), 'eating_out');
    });

    test('ATM withdrawal is a move to cash', () {
      final t = parseBankSms('ATM withdrawal IQD 100,000 at KARRADA')!;
      expect(t.kind, SmsKind.withdrawal);
    });

    test('salary credit', () {
      final t = parseBankSms('تم إيداع راتب 1,250,000 دينار في حسابك')!;
      expect(t.kind, SmsKind.credit);
      expect(t.amountMinor, 1250000);
    });

    test('dollars', () {
      final t = parseBankSms(r'Purchase USD 12.50 at NETFLIX')!;
      expect(t.currency, Currency.usd);
      expect(t.amountMinor, 1250);
    });

    test('ignores codes and chat', () {
      expect(parseBankSms('رمز التحقق 4821 لا تشاركه'), isNull);
      expect(parseBankSms('هلا شلونك'), isNull);
    });

    test('bank senders', () {
      expect(isBankSender('Qi Card'), isTrue);
      expect(isBankSender('QICARD'), isTrue);
      expect(isBankSender('+9647700000000'), isFalse);
    });
  });

  group('rosca', () {
    const r = Rosca(members: 10, contribution: 100000, startYear: 2026, startMonth: 7, myTurn: 7, paidRounds: 4);
    test('payout and month of our turn', () {
      expect(r.payout, 1000000);
      expect(r.myPayoutMonth, DateTime(2027, 1, 1));
      expect(r.payoutLabel(), 'كانون الثاني 2027');
    });
    test('rounds and net position', () {
      expect(r.roundAt(DateTime(2026, 10, 13)), 4);
      expect(r.roundsLeftToPay, 6);
      expect(r.netPosition(currentRound: 4), -400000);
    });
  });
}
