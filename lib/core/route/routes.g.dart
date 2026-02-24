// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $bottomNavigationRouteData,
  $searchLocationDetailsRouteData,
  $savedLocationDetailsRouteData,
];

RouteBase get $bottomNavigationRouteData => StatefulShellRouteData.$route(
  factory: $BottomNavigationRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/',
          name: 'home',
          factory: $HomePageRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/saved',
          name: 'savedLocations',
          factory: $SavedLocationsPageRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/search',
          name: 'searchLocations',
          factory: $SearchPageRouteData._fromState,
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

mixin $SavedLocationsPageRouteData on GoRouteData {
  static SavedLocationsPageRouteData _fromState(GoRouterState state) =>
      SavedLocationsPageRouteData();

  @override
  String get location => GoRouteData.$location('/saved');

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
  String get location => GoRouteData.$location('/search');

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

RouteBase get $searchLocationDetailsRouteData => GoRouteData.$route(
  path: '/search/details',
  name: 'searchLocationDetails',
  factory: $SearchLocationDetailsRouteData._fromState,
);

mixin $SearchLocationDetailsRouteData on GoRouteData {
  static SearchLocationDetailsRouteData _fromState(GoRouterState state) =>
      SearchLocationDetailsRouteData(state.extra as Location);

  SearchLocationDetailsRouteData get _self =>
      this as SearchLocationDetailsRouteData;

  @override
  String get location => GoRouteData.$location('/search/details');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $savedLocationDetailsRouteData => GoRouteData.$route(
  path: '/saved/details',
  name: 'savedLocationDetails',
  factory: $SavedLocationDetailsRouteData._fromState,
);

mixin $SavedLocationDetailsRouteData on GoRouteData {
  static SavedLocationDetailsRouteData _fromState(GoRouterState state) =>
      SavedLocationDetailsRouteData(state.extra as Location);

  SavedLocationDetailsRouteData get _self =>
      this as SavedLocationDetailsRouteData;

  @override
  String get location => GoRouteData.$location('/saved/details');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}
