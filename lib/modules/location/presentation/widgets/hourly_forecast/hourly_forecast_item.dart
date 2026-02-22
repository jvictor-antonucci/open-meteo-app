import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';

class HourlyForecastItem extends StatelessWidget {
  final String formattedDateTime;
  final WeatherStatus weatherStatus;
  final String temperature;
  final String chanceOfRaining;
  final bool isSelected;
  final VoidCallback onTap;

  const HourlyForecastItem({
    super.key,
    required this.formattedDateTime,
    required this.weatherStatus,
    required this.temperature,
    required this.chanceOfRaining,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: isSelected
              ? colors.tertiaryContainer
              : colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 6,
            children: [
              Text(
                formattedDateTime,
                style: textStyles.labelMedium?.apply(color: colors.onSurface),
              ),
              Icon(
                Icons.sunny,
                color: isSelected ? colors.primary : colors.onSurfaceVariant,
                size: 32,
              ),
              Text(
                temperature,
                style: textStyles.headlineLarge?.apply(color: colors.onSurface),
              ),
              Text(
                chanceOfRaining,
                style: textStyles.labelLarge?.apply(color: colors.tertiary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
