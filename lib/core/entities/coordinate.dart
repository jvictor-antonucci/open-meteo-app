import 'dart:convert';

import 'package:equatable/equatable.dart';

class Coordinate extends Equatable {
  final double lat;
  final double long;
  final double? elevation;

  const Coordinate({required this.lat, required this.long, this.elevation});

  Map<String, dynamic> toMap() {
    return {'latitude': lat, 'longitude': long, 'elevation': elevation};
  }

  factory Coordinate.fromMap(Map<String, dynamic> map) {
    return Coordinate(
      lat: map['latitude'] ?? 0.0,
      long: map['longitude'] ?? 0.0,
      elevation: map['elevation'],
    );
  }

  @override
  List<Object?> get props => [lat, long, elevation];
}
