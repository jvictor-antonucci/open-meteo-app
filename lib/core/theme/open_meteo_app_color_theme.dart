import 'package:flutter/material.dart';

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

  static const navBackground = Color(0xFF2A2D35);
  static const navPillBackground = Color(0xFF3A3D47);
  static const navSelectedItem = Color(0xFFFFFFFF);
  static const navUnselectedItem = Color(0xFF6B7280);
  static const navShadow = Color(0x33000000);
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

  LinearGradient get cardGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, primary],
  );

  LinearGradient get listCardGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [background, Color.lerp(background, primary, 0.15)!],
  );

  Color get _accent => Color.lerp(primary, const Color(0xFF4A90D9), 0.4)!;

  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,

      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: background,
      onPrimaryContainer: const Color(0xFF1A1A2E),

      secondary: secondary,
      onSecondary: Colors.white,
      secondaryContainer: AppNavBarColors.pillBackground,
      onSecondaryContainer: AppNavBarColors.selectedItem,

      tertiary: _accent,
      onTertiary: Colors.white,
      tertiaryContainer: _accent.withOpacity(0.15),
      onTertiaryContainer: _accent,

      surface: Colors.white,
      onSurface: const Color(0xFF0D0D0D),

      surfaceContainerLow: const Color(0xFFF2F2F7),

      surfaceContainer: AppNavBarColors.background,

      surfaceContainerHigh: const Color(0xFFEAEAEF),

      surfaceContainerHighest: Colors.white,

      onSurfaceVariant: const Color(0xFF9E9E9E),

      outline: const Color(0xFFDDDDDD),
      outlineVariant: const Color(0xFFEEEEEE),

      error: AppStatusColors.error,
      onError: Colors.white,
      errorContainer: AppStatusColors.errorLight,
      onErrorContainer: AppStatusColors.errorDark,

      scrim: Colors.black54,
      inverseSurface: const Color(0xFF1C1F26),
      onInverseSurface: Colors.white,
      inversePrimary: background,
    );
  }
}

const Color _darkOnPrimary = Color(0xFF1A1A2E);

abstract class WeatherColors {
  static const clearSky = WeatherPalette(
    primary: Color(0xFF5B9EC9),
    secondary: Color(0xFF7BBDE0),
    background: Color(0xFFD6EAF5),
    onPrimary: _darkOnPrimary,
  );

  static const mainlyClear = WeatherPalette(
    primary: Color(0xFF5294BE),
    secondary: Color(0xFF70AFD6),
    background: Color(0xFFCDE4F2),
    onPrimary: _darkOnPrimary,
  );

  static const partlyCloudy = WeatherPalette(
    primary: Color(0xFF7A8FA0),
    secondary: Color(0xFF96A8B8),
    background: Color(0xFFD8E2EA),
    onPrimary: _darkOnPrimary,
  );

  static const overcast = WeatherPalette(
    primary: Color(0xFF6A7D8C),
    secondary: Color(0xFF84949E),
    background: Color(0xFFCDD6DE),
    onPrimary: Colors.white,
  );

  static const fog = WeatherPalette(
    primary: Color(0xFF8E9490),
    secondary: Color(0xFFA6ABAA),
    background: Color(0xFFDDDFDE),
    onPrimary: _darkOnPrimary,
  );

  static const rimeFog = WeatherPalette(
    primary: Color(0xFF9BA4A8),
    secondary: Color(0xFFB4BCBE),
    background: Color(0xFFE4E8EA),
    onPrimary: _darkOnPrimary,
  );

  static const drizzleLight = WeatherPalette(
    primary: Color(0xFF5580A0),
    secondary: Color(0xFF6E98B8),
    background: Color(0xFFC2D6E6),
    onPrimary: Colors.white,
  );

  static const drizzleModerate = WeatherPalette(
    primary: Color(0xFF486E8C),
    secondary: Color(0xFF5E84A2),
    background: Color(0xFFB8CEDF),
    onPrimary: Colors.white,
  );

  static const drizzleDense = WeatherPalette(
    primary: Color(0xFF3C5E7C),
    secondary: Color(0xFF507290),
    background: Color(0xFFAEC6D8),
    onPrimary: Colors.white,
  );

  static const freezingDrizzleLight = WeatherPalette(
    primary: Color(0xFF5A9090),
    secondary: Color(0xFF74AAAA),
    background: Color(0xFFC4DCDC),
    onPrimary: Colors.white,
  );

  static const freezingDrizzleDense = WeatherPalette(
    primary: Color(0xFF4C7E80),
    secondary: Color(0xFF609496),
    background: Color(0xFFB8D2D4),
    onPrimary: Colors.white,
  );

  static const rainSlight = WeatherPalette(
    primary: Color(0xFF44647E),
    secondary: Color(0xFF587894),
    background: Color(0xFFB2C4D4),
    onPrimary: Colors.white,
  );

