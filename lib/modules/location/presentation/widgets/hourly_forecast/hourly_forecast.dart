import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/hourly_forecast/hourly_forecast_item.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourlyForecastItemDetails> items;
  final int currentIndex;
  final Function(int index) onTap;

  const HourlyForecast({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Hourly Forecast',
                style: textStyles.headlineMedium?.apply(
                  color: colors.onSurface,
                ),
              ),
              Text(
                'Next 12 hours',
                style: textStyles.titleSmall?.apply(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 160,
            child: ListView(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              children: List.generate(items.length, (index) {
                final isSelected = currentIndex == index;
                final item = items[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: HourlyForecastItem(
                    formattedDateTime: item.formattedDateTime,
                    temperature: item.temperature,
                    chanceOfRaining: item.chanceOfRaining,
                    isSelected: isSelected,
                    weatherStatus: item.weatherStatus,
                    onTap: () => onTap.call(index),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class HourlyForecastItemDetails {
  final String formattedDateTime;
  final WeatherStatus weatherStatus;
  final String temperature;
  final String chanceOfRaining;

  HourlyForecastItemDetails({
    required this.temperature,
    required this.chanceOfRaining,
    required this.formattedDateTime,
    required this.weatherStatus,
  });
}
