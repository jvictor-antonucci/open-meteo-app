import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_meteo_app/core/theme/open_meteo_app_color_theme.dart';
import 'package:open_meteo_app/core/theme/open_meteo_app_font_theme.dart';

class OpenMeteoThemeCubit extends Cubit<ThemeData> {
  OpenMeteoThemeCubit()
    : super(
        ThemeData(
          colorScheme: WeatherColors.clearSky.toColorScheme(),
          textTheme: GoogleFonts.interTextTheme(AppTextTheme.textTheme),
        ),
      );

  void changeWeather(WeatherPalette weatherPalette) {
    emit(
      ThemeData(
        colorScheme: weatherPalette.toColorScheme(),
        textTheme: state.textTheme,
      ),
    );
  }
}
