import 'package:dio/dio.dart';
import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/utils/result.dart';

class LocationApiClient {
  final Dio _locationClient;
  final Dio _forecastClient;

  const LocationApiClient({
    required Dio locationClient,
    required Dio forecastClient,
  }) : _forecastClient = forecastClient,
       _locationClient = locationClient;

  Future<Result<List<Location>>> getLocations({required String name}) async {
    try {
      final queryParameters = {'name': name};

      final response = await _locationClient.get(
        '/search',
        queryParameters: queryParameters,
      );

      if (response.data['error'] == 'true') {
        return Result.error(Exception());
      }

      final locationsMap = response.data['results'];
      final weatherQueryParameters = {
        'latitude': locationsMap
            .map((location) => location['latitude'])
            .join(','),
        'longitude': locationsMap
            .map((location) => location['longitude'])
            .join(','),
        'current': 'temperature_2m,weather_code',
      };

      final weatherResponse = await _forecastClient.get(
        '/forecast',
        queryParameters: weatherQueryParameters,
      );

      final locations = List<Location>.generate(
        (response.data['results'] as List?)?.length ?? 0,
        (index) => Location.fromMap(
          response.data['results'][index],
          weatherResponse.data is List
              ? weatherResponse.data[index]['current']
              : weatherResponse.data['current'],
          weatherResponse.data is List
              ? weatherResponse.data[index]['current_units']
              : weatherResponse.data['current_units'],
        ),
      );

      return Result.ok(locations);
    } catch (e) {
      return Result.error(e as Exception);
    }
  }

  Future<Result<Location>> getLocationByCoord(Coordinate coordinate) async {
    try {
      final weatherQueryParameters = {
        'latitude': coordinate.lat,
        'longitude': coordinate.long,
        'current': 'temperature_2m,weather_code',
      };

      final weatherResponse = await _forecastClient.get(
        '/forecast',
        queryParameters: weatherQueryParameters,
      );
      if (weatherResponse.data['error'] ?? false) {
        return Result.error(
          Exception('Could not retrieve location information'),
        );
      }

      return Result.ok(
        Location.fromMap(
          weatherQueryParameters,
          weatherResponse.data['current'],
          weatherResponse.data['current_units'],
        ),
      );
    } catch (e) {
      return Result.error(e as Exception);
    }
  }
}
