import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/entities/weather_detail.dart';
import 'package:open_meteo_app/core/services/hive_client.dart';
import 'package:open_meteo_app/core/services/weather_api_client.dart';
import 'package:open_meteo_app/core/utils/result.dart';

class LocationRepository {
  final WeatherApiClient _weatherClient;
  final HiveClient _hiveClient;

  const LocationRepository({
    required WeatherApiClient weatherClient,
    required HiveClient hiveClient,
  }) : _hiveClient = hiveClient,
       _weatherClient = weatherClient;

  Future<Result<WeatherDetail>> getWeatherDetail({
    required Location location,
  }) async {
    try {
      try {
        final cachedWeatherDetail = await _hiveClient.getCachedWeatherLocation(
          location.id,
        );

        if (cachedWeatherDetail != null) {
          return Result.ok(cachedWeatherDetail);
        }
      } catch (_) {}

      final weatherDetail = await _weatherClient.getLocationWeatherDetail(
        coordinate: location.coordinate,
      );

      if (weatherDetail is Ok<WeatherDetail>) {
        try {
          await _hiveClient.cacheWeatherLocation(
            weatherDetail.value,
            location.id,
          );
        } catch (_) {}
      }

      return weatherDetail;
    } catch (e) {
      return Result.error(e as Exception);
    }
  }

  Future<Result<WeatherDetail>> getForecastData({
    required Location location,
    required DateTime date,
  }) async {
    final weatherDetail = await _weatherClient.getForecastWeatherDetail(
      coordinate: location.coordinate,
      date: date,
    );

    return weatherDetail;
  }
}
