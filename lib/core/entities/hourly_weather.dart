import 'package:equatable/equatable.dart';
import 'package:open_meteo_app/core/entities/weather_property.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';

class HourlyWeather extends Equatable {
  final DateTime date;
  final WeatherStatus weatherStatus;
  final WeatherProperty<double> temperature;
  final WeatherProperty<int> precipitationChance;

  const HourlyWeather({
    required this.date,
    required this.weatherStatus,
    required this.temperature,
    required this.precipitationChance,
  });

  Map<String, dynamic> toBoxMap() {
    return {
      'date': date.toIso8601String(),
      'weatherStatus': weatherStatus.code,
      'temperature': temperature.toBoxMap(),
      'precipitationChance': precipitationChance.toBoxMap(),
    };
  }

  factory HourlyWeather.fromBox(Map<String, dynamic> map) {
    return HourlyWeather(
      date: DateTime.parse(map['date']),
      weatherStatus: WeatherStatus.fromCode(map['weatherStatus']),
      temperature: WeatherProperty.fromBox(map['temperature']),
      precipitationChance: WeatherProperty.fromBox(map['precipitationChance']),
    );
  }

  factory HourlyWeather.fromMap(
    Map<String, dynamic> map,
    Map<String, dynamic> units,
  ) {
    return HourlyWeather(
      date: DateTime.parse(map['time']),
      weatherStatus: WeatherStatus.fromCode(map['weather_code']),
      temperature: WeatherProperty<double>(
        value: map['temperature_2m'] ?? 0.0,
        unit: units['temperature_2m'],
      ),
      precipitationChance: WeatherProperty<int>(
        value: map['precipitation_probability'] ?? 0,
        unit: units['precipitation_probability'],
      ),
    );
  }

  @override
  List<Object> get props => [
    date,
    weatherStatus,
    temperature,
    precipitationChance,
  ];
}
