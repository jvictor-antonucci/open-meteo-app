import 'package:equatable/equatable.dart';

import 'package:open_meteo_app/core/entities/weather_property.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';

class DailyWeather extends Equatable {
  final DateTime date;
  final WeatherStatus weatherStatus;
  final WeatherProperty<double> maxTemperature;
  final WeatherProperty<double> minTemperature;
  final WeatherProperty<int> precipitationChance;

  const DailyWeather({
    required this.date,
    required this.weatherStatus,
    required this.maxTemperature,
    required this.minTemperature,
    required this.precipitationChance,
  });

  Map<String, dynamic> toBoxMap() {
    return {
      'date': date.toIso8601String(),
      'weatherStatus': weatherStatus.code,
      'maxTemperature': maxTemperature.toBoxMap(),
      'minTemperature': minTemperature.toBoxMap(),
      'precipitationChance': precipitationChance.toBoxMap(),
    };
  }

  factory DailyWeather.fromBox(Map<String, dynamic> map) {
    return DailyWeather(
      date: DateTime.parse(map['date']),
      weatherStatus: WeatherStatus.fromCode(map['weatherStatus']),
      maxTemperature: WeatherProperty.fromBox(map['maxTemperature']),
      minTemperature: WeatherProperty.fromBox(map['minTemperature']),
      precipitationChance: WeatherProperty.fromBox(map['precipitationChance']),
    );
  }

  factory DailyWeather.fromMap(
    Map<String, dynamic> map,
    Map<String, dynamic> units,
  ) {
    return DailyWeather(
      date: DateTime.parse(map['time']),
      weatherStatus: WeatherStatus.fromCode(map['weather_code']),
      maxTemperature: WeatherProperty<double>(
        value: map['temperature_2m_max'] ?? 0.0,
        unit: units['temperature_2m_max'],
      ),
      minTemperature: WeatherProperty<double>(
        value: map['temperature_2m_min'] ?? 0.0,
        unit: units['temperature_2m_min'],
      ),
      precipitationChance: WeatherProperty<int>(
        value: map['precipitation_probability_max'] ?? 0,
        unit: units['precipitation_probability_max'],
      ),
    );
  }

  @override
  List<Object> get props => [
    date,
    weatherStatus,
    maxTemperature,
    minTemperature,
    precipitationChance,
  ];

  DailyWeather copyWith({
    DateTime? date,
    WeatherStatus? weatherStatus,
    WeatherProperty<double>? maxTemperature,
    WeatherProperty<double>? minTemperature,
    WeatherProperty<int>? precipitationChance,
  }) {
    return DailyWeather(
      date: date ?? this.date,
      weatherStatus: weatherStatus ?? this.weatherStatus,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      minTemperature: minTemperature ?? this.minTemperature,
      precipitationChance: precipitationChance ?? this.precipitationChance,
    );
  }
}
