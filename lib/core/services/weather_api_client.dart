import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/entities/daily_weather.dart';
import 'package:open_meteo_app/core/entities/hourly_weather.dart';
import 'package:open_meteo_app/core/entities/weather_detail.dart';
import 'package:open_meteo_app/core/utils/result.dart';

const hourlyWeatherProperties = [
  'temperature_2m',
  'precipitation_probability',
  'weather_code',
];

const dailyWeatherProperties = [
  'weather_code',
  'temperature_2m_max',
  'temperature_2m_min',
  'precipitation_probability_max',
];

const weatherDetailProperties = [
  ...hourlyWeatherProperties,
  'relative_humidity_2m',
  'apparent_temperature',
  'visibility',
  'wind_speed_10m',
  'surface_pressure',
  'precipitation',
  'uv_index',
  'is_day',
];

class WeatherApiClient {
  final Dio _client;

  const WeatherApiClient({required Dio client}) : _client = client;

  Future<Result<WeatherDetail>> getForecastWeatherDetail({
    required Coordinate coordinate,
    required DateTime date,
  }) async {
    try {
      final queryParameters = {
        'latitude': coordinate.lat,
        'longitude': coordinate.long,
        'hourly': weatherDetailProperties.join(','),
        'start_date': DateFormat('y-m-d').format(date),
        'end_date': DateFormat('y-m-d').format(date),
        'forecast_days': 1,
      };

      final response = await _client.get(
        '/forecast',
        queryParameters: queryParameters,
      );

      if (response.data['error']) {
        return Result.error(Exception());
      }

      final hourlyWeather = List<HourlyWeather>.generate(
        response.data['hourly']?['time']?.length ?? 0,
        (index) {
          final hourlyMap = response.data['hourly'] as Map<String, dynamic>;
          final map = <String, dynamic>{
            for (final element in hourlyMap.entries)
              element.key: element.value[index],
          };
          return HourlyWeather.fromMap(map, response.data['hourly_units']);
        },
      );

      final weatherMap = <String, dynamic>{
        for (final entry in (response.data['hourly'] as Map).entries)
          entry.key: entry.value[date.hour],
      };

      final weatherDetail = WeatherDetail.fromMap(
        weatherMap,
        response.data['hourly_units'],
        hourlyWeatherList: hourlyWeather,
        dailyWeatherList: [],
      );

      return Result.ok(weatherDetail);
    } catch (e) {
      return Result.error(e as Exception);
    }
  }

  Future<Result<WeatherDetail>> getLocationWeatherDetail({
    required Coordinate coordinate,
  }) async {
    try {
      final hourlyQueryParameters = {
        'latitude': coordinate.lat,
        'longitude': coordinate.long,
        'hourly': weatherDetailProperties.join(','),
        'forecast_days': 1,
      };
      final dailyQueryParameters = {
        'latitude': coordinate.lat,
        'longitude': coordinate.long,
        'daily': dailyWeatherProperties.join(','),
        'forecast_days': 10,
      };

      final (hourlyResponse, dailyResponse) = await (
        _client.get('/forecast', queryParameters: hourlyQueryParameters),
        _client.get('/forecast', queryParameters: dailyQueryParameters),
      ).wait;

      if (hourlyResponse.data['error'] == 'true') {
        return Result.error(Exception());
      }

      final hourlyWeather = List<HourlyWeather>.generate(
        hourlyResponse.data['hourly']?['time']?.length ?? 0,
        (index) {
          final hourlyMap =
              hourlyResponse.data['hourly'] as Map<String, dynamic>;
          final map = <String, dynamic>{
            for (final element in hourlyMap.entries)
              element.key: element.value[index],
          };
          return HourlyWeather.fromMap(
            map,
            hourlyResponse.data['hourly_units'],
          );
        },
      );

      final dailyWeather = List.generate(
        dailyResponse.data['daily']?['time']?.length ?? 0,
        (index) {
          final dailyMap = dailyResponse.data['daily'] as Map<String, dynamic>;
          final map = <String, dynamic>{
            for (final entry in dailyMap.entries) entry.key: entry.value[index],
          };

          return DailyWeather.fromMap(map, dailyResponse.data['daily_units']);
        },
      );

      final currentHour = DateTime.now().hour;
      final weatherMap = <String, dynamic>{
        for (final entry in (hourlyResponse.data['hourly'] as Map).entries)
          entry.key: entry.value[currentHour],
      };

      final weatherDetail = WeatherDetail.fromMap(
        weatherMap,
        hourlyResponse.data['hourly_units'],
        hourlyWeatherList: hourlyWeather,
        dailyWeatherList: dailyWeather,
      );

      return Result.ok(weatherDetail);
    } catch (e) {
      return Result.error(e as Exception);
    }
  }
}