  static const rainModerate = WeatherPalette(
    primary: Color(0xFF365468),
    secondary: Color(0xFF486678),
    background: Color(0xFFA4B8C8),
    onPrimary: Colors.white,
  );

  static const rainHeavy = WeatherPalette(
    primary: Color(0xFF284454),
    secondary: Color(0xFF385664),
    background: Color(0xFF96AABB),
    onPrimary: Colors.white,
  );

  static const freezingRainLight = WeatherPalette(
    primary: Color(0xFF3E6870),
    secondary: Color(0xFF527C84),
    background: Color(0xFFB0CCCE),
    onPrimary: Colors.white,
  );

  static const freezingRainHeavy = WeatherPalette(
    primary: Color(0xFF30565C),
    secondary: Color(0xFF426870),
    background: Color(0xFFA2BCBF),
    onPrimary: Colors.white,
  );

  static const snowSlight = WeatherPalette(
    primary: Color(0xFF96A0A8),
    secondary: Color(0xFFAEB8BE),
    background: Color(0xFFE0E4E8),
    onPrimary: _darkOnPrimary,
  );

  static const snowModerate = WeatherPalette(
    primary: Color(0xFF848E96),
    secondary: Color(0xFF9CA6AC),
    background: Color(0xFFD8DCE0),
    onPrimary: _darkOnPrimary,
  );

  static const snowHeavy = WeatherPalette(
    primary: Color(0xFF727C84),
    secondary: Color(0xFF8A9298),
    background: Color(0xFFD0D4D8),
    onPrimary: Colors.white,
  );

  static const snowGrains = WeatherPalette(
    primary: Color(0xFFA2ACB2),
    secondary: Color(0xFFBAC2C8),
    background: Color(0xFFE6EAEC),
    onPrimary: _darkOnPrimary,
  );

  static const rainShowersSlight = WeatherPalette(
    primary: Color(0xFF3A5E80),
    secondary: Color(0xFF4E7296),
    background: Color(0xFFA8BECE),
    onPrimary: Colors.white,
  );

  static const rainShowersModerate = WeatherPalette(
    primary: Color(0xFF2E4E6E),
    secondary: Color(0xFF3E6082),
    background: Color(0xFF9AB0C4),
    onPrimary: Colors.white,
  );

  static const rainShowersViolent = WeatherPalette(
    primary: Color(0xFF20384E),
    secondary: Color(0xFF2C4A62),
    background: Color(0xFF8AA0B4),
    onPrimary: Colors.white,
  );

  static const snowShowersSlight = WeatherPalette(
    primary: Color(0xFF8090A0),
    secondary: Color(0xFF98A8B6),
    background: Color(0xFFD4DAE0),
    onPrimary: _darkOnPrimary,
  );

  static const snowShowersHeavy = WeatherPalette(
    primary: Color(0xFF6E7E8E),
    secondary: Color(0xFF8494A2),
    background: Color(0xFFC8D0D8),
    onPrimary: Colors.white,
  );

  static const thunderstorm = WeatherPalette(
    primary: Color(0xFF4A3E6E),
    secondary: Color(0xFF5E5082),
    background: Color(0xFFB8B0CC),
    onPrimary: Colors.white,
  );

  static const thunderstormHailSlight = WeatherPalette(
    primary: Color(0xFF342848),
    secondary: Color(0xFF463858),
    background: Color(0xFFA49EB8),
    onPrimary: Colors.white,
  );

  static const thunderstormHailHeavy = WeatherPalette(
    primary: Color(0xFF221830),
    secondary: Color(0xFF302240),
    background: Color(0xFF948EA8),
    onPrimary: Colors.white,
  );

  static WeatherPalette fromWMOCode(int code) {
    return switch (code) {
      0 => clearSky,
      1 => mainlyClear,
      2 => partlyCloudy,
      3 => overcast,
      45 => fog,
      48 => rimeFog,
      51 => drizzleLight,
      53 => drizzleModerate,
      55 => drizzleDense,
      56 => freezingDrizzleLight,
      57 => freezingDrizzleDense,
      61 => rainSlight,
      63 => rainModerate,
      65 => rainHeavy,
      66 => freezingRainLight,
      67 => freezingRainHeavy,
      71 => snowSlight,
      73 => snowModerate,
      75 => snowHeavy,
      77 => snowGrains,
      80 => rainShowersSlight,
      81 => rainShowersModerate,
      82 => rainShowersViolent,
      85 => snowShowersSlight,
      86 => snowShowersHeavy,
      95 => thunderstorm,
      96 => thunderstormHailSlight,
      99 => thunderstormHailHeavy,
      _ => partlyCloudy,
    };
  }
}

abstract class AppNavBarColors {
  static const background = Color(0xFF2A2D35);
  static const pillBackground = Color(0xFF3A3D47);
  static const selectedItem = Color(0xFFFFFFFF);
  static const unselectedItem = Color(0xFF959AA4);
  static const shadow = Color(0x33000000);
}
