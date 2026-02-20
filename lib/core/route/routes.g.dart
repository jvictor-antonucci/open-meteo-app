// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$bottomNavigationRouteData];

RouteBase get $bottomNavigationRouteData => StatefulShellRouteData.$route(
  factory: $BottomNavigationRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/',
          name: 'home',
          factory: $HomePageRouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: '/location/details',
              name: 'locationDetails',
              factory: $LocationDetailsRouteData._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/saved-locations',
          name: 'savedLocations',
          factory: $SavedLocationsPageRouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: '/location/details',
              name: 'savedLocationDetails',
              factory: $SavedLocationDetailsRouteData._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/search-locations',
          name: 'searchLocations',
          factory: $SearchPageRouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: '/location/details',
              name: 'searchLocationDetails',
              factory: $SearchLocationDetailsRouteData._fromState,
            ),
          ],
        ),
      ],
    ),
  ],
);

extension $BottomNavigationRouteDataExtension on BottomNavigationRouteData {
  static BottomNavigationRouteData _fromState(GoRouterState state) =>
      const BottomNavigationRouteData();
}

mixin $HomePageRouteData on GoRouteData {
  static HomePageRouteData _fromState(GoRouterState state) =>
      HomePageRouteData();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LocationDetailsRouteData on GoRouteData {
  static LocationDetailsRouteData _fromState(GoRouterState state) =>
      LocationDetailsRouteData();

  @override
  String get location => GoRouteData.$location('/location/details');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SavedLocationsPageRouteData on GoRouteData {
  static SavedLocationsPageRouteData _fromState(GoRouterState state) =>
      SavedLocationsPageRouteData();

  @override
  String get location => GoRouteData.$location('/saved-locations');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SavedLocationDetailsRouteData on GoRouteData {
  static SavedLocationDetailsRouteData _fromState(GoRouterState state) =>
      SavedLocationDetailsRouteData();

  @override
  String get location => GoRouteData.$location('/location/details');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SearchPageRouteData on GoRouteData {
  static SearchPageRouteData _fromState(GoRouterState state) =>
      SearchPageRouteData();

  @override
  String get location => GoRouteData.$location('/search-locations');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SearchLocationDetailsRouteData on GoRouteData {
  static SearchLocationDetailsRouteData _fromState(GoRouterState state) =>
      SearchLocationDetailsRouteData();

  @override
  String get location => GoRouteData.$location('/location/details');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
