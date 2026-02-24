import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:open_meteo_app/core/theme/open_meteo_app_color_theme.dart';

enum WeatherStatus {
  clearSky(0, 'Clear Sky', LucideIcons.sun),
  mainlyClear(1, 'Mainly Clear', LucideIcons.cloudSun),
  partlyCloudy(2, 'Partly Cloudy', LucideIcons.cloudSun),
  overcast(3, 'Overcast', LucideIcons.cloud),
  fog(45, 'Fog', LucideIcons.cloudFog),
  rimeFog(48, 'Rime Fog', LucideIcons.cloudFog),
  drizzleLight(51, 'Light Drizzle', LucideIcons.cloudDrizzle),
  drizzleModerate(53, 'Moderate Drizzle', LucideIcons.cloudDrizzle),
  drizzleDense(55, 'Dense Drizzle', LucideIcons.cloudDrizzle),
  freezingDrizzleLight(56, 'Light Freezing Drizzle', LucideIcons.cloudHail),
  freezingDrizzleDense(57, 'Dense Freezing Drizzle', LucideIcons.cloudHail),
  rainSlight(61, 'Slight Rain', LucideIcons.cloudRain),
  rainModerate(63, 'Moderate Rain', LucideIcons.cloudRain),
  rainHeavy(65, 'Heavy Rain', LucideIcons.cloudRain),
  freezingRainLight(66, 'Light Freezing Rain', LucideIcons.cloudHail),
  freezingRainHeavy(67, 'Heavy Freezing Rain', LucideIcons.cloudHail),
  snowSlight(71, 'Slight Snow', LucideIcons.cloudSnow),
  snowModerate(73, 'Moderate Snow', LucideIcons.cloudSnow),
  snowHeavy(75, 'Heavy Snow', LucideIcons.cloudSnow),
  snowGrains(77, 'Snow Grains', LucideIcons.snowflake),
  rainShowersSlight(80, 'Slight Rain Showers', LucideIcons.cloudRain),
  rainShowersModerate(81, 'Moderate Rain Showers', LucideIcons.cloudRainWind),
  rainShowersViolent(82, 'Violent Rain Showers', LucideIcons.cloudRainWind),
  snowShowersSlight(85, 'Slight Snow Showers', LucideIcons.cloudSnow),
  snowShowersHeavy(86, 'Heavy Snow Showers', LucideIcons.cloudSnow),
  thunderstorm(95, 'Thunderstorm', LucideIcons.cloudLightning),
  thunderstormHailSlight(
    96,
    'Thunderstorm with Slight Hail',
    LucideIcons.cloudHail,
  ),
  thunderstormHailHeavy(
    99,
    'Thunderstorm with Heavy Hail',
    LucideIcons.cloudHail,
  );

  const WeatherStatus(this.code, this.label, this.icon);

  final int code;
  final String label;
  final IconData icon;

  static WeatherStatus fromCode(int code) {
    return WeatherStatus.values.firstWhere(
      (e) => e.code == code,
      orElse: () => WeatherStatus.partlyCloudy,
    );
  }

  WeatherPalette get palette => WeatherColors.fromWMOCode(code);

  bool get isClear => code <= 1;
  bool get isCloudy => code == 2 || code == 3;
  bool get isFoggy => code == 45 || code == 48;
  bool get isDrizzle => code >= 51 && code <= 57;
  bool get isRain => code >= 61 && code <= 67;
  bool get isSnow => code >= 71 && code <= 77;
  bool get isShowers => code >= 80 && code <= 86;
  bool get isThunderstorm => code >= 95;
  bool get isFreezing => code == 56 || code == 57 || code == 66 || code == 67;
  bool get isSevere => code == 82 || code >= 95;
}
