import 'package:flutter/material.dart';

abstract class WeatherColors {
  static const clearSky = WeatherPalette(
    primary: Color(0xFF4FC3F7),
    secondary: Color(0xFFFFD54F),
    background: Color(0xFFE1F5FE),
    onPrimary: Color(0xFF01579B),
  );

  static const partlyCloudy = WeatherPalette(
    primary: Color(0xFF90A4AE),
    secondary: Color(0xFFFFCC80),
    background: Color(0xFFECEFF1),
    onPrimary: Color(0xFF37474F),
  );

  static const overcast = WeatherPalette(
    primary: Color(0xFF78909C),
    secondary: Color(0xFFB0BEC5),
    background: Color(0xFFCFD8DC),
    onPrimary: Color(0xFF263238),
  );

  static const fog = WeatherPalette(
    primary: Color(0xFFB0BEC5),
    secondary: Color(0xFFCFD8DC),
    background: Color(0xFFECEFF1),
    onPrimary: Color(0xFF546E7A),
  );

  static const rimeFog = WeatherPalette(
    primary: Color(0xFFCFD8DC),
    secondary: Color(0xFFE0F7FA),
    background: Color(0xFFF5F5F5),
    onPrimary: Color(0xFF607D8B),
  );

  static const drizzleLight = WeatherPalette(
    primary: Color(0xFF81D4FA),
    secondary: Color(0xFFB3E5FC),
    background: Color(0xFFE1F5FE),
    onPrimary: Color(0xFF0277BD),
  );

  static const drizzleModerate = WeatherPalette(
    primary: Color(0xFF4FC3F7),
    secondary: Color(0xFF81D4FA),
    background: Color(0xFFB3E5FC),
    onPrimary: Color(0xFF01579B),
  );

  static const drizzleDense = WeatherPalette(
    primary: Color(0xFF29B6F6),
    secondary: Color(0xFF4FC3F7),
    background: Color(0xFF81D4FA),
    onPrimary: Color(0xFF01579B),
  );

  static const freezingDrizzleLight = WeatherPalette(
    primary: Color(0xFFB2EBF2),
    secondary: Color(0xFFE0F7FA),
    background: Color(0xFFF0FDFF),
    onPrimary: Color(0xFF006064),
  );

  static const freezingDrizzleDense = WeatherPalette(
    primary: Color(0xFF80DEEA),
    secondary: Color(0xFFB2EBF2),
    background: Color(0xFFE0F7FA),
    onPrimary: Color(0xFF00838F),
  );

  static const rainSlight = WeatherPalette(
    primary: Color(0xFF42A5F5),
    secondary: Color(0xFF90CAF9),
    background: Color(0xFFBBDEFB),
    onPrimary: Color(0xFF0D47A1),
  );

  static const rainModerate = WeatherPalette(
    primary: Color(0xFF1E88E5),
    secondary: Color(0xFF42A5F5),
    background: Color(0xFF90CAF9),
    onPrimary: Color(0xFFFFFFFF),
  );

  static const rainHeavy = WeatherPalette(
    primary: Color(0xFF1565C0),
    secondary: Color(0xFF1E88E5),
    background: Color(0xFF42A5F5),
    onPrimary: Color(0xFFFFFFFF),
  );

  static const freezingRainLight = WeatherPalette(
    primary: Color(0xFF80CBC4),
    secondary: Color(0xFFB2DFDB),
    background: Color(0xFFE0F2F1),
    onPrimary: Color(0xFF004D40),
  );

  static const freezingRainHeavy = WeatherPalette(
    primary: Color(0xFF26A69A),
    secondary: Color(0xFF80CBC4),
    background: Color(0xFFB2DFDB),
    onPrimary: Color(0xFFFFFFFF),
  );

  static const snowSlight = WeatherPalette(
    primary: Color(0xFFE3F2FD),
    secondary: Color(0xFFBBDEFB),
    background: Color(0xFFF8FBFF),
    onPrimary: Color(0xFF1565C0),
  );

