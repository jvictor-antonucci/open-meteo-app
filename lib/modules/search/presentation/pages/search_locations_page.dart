import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';
import 'package:open_meteo_app/core/shared/widgets/location_card_tile.dart';
import 'package:open_meteo_app/modules/search/presentation/widgets/search_app_bar.dart';

class SearchLocationsPage extends StatelessWidget {
  const SearchLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SearchAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            sliver: SliverSafeArea(
              top: false,
              sliver: SliverList.builder(
                itemCount: 16,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24),
                        Text(
                          '16 locations found',
                          style: textStyles.labelMedium?.apply(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: LocationCardTile(
                            country: 'United States',
                            city: 'San Francisco',
                            temperature: 18,
                            isSaved: false,
                            weatherStatus: WeatherStatus.drizzleDense,
                            coordinates: Coordinate(lat: 21, long: 14),
                          ),
                        ),
                      ],
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: LocationCardTile(
                      country: 'United States',
                      city: 'San Francisco',
                      temperature: 18,
                      isSaved: false,
                      weatherStatus: WeatherStatus.rainHeavy,
                      coordinates: Coordinate(lat: 21, long: 14),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
