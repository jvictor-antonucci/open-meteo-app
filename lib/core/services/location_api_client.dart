import 'package:dio/dio.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/entities/weather_property.dart';
import 'package:open_meteo_app/core/utils/result.dart';

class LocationApiClient {
  final Dio _client;

  const LocationApiClient({required Dio client}) : _client = client;

  Future<Result<List<Location>>> getLocations({required String name}) async {
    try {
      final queryParameters = {'name': name};

      final response = await _client.get(
        '/search',
        queryParameters: queryParameters,
      );

      if (response.data['error'] == 'true') {
        return Result.error(Exception());
      }

      final locations = List<Location>.generate(
        (response.data['results'] as List?)?.length ?? 0,
        (index) => Location.fromMap(response.data['results'][index]),
      );

      final weatherQueryParameters = {
        'latitude': locations
            .map((location) => location.coordinate.lat)
            .join(','),
        'longitude': locations
            .map((location) => location.coordinate.long)
            .join(','),
        'hourly': 'temperature_2m',
        'forecast_days': 1,
      };

      final weatherResponse = await _client.get(
        '/forecast',
        queryParameters: weatherQueryParameters,
      );

      return Result.ok(
        List<Location>.generate(
          locations.length,
          (index) => locations[index].copyWith(
            temperature: WeatherProperty(
              value: weatherResponse.data[index]['hourly']['temperature_2m'],
              unit: weatherResponse.data[index]['units'],
            ),
          ),
        ),
      );
    } catch (e) {
      return Result.error(e as Exception);
    }
  }
}
