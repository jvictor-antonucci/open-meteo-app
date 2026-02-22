import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';
import 'package:open_meteo_app/core/shared/widgets/location_card_tile.dart';
import 'package:open_meteo_app/modules/saved/presentation/widgets/saved_locations_app_bar.dart';

class SavedLocationsPage extends StatefulWidget {
  const SavedLocationsPage({super.key});

  @override
  State<SavedLocationsPage> createState() => _SavedLocationsPageState();
}

class _SavedLocationsPageState extends State<SavedLocationsPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SavedLocationsAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            sliver: SliverSafeArea(
              top: false,
              sliver: SliverList.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 8),
                        Row(
                          spacing: 6,
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: colors.primary.withAlpha(50),
                              child: Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: colors.primary,
                              ),
                            ),
                            Text(
                              'CURRENT LOCATION',
                              style: textStyles.labelSmall?.apply(
                                color: colors.primary,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: LocationCardTile(
                            country: 'United States',
                            city: 'San Francisco',
                            isSaved: false,
                            temperature: 18,
                            weatherStatus: WeatherStatus.clearSky,
                            coordinates: Coordinate(lat: 21, long: 14),
                          ),
                        ),
                      ],
                    );
                  }
                  if (index == 1) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'FAVORITES (4)',
                          style: textStyles.labelSmall?.apply(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: LocationCardTile(
                            country: 'United States',
                            city: 'San Francisco',
                            isSaved: false,
                            temperature: 18,
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
                      isSaved: false,
                      temperature: 18,
                      weatherStatus: WeatherStatus.drizzleDense,
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