  static const snowModerate = WeatherPalette(
    primary: Color(0xFFBBDEFB),
    secondary: Color(0xFF90CAF9),
    background: Color(0xFFE3F2FD),
    onPrimary: Color(0xFF0D47A1),
  );

  static const snowHeavy = WeatherPalette(
    primary: Color(0xFF90CAF9),
    secondary: Color(0xFF64B5F6),
    background: Color(0xFFBBDEFB),
    onPrimary: Color(0xFF0D47A1),
  );

  static const snowGrains = WeatherPalette(
    primary: Color(0xFFCFD8DC),
    secondary: Color(0xFFECEFF1),
    background: Color(0xFFF5F5F5),
    onPrimary: Color(0xFF455A64),
  );

  static const rainShowersSlight = WeatherPalette(
    primary: Color(0xFF26C6DA),
    secondary: Color(0xFF80DEEA),
    background: Color(0xFFE0F7FA),
    onPrimary: Color(0xFF006064),
  );

  static const rainShowersModerate = WeatherPalette(
    primary: Color(0xFF00ACC1),
    secondary: Color(0xFF26C6DA),
    background: Color(0xFFB2EBF2),
    onPrimary: Color(0xFFFFFFFF),
  );

  static const rainShowersViolent = WeatherPalette(
    primary: Color(0xFF00838F),
    secondary: Color(0xFF00ACC1),
    background: Color(0xFF80DEEA),
    onPrimary: Color(0xFFFFFFFF),
  );

  static const snowShowersSlight = WeatherPalette(
    primary: Color(0xFFB3E5FC),
    secondary: Color(0xFFE1F5FE),
    background: Color(0xFFF0F9FF),
    onPrimary: Color(0xFF01579B),
  );

  static const snowShowersHeavy = WeatherPalette(
    primary: Color(0xFF81D4FA),
    secondary: Color(0xFFB3E5FC),
    background: Color(0xFFE1F5FE),
    onPrimary: Color(0xFF01579B),
  );

  static const thunderstorm = WeatherPalette(
    primary: Color(0xFF5C6BC0),
    secondary: Color(0xFFFFD54F),
    background: Color(0xFF303F9F),
    onPrimary: Color(0xFFFFFFFF),
  );

  static const thunderstormHailSlight = WeatherPalette(
    primary: Color(0xFF7E57C2),
    secondary: Color(0xFFFFCC02),
    background: Color(0xFF4527A0),
    onPrimary: Color(0xFFFFFFFF),
  );

  static const thunderstormHailHeavy = WeatherPalette(
    primary: Color(0xFF4A148C),
    secondary: Color(0xFFFFD600),
    background: Color(0xFF311B92),
    onPrimary: Color(0xFFFFFFFF),
  );
}

class WeatherPalette {
  final Color primary;

  final Color secondary;

  final Color background;

  final Color onPrimary;

  const WeatherPalette({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.onPrimary,
  });

  LinearGradient get gradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, primary],
  );

  ColorScheme toColorScheme({Brightness brightness = Brightness.light}) {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onPrimary,
      surface: background,
      onSurface: onPrimary,
      error: AppStatusColors.error,
      onError: Colors.white,
    );
  }
}

abstract class AppStatusColors {
  static const warning = Color(0xFFFFA726);
  static const warningLight = Color(0xFFFFCC80);
  static const warningDark = Color(0xFFE65100);
  static const onWarning = Color(0xFF4A2500);

  static const success = Color(0xFF66BB6A);
  static const successLight = Color(0xFFC8E6C9);
  static const successDark = Color(0xFF2E7D32);
  static const onSuccess = Color(0xFFFFFFFF);

  static const error = Color(0xFFEF5350);
  static const errorLight = Color(0xFFFFCDD2);
  static const errorDark = Color(0xFFB71C1C);
  static const onError = Color(0xFFFFFFFF);

  static const info = Color(0xFF29B6F6);
  static const infoLight = Color(0xFFB3E5FC);
  static const infoDark = Color(0xFF0277BD);
  static const onInfo = Color(0xFFFFFFFF);
}
