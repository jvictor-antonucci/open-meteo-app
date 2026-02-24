import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/forecast/forecast_item.dart';

class Forecast extends StatelessWidget {
  final List<ForecastItemData> items;

  const Forecast({super.key, required this.items});

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
          ...List.from(
            items.map((item) {
              return ForecastItem(
                formattedDate: DateFormat('E').format(item.date),
                chanceOfRaining: item.formattedPrecipitationChance,
                maxTemperature: item.maxTemperature,
                minTemperature: item.minTemperature,
                globalMaxTemperature: item.globalMaxTemp,
                globalMinTemperature: item.globalMinTemp,
                weatherStatus: item.weatherStatus,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ForecastItemData {
  final DateTime date;
  final String formattedPrecipitationChance;
  final double maxTemperature;
  final double minTemperature;
  final double globalMaxTemp;
  final double globalMinTemp;
  final WeatherStatus weatherStatus;

  const ForecastItemData({
    required this.date,
    required this.formattedPrecipitationChance,
    required this.maxTemperature,
    required this.minTemperature,
    required this.globalMaxTemp,
    required this.globalMinTemp,
    required this.weatherStatus,
  });
}
