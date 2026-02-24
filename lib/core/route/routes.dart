import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/services/geolocator_client.dart';
import 'package:open_meteo_app/core/services/hive_client.dart';
import 'package:open_meteo_app/core/services/location_api_client.dart';
import 'package:open_meteo_app/core/utils/result.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/controllers/bottom_navigation_cubit.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/pages/bottom_navigation_page.dart';
import 'package:open_meteo_app/modules/location/data/repositories/location_repository.dart';
import 'package:open_meteo_app/modules/location/presentation/controllers/location_details_bloc.dart';
import 'package:open_meteo_app/modules/location/presentation/pages/location_page.dart';
import 'package:open_meteo_app/modules/saved/data/repositories/saved_locations_repository.dart';
import 'package:open_meteo_app/modules/saved/presentation/controllers/saved_locations_bloc.dart';
import 'package:open_meteo_app/modules/saved/presentation/pages/saved_locations_page.dart';
import 'package:open_meteo_app/modules/search/data/repositories/search_locations_repository.dart';
import 'package:open_meteo_app/modules/search/presentation/controllers/search_locations_bloc.dart';
import 'package:open_meteo_app/modules/search/presentation/pages/search_locations_page.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<BottomNavigationRouteData>(
  branches: [
    TypedStatefulShellBranch<HomePageBranchData>(
      routes: [TypedGoRoute<HomePageRouteData>(name: 'home', path: '/')],
    ),
    TypedStatefulShellBranch<SavedLocationsPageBranchData>(
      routes: [
        TypedGoRoute<SavedLocationsPageRouteData>(
          name: 'savedLocations',
          path: '/saved',
        ),
      ],
    ),
    TypedStatefulShellBranch<SearchPageBranchData>(
      routes: [
        TypedGoRoute<SearchPageRouteData>(
          name: 'searchLocations',
          path: '/search',
        ),
      ],
    ),
  ],
)
class BottomNavigationRouteData extends StatefulShellRouteData {
  const BottomNavigationRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return BlocProvider<BottomNavigationCubit>(
      create: (context) => BottomNavigationCubit(
        initialBranch: navigationShell.currentIndex,
        goBranch: (branch, {bool goToRoot = false}) =>
            navigationShell.goBranch(branch, initialLocation: goToRoot),
      ),
      child: BottomNavigationPage(navigationShell: navigationShell),
    );
  }
}

class HomePageBranchData extends StatefulShellBranchData {}

class HomePageRouteData extends GoRouteData with $HomePageRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<LocationDetailsBloc>(
      create: (context) =>
          LocationDetailsBloc(repository: context.read<LocationRepository>()),
      child: FutureBuilder(
        future: context.read<GeolocatorClient>().getCurrentPosition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
              future: context.read<LocationApiClient>().getLocationByCoord(
                snapshot.data!,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data is Ok<Location>) {
                  return LocationPage(
                    location: (snapshot.data as Ok<Location>).value,
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class SavedLocationsPageBranchData extends StatefulShellBranchData {}

class SavedLocationsPageRouteData extends GoRouteData
    with $SavedLocationsPageRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SavedLocationsPage();
  }
}

class SearchPageBranchData extends StatefulShellBranchData {}

class SearchPageRouteData extends GoRouteData with $SearchPageRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RepositoryProvider(
      create: (context) => SearchLocationsRepository(
        locationClient: context.read<LocationApiClient>(),
        hiveClient: context.read<HiveClient>(),
      ),
      child: BlocProvider<SearchLocationsBloc>(
        create: (context) => SearchLocationsBloc(
          repository: context.read<SearchLocationsRepository>(),
        ),
        child: SearchLocationsPage(),
      ),
    );
  }
}

@TypedGoRoute<SearchLocationDetailsRouteData>(
  name: 'searchLocationDetails',
  path: '/search/details',
)
class SearchLocationDetailsRouteData extends GoRouteData
    with $SearchLocationDetailsRouteData {
  final Location $extra;

  const SearchLocationDetailsRouteData(this.$extra);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<LocationDetailsBloc>(
      create: (context) =>
          LocationDetailsBloc(repository: context.read<LocationRepository>()),
      child: LocationPage(location: $extra),
    );
  }
}

@TypedGoRoute<SavedLocationDetailsRouteData>(
  name: 'savedLocationDetails',
  path: '/saved/details',
)
class SavedLocationDetailsRouteData extends GoRouteData
    with $SavedLocationDetailsRouteData {
  final Location $extra;

  const SavedLocationDetailsRouteData(this.$extra);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<LocationDetailsBloc>(
      create: (context) =>
          LocationDetailsBloc(repository: context.read<LocationRepository>()),
      child: LocationPage(location: $extra),
    );
  }
}
