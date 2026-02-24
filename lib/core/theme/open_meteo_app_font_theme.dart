import 'package:flutter/material.dart';

abstract class AppFonts {
  static const primary = 'Inter';
}

abstract class AppTextTheme {
  static TextTheme get textTheme => const TextTheme(
    displayLarge: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 80,
      fontWeight: FontWeight.w700,
      letterSpacing: -2,
      height: 1.0,
    ),

    displayMedium: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 56,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
      height: 1.0,
    ),

    displaySmall: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.1,
    ),

    headlineLarge: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 26,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      height: 1.2,
    ),

    headlineMedium: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
      height: 1.3,
    ),

    headlineSmall: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
      height: 1.3,
    ),

    titleLarge: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      height: 1.2,
    ),

    titleMedium: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 28,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      height: 1.1,
    ),

    titleSmall: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.3,
    ),

    bodyLarge: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.4,
    ),

    bodyMedium: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
      height: 1.3,
    ),

    bodySmall: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.4,
    ),

    labelLarge: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.2,
    ),

    labelMedium: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.2,
    ),

    labelSmall: TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
      height: 1.3,
    ),
  );
}

abstract class CustomTextStyles {
  static const hourLabel = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  static const rainPercentage = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF4FC3F7),
  );

  static const metricLabel = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const muted = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9E9E9E),
  );

  static const hint = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFFAAAAAA),
  );

  static const navLabel = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const forecastDay = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const forecastTempMin = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9E9E9E),
  );

  static const forecastTempMax = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const pageSubtitle = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9E9E9E),
  );
}
