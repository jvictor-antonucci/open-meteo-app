import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/forecast/forecast_item.dart';

class Forecast extends StatelessWidget {
  const Forecast({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            '10-Day Forecast',
            style: textStyles.headlineMedium?.apply(color: colors.onSurface),
          ),
          ...List.generate(
            10,
            (index) => ForecastItem(
              formattedDate: 'Now',
              chanceOfRaining: '10',
              maxTemperature: 10,
              minTemperature: 20,
              globalMaxTemperature: 7,
              globalMinTemperature: 27,
              weatherStatus: WeatherStatus.clearSky,
            ),
          ),
        ],
      ),
    );
  }
}
