import 'package:equatable/equatable.dart';

import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/entities/weather_property.dart';

class Location extends Equatable {
  final String id;
  final Coordinate coordinate;
  final String name;
  final String country;
  final WeatherProperty<double> temperature;
  final bool isSaved;

  const Location({
    required this.id,
    required this.coordinate,
    required this.name,
    required this.country,
    required this.temperature,
    this.isSaved = false,
  });

  Map<String, dynamic> toBoxMap() {
    return {
      'id': id,
      'coordinate': coordinate.toMap(),
      'name': name,
      'country': country,
      'temperature': temperature.toMap(),
      'isSaved': isSaved,
    };
  }

  factory Location.fromBox(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      coordinate: Coordinate.fromMap(map['coordinate']),
      name: map['name'],
      country: map['country'],
      temperature: WeatherProperty.fromMap(
        map['temperature'],
        (value) => double.parse(value),
      ),
      isSaved: map['isSaved'],
    );
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> coordinateMap = Map.fromEntries(
      map.entries.where(
        (e) => ['latitude', 'longitude', 'elevation'].contains(e.key),
      ),
    );

    return Location(
      id: '${coordinateMap['latitude']}_${coordinateMap['longitude']}',
      coordinate: Coordinate.fromMap(coordinateMap),
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      temperature: map['temperature_2m'] ?? 0,
    );
  }

  Location copyWith({WeatherProperty<double>? temperature, bool? isSaved}) {
    return Location(
      id: id,
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
    coordinate,
    name,
    country,
    temperature,
    isSaved,
  ];
}
