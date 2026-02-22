import 'package:equatable/equatable.dart';

import 'package:open_meteo_app/core/entities/weather_property.dart';

class DailyWeather extends Equatable {
  final DateTime date;
  final WeatherProperty<double> maxTemperature;
  final WeatherProperty<double> minTemperature;
  final WeatherProperty<int> precipitationChance;

  const DailyWeather({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.precipitationChance,
  });

  Map<String, dynamic> toBoxMap() {
    return {
      'date': date.toIso8601String(),
      'maxTemperature': maxTemperature.toMap(),
      'minTemperature': minTemperature.toMap(),
      'precipitationChance': precipitationChance.toMap(),
    };
  }

  factory DailyWeather.fromBox(Map<String, dynamic> map) {
    return DailyWeather(
      date: DateTime.parse(map['date']),
      maxTemperature: WeatherProperty.fromMap(
        map['maxTemperature'],
        (value) => double.parse(value),
      ),
      minTemperature: WeatherProperty.fromMap(
        map['minTemperature'],
        (value) => double.parse(value),
      ),
      precipitationChance: WeatherProperty.fromMap(
        map['precipitationChance'],
        (value) => int.parse(value),
      ),
    );
  }

  factory DailyWeather.fromMap(
    Map<String, dynamic> map,
    Map<String, dynamic> units,
  ) {
    return DailyWeather(
      date: DateTime.parse(map['time']),
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
    maxTemperature,
    minTemperature,
    precipitationChance,
  ];
}
