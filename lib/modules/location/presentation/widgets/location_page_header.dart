import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';

class LocationPageHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double pageHeight;
  final WeatherStatus weatherStatus;
  final Coordinate coordinate;
  final String city;
  final String country;
  final DateTime date;
  final String formattedApparentTemperature;
  final String formattedTemperature;

  const LocationPageHeaderDelegate({
    required this.pageHeight,
    required this.weatherStatus,
    required this.coordinate,
    required this.city,
    required this.country,
    required this.date,
    required this.formattedApparentTemperature,
    required this.formattedTemperature,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final containerHeight = (maxExtent - shrinkOffset).clamp(
      minExtent,
      maxExtent,
    );
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      height: containerHeight,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (context.canPop())
            Positioned(
              top: topPadding + 12,
              left: 24,
              child: GestureDetector(
                onTap: () => context.pop(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    LucideIcons.chevronLeft600,
                    color: colors.primary,
                  ),
                ),
              ),
            ),

          if (!context.canPop())
            Positioned(
              top: topPadding + 12,
              left: 24,
              right: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 6,
                    children: [
                      CircleAvatar(
                        backgroundColor: colors.primaryContainer,
                        radius: 10,
                        child: Icon(
                          LucideIcons.mapPin,
                          size: 12,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (city.isNotEmpty)
                              ? '$city${country.isNotEmpty ? ' $country' : ''}'
                              : 'Current Position',
                          style: textStyles.bodyMedium?.apply(
                            color: colors.onPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    DateFormat('EEEE, MMMM d').format(date),
                    style: textStyles.bodySmall?.apply(color: colors.onPrimary),
                  ),
                ],
              ),
            ),

          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Opacity(
              opacity: (1.0 - progress * 2).clamp(0.0, 1.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      if (context.canPop())
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 6,
                          children: [
                            CircleAvatar(
                              backgroundColor: colors.primaryContainer,
                              radius: 10,
                              child: Icon(
                                LucideIcons.mapPin,
                                size: 14,
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                            Text(
                              (city.isNotEmpty)
                                  ? '$city${country.isNotEmpty ? ' $country' : ''}'
                                  : 'Current Position',
                              style: textStyles.bodyMedium?.apply(
                                color: colors.onPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      Text(
                        formattedTemperature,
                        style: textStyles.displayLarge?.apply(
                          color: colors.onPrimary,
                        ),
                      ),
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
                            style: textStyles.labelMedium?.apply(
                              color: colors.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${coordinate.format} • Feels $formattedApparentTemperature',
                        style: textStyles.labelLarge?.apply(
                          color: colors.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  Icon(weatherStatus.icon, color: colors.onPrimary, size: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => pageHeight * .4;

  @override
  double get minExtent => pageHeight * .15;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return this != oldDelegate;
  }
}
