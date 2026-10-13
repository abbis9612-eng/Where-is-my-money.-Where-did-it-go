/// Design tokens from design E ("رزمة الأسبوع"): cool note-paper light theme,
/// deep vault green, gold only for the vault, red only for leaks and overspend.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

class Wf extends ThemeExtension<Wf> {
  const Wf({
    required this.bg,
    required this.surface,
    required this.sunk,
    required this.press,
    required this.line,
    required this.ink,
    required this.mute,
    required this.faint,
    required this.vault,
    required this.vaultLine,
    required this.gold,
    required this.goldInk,
    required this.mint,
    required this.ok,
    required this.okBg,
    required this.warn,
    required this.warnBg,
    required this.alert,
    required this.alertBg,
    required this.tint,
    required this.tintInk,
    required this.primary,
    required this.onPrimary,
    required this.flap,
    required this.shadow,
    required this.kid,
    required this.kidBg,
    required this.brand,
  });

  final Color bg, surface, sunk, press, line, ink, mute, faint;
  final Color vault, vaultLine, gold, goldInk, mint;
  final Color ok, okBg, warn, warnBg, alert, alertBg;
  final Color tint, tintInk, primary, onPrimary, flap, shadow, kid, kidBg, brand;

  // Fixed colours used on the always-dark vault surfaces.
  static const vaultGreen = Color(0xFF0E3B32);
  static const vaultText = Color(0xFFFFFFFF);
  static const vaultMuted = Color(0xFFB9CFC7);
  static const vaultGold = Color(0xFFD1AA52);
  static const vaultMint = Color(0xFF9FD8C4);
  static const memberColors = [Color(0xFF1C6A5E), Color(0xFF93402F), Color(0xFF2E4782), Color(0xFF80602A), Color(0xFF55468A)];

  static const light = Wf(
    bg: Color(0xFFF1F4F1),
    surface: Color(0xFFFFFFFF),
    sunk: Color(0xFFE4E9E6),
    press: Color(0xFFDAE1DD),
    line: Color(0xFFDFE5E1),
    ink: Color(0xFF13201D),
    mute: Color(0xFF5B6A65),
    faint: Color(0xFFA9B5B0),
    vault: Color(0xFF0E3B32),
    vaultLine: Color(0x00000000),
    gold: Color(0xFFD1AA52),
    goldInk: Color(0xFF7A5A14),
    mint: Color(0xFF9FD8C4),
    ok: Color(0xFF1D7550),
    okBg: Color(0xFFDDF0E6),
    warn: Color(0xFF9A620E),
    warnBg: Color(0xFFF6EAD3),
    alert: Color(0xFFB5362A),
    alertBg: Color(0xFFF5DEDA),
    tint: Color(0xFFE1EFE8),
    tintInk: Color(0xFF0E3B32),
    primary: Color(0xFF13201D),
    onPrimary: Color(0xFFFFFFFF),
    flap: Color(0xFFECF0ED),
    shadow: Color(0x290F1C18),
    kid: Color(0xFF2E4782),
    kidBg: Color(0xFFE3E8F5),
    brand: Color(0xFF0E3B32),
  );

  static const dark = Wf(
    bg: Color(0xFF0B1412),
    surface: Color(0xFF14201D),
    sunk: Color(0xFF1C2A26),
    press: Color(0xFF26372F),
    line: Color(0xFF22312C),
    ink: Color(0xFFE6EEEB),
    mute: Color(0xFF93A69F),
    faint: Color(0xFF4B5D57),
    vault: Color(0xFF0F4136),
    vaultLine: Color(0xFF1F5A4C),
    gold: Color(0xFFD9B25C),
    goldInk: Color(0xFFD9B25C),
    mint: Color(0xFF9FD8C4),
    ok: Color(0xFF5CC08F),
    okBg: Color(0xFF163828),
    warn: Color(0xFFE3A84B),
    warnBg: Color(0xFF3A2C14),
    alert: Color(0xFFF0796B),
    alertBg: Color(0xFF3E1D19),
    tint: Color(0xFF15302A),
    tintInk: Color(0xFFBFE6D7),
    primary: Color(0xFFE6EEEB),
    onPrimary: Color(0xFF0B1412),
    flap: Color(0xFF1F2E2A),
    shadow: Color(0x80000000),
    kid: Color(0xFF8EA6E6),
    kidBg: Color(0xFF1B2440),
    brand: Color(0xFF9FD8C4),
  );

  static Wf of(BuildContext context) => Theme.of(context).extension<Wf>()!;

  Color memberColor(int index) => memberColors[index % memberColors.length];

  @override
  Wf copyWith() => this;

