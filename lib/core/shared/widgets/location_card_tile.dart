import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';
import 'package:open_meteo_app/core/theme/open_meteo_app_color_theme.dart';

class LocationCardTile extends StatelessWidget {
  final String country;
  final String city;
  final int temperature;
  final WeatherStatus weatherStatus;
  final Coordinate coordinates;
  final bool isSaved;

  const LocationCardTile({
    super.key,
    required this.country,
    required this.city,
    required this.temperature,
    required this.isSaved,
    required this.weatherStatus,
    required this.coordinates,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final textStyle = theme.textTheme;

    return Theme(
      data: theme.copyWith(
        colorScheme: WeatherColors.fromWMOCode(
          weatherStatus.code,
        ).toColorScheme(),
      ),
      child: Builder(
        builder: (context) {
          final colors = Theme.of(context).colorScheme;
          return AnimatedContainer(
            duration: kThemeAnimationDuration,
            decoration: BoxDecoration(
              gradient: WeatherColors.fromWMOCode(
                weatherStatus.code,
              ).listCardGradient,
              borderRadius: BorderRadius.circular(22),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          country,
                          style: textStyle.titleSmall?.apply(
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          city,
                          style: textStyle.headlineLarge?.apply(
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 18,
                      child: Icon(
                        isSaved ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      temperature.toString(),
                      style: textStyle.displayLarge?.apply(
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                    Icon(
                      weatherStatus.icon,
                      color: colors.onPrimaryContainer,
                      size: 48,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.surface.withAlpha(100),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Text(
                          weatherStatus.label,
                          style: textStyle.labelLarge?.apply(
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      coordinates.format,
                      style: textStyle.bodySmall?.apply(
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
