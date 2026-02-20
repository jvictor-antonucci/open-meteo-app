import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_meteo_app/core/route/routes.dart';

class AppRouter {
  late final GoRouter _goRouter;

  AppRouter({
    required GlobalKey<NavigatorState> naviagatorKey,
    bool debugLogDiagnostics = false,
  }) {
    _goRouter = _buildRouter(naviagatorKey, debugLogDiagnostics);
  }

  GoRouter get router => _goRouter;

  GoRouter _buildRouter(
    GlobalKey<NavigatorState> navigatorKey,
    bool debugLogDiagnostics,
  ) {
    return GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: debugLogDiagnostics,
      initialLocation: HomePageRouteData().location,
      routes: $appRoutes,
    );
  }
}