  @override
  Wf lerp(ThemeExtension<Wf>? other, double t) {
    if (other is! Wf) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return Wf(
      bg: l(bg, other.bg), surface: l(surface, other.surface), sunk: l(sunk, other.sunk), press: l(press, other.press),
      line: l(line, other.line), ink: l(ink, other.ink), mute: l(mute, other.mute), faint: l(faint, other.faint),
      vault: l(vault, other.vault), vaultLine: l(vaultLine, other.vaultLine), gold: l(gold, other.gold),
      goldInk: l(goldInk, other.goldInk), mint: l(mint, other.mint), ok: l(ok, other.ok), okBg: l(okBg, other.okBg),
      warn: l(warn, other.warn), warnBg: l(warnBg, other.warnBg), alert: l(alert, other.alert), alertBg: l(alertBg, other.alertBg),
      tint: l(tint, other.tint), tintInk: l(tintInk, other.tintInk), primary: l(primary, other.primary),
      onPrimary: l(onPrimary, other.onPrimary), flap: l(flap, other.flap), shadow: l(shadow, other.shadow),
      kid: l(kid, other.kid), kidBg: l(kidBg, other.kidBg), brand: l(brand, other.brand),
    );
  }
}

/// Type roles: Plex Arabic for reading (line height 1.7), Readex Pro for
/// money, Aref Ruqaa only for the brand and stamps.
class WfText {
  static const ui = 'PlexArabic';
  static const num = 'Readex';
  static const brand = 'Ruqaa';

  static TextStyle money(double size, {FontWeight weight = FontWeight.w300, Color? color, double height = 1.1}) => TextStyle(
        fontFamily: num,
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color,
        letterSpacing: size > 30 ? -size * 0.02 : 0,
        fontFeatures: const [FontFeature.tabularFigures()],
      );
}

ThemeData buildTheme(Brightness b) {
  final wf = b == Brightness.dark ? Wf.dark : Wf.light;
  final scheme = ColorScheme.fromSeed(seedColor: Wf.vaultGreen, brightness: b).copyWith(
    surface: wf.bg,
    onSurface: wf.ink,
    primary: wf.primary,
    onPrimary: wf.onPrimary,
    error: wf.alert,
  );
  final base = ThemeData(useMaterial3: true, brightness: b, colorScheme: scheme, fontFamily: WfText.ui);
  TextStyle t(double size, FontWeight w, {double h = 1.7}) => TextStyle(fontFamily: WfText.ui, fontSize: size, fontWeight: w, height: h, color: wf.ink);
  return base.copyWith(
    scaffoldBackgroundColor: wf.bg,
    extensions: [wf],
    splashFactory: InkSparkle.splashFactory,
    textTheme: base.textTheme.copyWith(
      headlineMedium: t(26, FontWeight.w600, h: 1.35),
      headlineSmall: t(22, FontWeight.w600, h: 1.35),
      titleLarge: t(20, FontWeight.w600, h: 1.4),
      titleMedium: t(16, FontWeight.w600, h: 1.5),
      bodyLarge: t(16, FontWeight.w400),
      bodyMedium: t(15, FontWeight.w400),
      bodySmall: TextStyle(fontFamily: WfText.ui, fontSize: 13, height: 1.6, color: wf.mute),
      labelLarge: t(15, FontWeight.w600, h: 1.3),
      labelMedium: TextStyle(fontFamily: WfText.ui, fontSize: 12, height: 1.4, color: wf.mute),
    ),
    dividerColor: wf.line,
    snackBarTheme: SnackBarThemeData(backgroundColor: wf.primary, contentTextStyle: TextStyle(color: wf.onPrimary, fontFamily: WfText.ui)),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: wf.bg,
      modalBackgroundColor: wf.bg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      showDragHandle: true,
      dragHandleColor: wf.faint,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.white),
      trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? wf.ok : wf.sunk),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: wf.surface,
      hintStyle: TextStyle(color: wf.faint, fontFamily: WfText.ui),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: wf.line, width: 1.5)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: wf.line, width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: wf.ink, width: 1.5)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    }),
  );
}

/// An underdamped spring response used for every "physical" movement
/// (notes landing, sheets, the rolling counter).
class SpringCurve extends Curve {
  const SpringCurve({this.damping = 0.62});

  /// Lower is bouncier; 1 is no overshoot.
  final double damping;

  @override
  double transformInternal(double t) {
    const omega = 13.0;
    final zeta = damping.clamp(0.05, 0.999);
    final wd = omega * math.sqrt(1 - zeta * zeta);
    final env = math.exp(-zeta * omega * t);
    return 1 - env * (math.cos(wd * t) + (zeta * omega / wd) * math.sin(wd * t));
  }
}
