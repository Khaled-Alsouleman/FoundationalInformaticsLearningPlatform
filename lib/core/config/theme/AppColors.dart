import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color inactiveColor;
  final Color errorLow;
  final Color errorHeight;
  final Color backgroundColor;
  final Color white;
  final Color green;
  final Color orange;
  final Color transparent;

  const AppColorsTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.inactiveColor,
    required this.errorLow,
    required this.errorHeight,
    required this.backgroundColor,
    required this.white,
    required this.green,
    required this.orange,
    required this.transparent,
  });

  @override
  AppColorsTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    Color? inactiveColor,
    Color? errorLow,
    Color? errorHeight,
    Color? backgroundColor,
    Color? white,
    Color? green,
    Color? orange,
    Color? transparent,
  }) {
    return AppColorsTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      errorLow: errorLow ?? this.errorLow,
      errorHeight: errorHeight ?? this.errorHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      white: white ?? this.white,
      green: green ?? this.green,
      orange: orange ?? this.orange,
      transparent: transparent ?? this.transparent,
    );
  }

  @override
  AppColorsTheme lerp(ThemeExtension<AppColorsTheme>? other, double t) {
    if (other is! AppColorsTheme) return this;
    return AppColorsTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      errorLow: Color.lerp(errorLow, other.errorLow, t)!,
      errorHeight: Color.lerp(errorHeight, other.errorHeight, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      white: Color.lerp(white, other.white, t)!,
      green: Color.lerp(green, other.green, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      transparent: transparent,
    );
  }

  static const AppColorsTheme light = AppColorsTheme(
    primaryColor: Color(0XFF000814),
    secondaryColor: Color(0xFF134B70),
    accentColor: Color(0xFF8E44AD),
    inactiveColor: Colors.grey,
    errorLow: Color(0XFFdc2f02),
    errorHeight: Color(0XFFd00000),
    backgroundColor: Color(0XFFEEF5FF),
    white: Color(0xFFFFFFFF),
    green: Color(0XFF008000),
    orange: Colors.deepOrange,
    transparent: Colors.transparent,
  );

  static const AppColorsTheme dark = AppColorsTheme(
    primaryColor: Color(0xFFFFFFFF),
    secondaryColor: Color(0xFF444444),
    accentColor: Color(0xFF8E44AD),
    inactiveColor: Colors.grey,
    errorLow: Color(0XFFdc2f02),
    errorHeight: Color(0XFFd00000),
    backgroundColor: Color(0xFF000000),
    white: Color(0xFFFFFFFF),
    green: Color(0XFF008000),
    orange: Colors.deepOrange,
    transparent: Colors.transparent,
  );
}
