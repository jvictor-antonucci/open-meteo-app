import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:open_meteo_app/core/entities/daily_weather.dart';
import 'package:open_meteo_app/core/entities/hourly_weather.dart';
import 'package:open_meteo_app/core/entities/weather_property.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';

class WeatherDetail extends Equatable {
  final List<HourlyWeather> hourlyWeather;
  final List<DailyWeather> dailyWeather;
  final WeatherStatus weatherStatus;
  final WeatherProperty<int> relativeHumidity;
  final WeatherProperty<double> apparentTemperature;
  final WeatherProperty<double> visibility;
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
    required this.weatherStatus,
  });

  Map<String, dynamic> toBoxMap() {
    return {
      'hourlyWeather': hourlyWeather.map((x) => x.toBoxMap()).toList(),
      'dailyWeather': dailyWeather.map((e) => e.toBoxMap()).toList(),
      'relativeHumidity': relativeHumidity.toBoxMap(),
      'apparentTemperature': apparentTemperature.toBoxMap(),
      'visibility': visibility.toBoxMap(),
      'windSpeed': windSpeed.toBoxMap(),
      'surfacePressure': surfacePressure.toBoxMap(),
      'precipitation': precipitation.toBoxMap(),
      'uvIndex': uvIndex.toBoxMap(),
      'isDay': isDay.toString(),
      'temperature': temperature.toBoxMap(),
      'precipitationChance': precipitationChance.toBoxMap(),
      'weatherStatus': weatherStatus.code,
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
      relativeHumidity: WeatherProperty.fromBox(map['relativeHumidity']),
      apparentTemperature: WeatherProperty.fromBox(map['apparentTemperature']),
      visibility: WeatherProperty.fromBox(map['visibility']),
      windSpeed: WeatherProperty.fromBox(map['windSpeed']),
      surfacePressure: WeatherProperty.fromBox(map['surfacePressure']),
      precipitation: WeatherProperty.fromBox(map['precipitation']),
      uvIndex: WeatherProperty.fromBox(map['uvIndex']),
      isDay: bool.parse(map['isDay']),
      temperature: WeatherProperty.fromBox(map['temperature']),
      precipitationChance: WeatherProperty.fromBox(map['precipitationChance']),
      weatherStatus: WeatherStatus.fromCode(map['weatherStatus']),
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
      weatherStatus: WeatherStatus.fromCode(map['weather_code']),
      relativeHumidity: WeatherProperty<int>(
        value: map['relative_humidity_2m'],
        unit: units['relative_humidity_2m'],
      ),
      apparentTemperature: WeatherProperty<double>(
        value: map['apparent_temperature'],
        unit: units['apparent_temperature'],
      ),
      visibility: WeatherProperty<double>(
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
      weatherStatus,
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

  WeatherDetail copyWith({
    List<HourlyWeather>? hourlyWeather,
    List<DailyWeather>? dailyWeather,
    WeatherStatus? weatherStatus,
    WeatherProperty<int>? relativeHumidity,
    WeatherProperty<double>? apparentTemperature,
    WeatherProperty<double>? visibility,
    WeatherProperty<double>? windSpeed,
    WeatherProperty<double>? surfacePressure,
    WeatherProperty<double>? precipitation,
    WeatherProperty<double>? uvIndex,
    bool? isDay,
    WeatherProperty<double>? temperature,
    WeatherProperty<int>? precipitationChance,
  }) {
    return WeatherDetail(
      hourlyWeather: hourlyWeather ?? this.hourlyWeather,
      dailyWeather: dailyWeather ?? this.dailyWeather,
      weatherStatus: weatherStatus ?? this.weatherStatus,
      relativeHumidity: relativeHumidity ?? this.relativeHumidity,
      apparentTemperature: apparentTemperature ?? this.apparentTemperature,
      visibility: visibility ?? this.visibility,
      windSpeed: windSpeed ?? this.windSpeed,
      surfacePressure: surfacePressure ?? this.surfacePressure,
      precipitation: precipitation ?? this.precipitation,
      uvIndex: uvIndex ?? this.uvIndex,
      isDay: isDay ?? this.isDay,
      temperature: temperature ?? this.temperature,
      precipitationChance: precipitationChance ?? this.precipitationChance,
    );
  }

  String toJson() => json.encode(toBoxMap());

  factory WeatherDetail.fromJson(String source) =>
      WeatherDetail.fromBox(json.decode(source));
}
