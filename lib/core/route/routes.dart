import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/controllers/bottom_navigation_cubit.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/pages/bottom_navigation_page.dart';
import 'package:open_meteo_app/modules/location/presentation/pages/location_page.dart';
import 'package:open_meteo_app/modules/saved/presentation/pages/saved_locations_page.dart';
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
          path: '/saved-locations',
          routes: [
            TypedGoRoute<SavedLocationDetailsRouteData>(
              name: 'savedLocationDetails',
              path: '/location/details',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SearchPageBranchData>(
      routes: [
        TypedGoRoute<SearchPageRouteData>(
          name: 'searchLocations',
          path: '/search-locations',
          routes: [
            TypedGoRoute<SearchLocationDetailsRouteData>(
              name: 'searchLocationDetails',
              path: '/location/details',
            ),
          ],
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
    return LocationPage();
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
    return SearchLocationsPage();
  }
}

class SearchLocationDetailsRouteData extends GoRouteData
    with $SearchLocationDetailsRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Placeholder();
  }
}

class SavedLocationDetailsRouteData extends GoRouteData
    with $SavedLocationDetailsRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Placeholder();
  }
}
