/// Money helpers. Amounts are always integers in the currency's minor unit:
/// Iraqi dinar has no fractions in practice (1 = 1 dinar), US dollar uses
/// cents (100 = $1). Never use double for stored money.
library;

enum Currency {
  iqd(code: 'IQD', minorDigits: 0, symbol: 'د.ع'),
  usd(code: 'USD', minorDigits: 2, symbol: r'$');

  const Currency({required this.code, required this.minorDigits, required this.symbol});

  final String code;
  final int minorDigits;
  final String symbol;

  static Currency fromCode(String code) =>
      Currency.values.firstWhere((c) => c.code == code, orElse: () => Currency.iqd);
}

/// Converts an amount to dinars (the household base currency) using the rate
/// stored on the transaction: [usdToIqd] dinars for one dollar.
int toBaseIqd(int amountMinor, Currency currency, int usdToIqd) {
  switch (currency) {
    case Currency.iqd:
      return amountMinor;
    case Currency.usd:
      // cents * rate / 100, rounded half up.
      final scaled = amountMinor * usdToIqd;
      return scaled >= 0 ? (scaled + 50) ~/ 100 : -((-scaled + 50) ~/ 100);
  }
}

/// "115,000" style grouping with Western digits, the form used across the app.
String formatAmount(int value) {
  final negative = value < 0;
  final digits = value.abs().toString();
  final buf = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buf.write(',');
    buf.write(digits[i]);
  }
  return negative ? '-$buf' : buf.toString();
}

/// Formats a minor-unit amount in its own currency, e.g. "$12.50" or "20,000".
String formatMoney(int amountMinor, Currency currency) {
  if (currency == Currency.iqd) return formatAmount(amountMinor);
  final whole = amountMinor ~/ 100;
  final cents = (amountMinor.abs() % 100);
  return cents == 0 ? '\$${formatAmount(whole)}' : '\$${formatAmount(whole)}.${cents.toString().padLeft(2, '0')}';
}

/// Rounds down to a multiple of [step]; used for the "about X a day" figure so
/// the shown number never promises more than is left.
int floorTo(int value, int step) => value <= 0 ? 0 : (value ~/ step) * step;

/// Rounds to the nearest multiple of [step].
int roundTo(int value, int step) => ((value + step ~/ 2) ~/ step) * step;
