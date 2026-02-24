import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_meteo_app/core/controllers/cubit/open_meteo_theme_cubit.dart';
import 'package:open_meteo_app/core/route/app_router.dart';
import 'package:open_meteo_app/core/services/geolocator_client.dart';
import 'package:open_meteo_app/core/services/hive_client.dart';
import 'package:open_meteo_app/core/services/location_api_client.dart';
import 'package:open_meteo_app/core/services/weather_api_client.dart';
import 'package:open_meteo_app/modules/location/data/repositories/location_repository.dart';
import 'package:open_meteo_app/modules/saved/data/repositories/saved_locations_repository.dart';
import 'package:open_meteo_app/modules/saved/presentation/controllers/saved_locations_bloc.dart';

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
        RepositoryProvider<LocationApiClient>(
          create: (context) => LocationApiClient(
            locationClient: Dio(
              BaseOptions(baseUrl: 'https://geocoding-api.open-meteo.com/v1'),
            ),
            forecastClient: Dio(
              BaseOptions(baseUrl: 'https://api.open-meteo.com/v1'),
            ),
          ),
        ),
        RepositoryProvider<WeatherApiClient>(
          create: (context) => WeatherApiClient(
            client: Dio(BaseOptions(baseUrl: 'https://api.open-meteo.com/v1')),
          ),
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => LocationRepository(
            weatherClient: context.read<WeatherApiClient>(),
            hiveClient: context.read<HiveClient>(),
          ),
          lazy: true,
        ),
        RepositoryProvider<SavedLocationsRepository>(
          create: (context) => SavedLocationsRepository(
            localClient: context.read<HiveClient>(),
            geolocatorClient: context.read<GeolocatorClient>(),
            locationApiClient: context.read<LocationApiClient>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<OpenMeteoThemeCubit>(
            create: (context) => OpenMeteoThemeCubit(),
          ),
          BlocProvider<SavedLocationsBloc>(
            create: (context) => SavedLocationsBloc(
              repository: context.read<SavedLocationsRepository>(),
            ),
          ),
        ],
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
