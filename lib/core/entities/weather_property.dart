import 'package:equatable/equatable.dart';

class WeatherProperty<T> extends Equatable {
  final T value;
  final String unit;

  const WeatherProperty({required this.value, required this.unit});

  Map<String, dynamic> toBoxMap() {
    return {'value': value, 'unit': unit};
  }

  factory WeatherProperty.fromBox(Map<String, dynamic> map) {
    return WeatherProperty(value: map['value'], unit: map['unit']);
  }

  String get format => T == double
      ? '${(value as double).toStringAsFixed(0)}$unit'
      : '$value$unit';

  @override
  List<Object?> get props => [value, unit];
}
