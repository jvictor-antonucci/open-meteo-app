import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/entities/weather_property.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';

class Location extends Equatable {
  final String id;
  final Coordinate coordinate;
  final String name;
  final String country;
  final WeatherProperty<double> temperature;
  final WeatherStatus weatherStatus;
  final bool isSaved;

  const Location({
    required this.id,
    required this.coordinate,
    required this.name,
    required this.country,
    required this.temperature,
    required this.weatherStatus,
    this.isSaved = false,
  });

  Map<String, dynamic> toBoxMap() {
    return {
      'id': id,
      'coordinate': coordinate.toMap(),
      'name': name,
      'country': country,
      'temperature': temperature.toBoxMap(),
      'weatherStatus': weatherStatus.code,
      'isSaved': isSaved,
    };
  }

  factory Location.fromBox(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      coordinate: Coordinate.fromMap(map['coordinate']),
      name: map['name'],
      country: map['country'],
      temperature: WeatherProperty.fromBox(map['temperature']),
      weatherStatus: WeatherStatus.fromCode(map['weatherStatus']),
      isSaved: map['isSaved'],
    );
  }

  factory Location.fromMap(
    Map<String, dynamic> locationMap,
    Map<String, dynamic> currentWeatherMap,
    Map<String, dynamic> units,
  ) {
    final Map<String, dynamic> coordinateMap = Map.fromEntries(
      locationMap.entries.where(
        (e) => ['latitude', 'longitude', 'elevation'].contains(e.key),
      ),
    );

    return Location(
      id: '${coordinateMap['latitude']}_${coordinateMap['longitude']}',
      coordinate: Coordinate.fromMap(coordinateMap),
      name: locationMap['name'] ?? '',
      country: locationMap['country'] ?? '',
      temperature: WeatherProperty<double>(
        value: currentWeatherMap['temperature_2m'],
        unit: units['temperature_2m'],
      ),
      weatherStatus: WeatherStatus.fromCode(currentWeatherMap['weather_code']),
    );
  }

  Location copyWith({
    WeatherProperty<double>? temperature,
    bool? isSaved,
    WeatherStatus? weatherStatus,
  }) {
    return Location(
      id: id,
      weatherStatus: weatherStatus ?? this.weatherStatus,
      coordinate: coordinate,
      name: name,
      country: country,
      temperature: temperature ?? this.temperature,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object> get props => [
    id,
    weatherStatus,
    coordinate,
    name,
    country,
    temperature,
    isSaved,
  ];

  String toJson() => json.encode(toBoxMap());

  factory Location.fromJson(String source) =>
      Location.fromBox(json.decode(source));
}
