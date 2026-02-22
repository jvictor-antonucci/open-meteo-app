import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';

class PropertyCard extends StatelessWidget {
  final String label;
  final String formattedValue;
  final String description;
  final WeatherStatus weatherStatus;

  const PropertyCard({
    super.key,
    required this.label,
    required this.formattedValue,
    required this.description,
    required this.weatherStatus,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Container(
      width: size.width * .45,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 6,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: colors.primaryContainer,
                  child: Icon(
                    weatherStatus.icon,
                    color: colors.primary,
                    size: 16,
                  ),
                ),
                Text(
                  label,
                  style: textStyles.titleSmall?.apply(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              formattedValue,
              style: textStyles.headlineLarge?.apply(color: colors.onSurface),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: textStyles.bodySmall?.apply(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
