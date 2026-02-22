import 'package:equatable/equatable.dart';
import 'package:open_meteo_app/core/entities/weather_property.dart';

class HourlyWeather extends Equatable {
  final DateTime date;
  final WeatherProperty<double> temperature;
  final WeatherProperty<int> precipitationChance;

  const HourlyWeather({
    required this.date,
    required this.temperature,
    required this.precipitationChance,
  });

  Map<String, dynamic> toBoxMap() {
    return {
      'date': date.toIso8601String(),
      'temperature': temperature.toMap(),
      'precipitationChance': precipitationChance.toMap(),
    };
  }

  factory HourlyWeather.fromBox(Map<String, dynamic> map) {
    return HourlyWeather(
      date: DateTime.parse(map['date']),
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

  factory HourlyWeather.fromMap(
    Map<String, dynamic> map,
    Map<String, dynamic> units,
  ) {
    return HourlyWeather(
      date: DateTime.parse(map['time']),
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
  List<Object> get props => [date, temperature, precipitationChance];
}
