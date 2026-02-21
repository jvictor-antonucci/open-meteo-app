import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_meteo_app/core/controllers/cubit/open_meteo_theme_cubit.dart';
import 'package:open_meteo_app/core/route/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter appRouter = AppRouter(
    naviagatorKey: GlobalKey<NavigatorState>(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
    );
  }
}
