import 'package:equatable/equatable.dart';
import 'package:open_meteo_app/core/entities/daily_weather.dart';

import 'package:open_meteo_app/core/entities/hourly_weather.dart';
import 'package:open_meteo_app/core/entities/weather_property.dart';

class WeatherDetail extends Equatable {
  final List<HourlyWeather> hourlyWeather;
  final List<DailyWeather> dailyWeather;
  final WeatherProperty<int> relativeHumidity;
  final WeatherProperty<double> apparentTemperature;
  final WeatherProperty<int> visibility;
  final WeatherProperty<double> windSpeed;
  final WeatherProperty<double> surfacePressure;
  final WeatherProperty<double> precipitation;
  final WeatherProperty<double> uvIndex;
  final bool isDay;
  final WeatherProperty<double> temperature;
  final WeatherProperty<int> precipitationChance;

  const WeatherDetail({
    required this.hourlyWeather,
    required this.dailyWeather,
    required this.relativeHumidity,
    required this.apparentTemperature,
    required this.visibility,
    required this.windSpeed,
    required this.surfacePressure,
    required this.precipitation,
    required this.uvIndex,
    required this.isDay,
    required this.temperature,
    required this.precipitationChance,
  });

  Map<String, dynamic> toBoxMap() {
    return {
      'hourlyWeather': hourlyWeather.map((x) => x.toBoxMap()).toList(),
      'dailyWeather': dailyWeather.map((e) => e.toBoxMap()).toList(),
      'relativeHumidity': relativeHumidity.toMap(),
      'apparentTemperature': apparentTemperature.toMap(),
      'visibility': visibility.toMap(),
      'windSpeed': windSpeed.toMap(),
      'surfacePressure': surfacePressure.toMap(),
      'precipitation': precipitation.toMap(),
      'uvIndex': uvIndex.toMap(),
      'isDay': isDay.toString(),
      'temperature': temperature.toMap(),
      'precipitationChance': precipitationChance.toMap(),
    };
  }

  factory WeatherDetail.fromBox(Map<String, dynamic> map) {
    return WeatherDetail(
      hourlyWeather: (map['hourlyWeather'] as List)
          .map((e) => HourlyWeather.fromBox(e))
          .toList(),
      dailyWeather: (map['dailyWeather'] as List)
          .map((e) => DailyWeather.fromBox(e))
          .toList(),
      relativeHumidity: WeatherProperty.fromMap(
        map['relativeHumidity'],
        (value) => int.parse(value),
      ),
      apparentTemperature: WeatherProperty.fromMap(
        map['apparentTemperature'],
        (value) => double.parse(value),
      ),
      visibility: WeatherProperty.fromMap(
        map['visibility'],
        (value) => int.parse(value),
      ),
      windSpeed: WeatherProperty.fromMap(
        map['windSpeed'],
        (value) => double.parse(value),
      ),
      surfacePressure: WeatherProperty.fromMap(
        map['surfacePressure'],
        (value) => double.parse(value),
      ),
      precipitation: WeatherProperty.fromMap(
        map['precipitation'],
        (value) => double.parse(value),
      ),
      uvIndex: WeatherProperty.fromMap(
        map['uvIndex'],
        (value) => double.parse(value),
      ),
      isDay: bool.parse(map['isDay']),
      temperature: WeatherProperty.fromMap(
        map['temperature'],
        (value) => double.parse(value),
      ),
      precipitationChance: WeatherProperty.fromMap(
        map['precipitationChance'],
        (value) => int.parse(value),
      ),
    );
  }

  factory WeatherDetail.fromMap(
    Map<String, dynamic> map,
    Map<String, dynamic> units, {
    List<HourlyWeather> hourlyWeatherList = const [],
    List<DailyWeather> dailyWeatherList = const [],
  }) {
    return WeatherDetail(
      dailyWeather: dailyWeatherList,
      hourlyWeather: hourlyWeatherList,
      relativeHumidity: WeatherProperty<int>(
        value: map['relative_humidity_2m'],
        unit: units['relative_humidity_2m'],
      ),
      apparentTemperature: WeatherProperty<double>(
        value: map['apparent_temperature'],
        unit: units['apparent_temperature'],
      ),
      visibility: WeatherProperty<int>(
        value: map['visibility'],
        unit: units['visibility'],
      ),
      windSpeed: WeatherProperty<double>(
        value: map['wind_speed_10m'],
        unit: units['wind_speed_10m'],
      ),
      surfacePressure: WeatherProperty<double>(
        value: map['surface_pressure'],
        unit: units['surface_pressure'],
      ),
      precipitation: WeatherProperty<double>(
        value: map['precipitation'],
        unit: units['precipitation'],
      ),
      uvIndex: WeatherProperty<double>(
        value: map['uv_index'],
        unit: units['uv_index'],
      ),
      isDay: (map['is_day'] ?? 1) == 1,
      temperature: WeatherProperty<double>(
        value: map['temperature_2m'],
        unit: units['temperature_2m'],
      ),
      precipitationChance: WeatherProperty<int>(
        value: map['precipitation_probability'],
        unit: units['precipitation_probability'],
      ),
    );
  }

  @override
  List<Object> get props {
    return [
      hourlyWeather,
      dailyWeather,
      relativeHumidity,
      apparentTemperature,
      visibility,
      windSpeed,
      surfacePressure,
      precipitation,
      uvIndex,
      isDay,
      temperature,
      precipitationChance,
    ];
  }
}
