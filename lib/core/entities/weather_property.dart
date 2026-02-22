import 'package:equatable/equatable.dart';

class WeatherProperty<T> extends Equatable {
  final T value;
  final String unit;

  const WeatherProperty({required this.value, required this.unit});

  Map<String, dynamic> toMap() {
    return {'value': value, 'unit': unit};
  }

  factory WeatherProperty.fromMap(
    Map<String, dynamic> map,
    T Function(dynamic value) valueParser,
  ) {
    return WeatherProperty<T>(
      value: valueParser.call(map['value']),
      unit: map['unit'] ?? '',
    );
  }
  @override
  List<Object?> get props => [value, unit];
}
