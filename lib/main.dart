import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_meteo_app/core/controllers/cubit/open_meteo_theme_cubit.dart';
import 'package:open_meteo_app/core/route/app_router.dart';
import 'package:open_meteo_app/core/services/geolocator_client.dart';
import 'package:open_meteo_app/core/services/hive_client.dart';
import 'package:open_meteo_app/core/services/location_api_client.dart';
import 'package:open_meteo_app/core/services/weather_api_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GeolocatorClient geolocatorClient = GeolocatorClient();

  final AppRouter appRouter = AppRouter(
    naviagatorKey: GlobalKey<NavigatorState>(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocatorClient>.value(value: GeolocatorClient()),
        RepositoryProvider<HiveClient>(create: (context) => HiveClient()),
        RepositoryProvider<Dio>(create: (context) => Dio()),
        RepositoryProvider<LocationApiClient>(
          create: (context) => LocationApiClient(client: context.read<Dio>()),
        ),
        RepositoryProvider<WeatherApiClient>(
          create: (context) => WeatherApiClient(client: context.read<Dio>()),
        ),
      ],
      child: BlocProvider(
        create: (context) => OpenMeteoThemeCubit(),
        child: BlocBuilder<OpenMeteoThemeCubit, ThemeData>(
          builder: (context, themeState) {
            return MaterialApp.router(
              title: 'Flutter Demo',
              theme: themeState,
              routerConfig: appRouter.router,
            );
          },
        ),
      ),
    );
  }
}
