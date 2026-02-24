import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:open_meteo_app/core/route/routes.dart';
import 'package:open_meteo_app/core/shared/widgets/location_card_tile.dart';
import 'package:open_meteo_app/modules/saved/presentation/controllers/saved_locations_bloc.dart';
import 'package:open_meteo_app/modules/search/presentation/controllers/search_locations_bloc.dart';
import 'package:open_meteo_app/modules/search/presentation/widgets/search_app_bar.dart';

class SearchLocationsPage extends StatefulWidget {
  const SearchLocationsPage({super.key});

  @override
  State<SearchLocationsPage> createState() => _SearchLocationsPageState();
}

class _SearchLocationsPageState extends State<SearchLocationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SearchLocationsBloc>().add(SearchLocationStarted());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SearchAppBar(),
          BlocBuilder<SearchLocationsBloc, SearchLocationsState>(
            builder: (context, state) {
              switch (state.status) {
                case SearchLocationStatus.empty:
                  return SliverFillRemaining(
                    child: Center(
                      child: Icon(
                        LucideIcons.map,
                        size: 124,
                        color: colors.outline,
                      ),
                    ),
                  );
                case SearchLocationStatus.searching:
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                case SearchLocationStatus.success:
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    sliver: SliverSafeArea(
                      top: false,
                      sliver: SliverList.builder(
                        itemCount: state.searchResult.length,
                        itemBuilder: (context, index) {
                          final location = state.searchResult[index];

                          if (index == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 24),
                                Text(
                                  '${state.searchResult.length} locations found',
                                  style: textStyles.labelMedium?.apply(
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: LocationCardTile(
                                    country: location.country,
                                    city: location.name,
                                    formattedTemp: location.temperature.format,
                                    isSaved: location.isSaved,
                                    weatherStatus: location.weatherStatus,
                                    coordinates: location.coordinate,
                                    onTapCard: () =>
                                        SearchLocationDetailsRouteData(
                                          location,
                                        ).push(context),
                                    onTapSave: () {
                                      context.read<SearchLocationsBloc>().add(
                                        SearchLocationResultSaved(
                                          location: location,
                                        ),
                                      );
                                      context.read<SavedLocationsBloc>().add(
                                        SavedLocationsUpdatedItem(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: LocationCardTile(
                              country: location.country,
                              city: location.name,
                              formattedTemp: location.temperature.format,
                              isSaved: location.isSaved,
                              weatherStatus: location.weatherStatus,
                              coordinates: location.coordinate,
                              onTapCard: () => SearchLocationDetailsRouteData(
                                location,
                              ).push(context),
                              onTapSave: () {
                                context.read<SearchLocationsBloc>().add(
                                  SearchLocationResultSaved(location: location),
                                );
                                context.read<SavedLocationsBloc>().add(
                                  SavedLocationsUpdatedItem(),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
