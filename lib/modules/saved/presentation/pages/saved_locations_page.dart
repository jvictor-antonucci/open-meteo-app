import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_meteo_app/core/route/routes.dart';
import 'package:open_meteo_app/core/shared/widgets/location_card_tile.dart';
import 'package:open_meteo_app/modules/saved/presentation/controllers/saved_locations_bloc.dart';
import 'package:open_meteo_app/modules/saved/presentation/widgets/current_location_section.dart';
import 'package:open_meteo_app/modules/saved/presentation/widgets/saved_locations_app_bar.dart';

class SavedLocationsPage extends StatefulWidget {
  const SavedLocationsPage({super.key});

  @override
  State<SavedLocationsPage> createState() => _SavedLocationsPageState();
}

class _SavedLocationsPageState extends State<SavedLocationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SavedLocationsBloc>().add(SavedLocationsStarted());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Scaffold(
      body: BlocBuilder<SavedLocationsBloc, SavedLocationsState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: state.status == SavedLocationsStatus.loading
                ? [
                    SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ]
                : [
                    SavedLocationsAppBar(),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      sliver: SliverSafeArea(
                        top: false,
                        sliver: SliverList.list(
                          children: [
                            if (state.currentLocation != null)
                              CurrentLocationSection(
                                location: state.currentLocation!,
                              ),

                            SizedBox(height: 20),
                            Text(
                              'FAVORITES (${state.savedLocations.length})',
                              style: textStyles.labelSmall?.apply(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            ...List<Widget>.generate(
                              state.savedLocations.length,
                              (index) {
                                final location = state.savedLocations[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: LocationCardTile(
                                    country: location.country,
                                    city: location.name,
                                    isSaved: true,
                                    formattedTemp: location.temperature.format,
                                    weatherStatus: location.weatherStatus,
                                    coordinates: location.coordinate,
                                    onTapCard: () =>
                                        SavedLocationDetailsRouteData(
                                          location,
                                        ).push(context),
                                    onTapSave: () =>
                                        context.read<SavedLocationsBloc>().add(
                                          SavedLocationsUpdatedItem(
                                            location: location,
                                          ),
                                        ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
          );
        },
      ),
    );
  }
}
