import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/forecast/temperature_range_bar.dart';

class ForecastItem extends StatelessWidget {
  final String formattedDate;
  final WeatherStatus weatherStatus;
  final String chanceOfRaining;
  final double maxTemperature;
  final double minTemperature;
  final double globalMaxTemperature;
  final double globalMinTemperature;

  const ForecastItem({
    super.key,
    required this.formattedDate,
    required this.weatherStatus,
    required this.chanceOfRaining,
    required this.maxTemperature,
    required this.minTemperature,
    required this.globalMaxTemperature,
    required this.globalMinTemperature,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                formattedDate,
                style: textStyles.labelMedium?.apply(color: colors.onSurface),
              ),
              Icon(weatherStatus.icon, color: colors.primary),
              Text(
                chanceOfRaining,
                style: textStyles.labelSmall?.apply(color: colors.primary),
              ),
              Expanded(
                child: TemperatureRangeBar(
                  globalMin: globalMinTemperature,
                  globalMax: globalMaxTemperature,
                  dayMin: minTemperature,
                  dayMax: maxTemperature,
                ),
              ),
              Text(
                minTemperature.toString(),
                style: textStyles.bodyMedium?.apply(
                  color: colors.onSurfaceVariant,
                ),
              ),
              Text(
                maxTemperature.toString(),
                style: textStyles.bodyMedium?.apply(color: colors.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
