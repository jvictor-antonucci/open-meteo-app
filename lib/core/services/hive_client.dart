import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/entities/weather_detail.dart';

abstract class HiveBoxes {
  static const savedLocations = 'saved_locations';
  static const recentSearches = 'recent_searches';
  static const cachedWeatherLocations = 'cached_weather_locations';
}

class HiveClient {
  bool isInitialized = false;

  HiveClient();

  Future<void> init() async {
    await Hive.initFlutter();
    await (
      Hive.openBox<String>(HiveBoxes.savedLocations),
      Hive.openBox<String>(HiveBoxes.recentSearches),
      Hive.openBox<String>(HiveBoxes.cachedWeatherLocations),
    ).wait;
    isInitialized = true;
  }

  Box<String> get _savedLocations => Hive.box<String>(HiveBoxes.savedLocations);
  Box<String> get _recentSearches => Hive.box<String>(HiveBoxes.recentSearches);
  Box<String> get _cachedWeatherLocations =>
      Hive.box<String>(HiveBoxes.cachedWeatherLocations);

  Future<List<Location>> getSavedLocations() async {
    if (!isInitialized) await init();

    return _savedLocations.values
        .map((location) => Location.fromJson(location).copyWith(isSaved: true))
        .toList();
  }

  Future<bool> isSaved(String locationId) async {
    if (!isInitialized) await init();

    return _savedLocations.containsKey(locationId);
  }

  Future<void> toggleSaveLocation(Location location) async {
    if (!isInitialized) await init();

    if (location.isSaved) {
      await _savedLocations.delete(location.id);
      return;
    }

    await _savedLocations.put(location.id, location.toJson());
  }

  Future<List<String>> getRecentSearches() async {
    if (!isInitialized) await init();

    return _recentSearches.values.toList();
  }

  Future<void> saveRecentSearch(String search) async {
    if (!isInitialized) await init();

    final recentSearches = _recentSearches.values.toList();

    if (recentSearches.contains(search)) return;

    await _recentSearches.add(search);
  }

  Future<WeatherDetail?> getCachedWeatherLocation(String locationId) async {
    if (!isInitialized) await init();

    final weatherDetailJson = _cachedWeatherLocations.get(locationId);

    if (weatherDetailJson == null) return null;

    final now = DateTime.now();
    final weatherDetailMap = jsonDecode(weatherDetailJson);
    if ((DateTime.parse(
      weatherDetailMap['updatedAt'] ?? now.toIso8601String(),
    ).add(const Duration(minutes: 15)).isAfter(now))) {
      return null;
    }

    return WeatherDetail.fromJson(weatherDetailJson);
  }

  Future<void> cacheWeatherLocation(
    WeatherDetail weatherDetail,
    String locationId,
  ) async {
    if (!isInitialized) await init();

    if ((await getCachedWeatherLocation(locationId)) != null) return;

    final weatherDetailMap = weatherDetail.toBoxMap()
      ..update(
        'updatedAt',
        (value) => DateTime.now().toIso8601String(),
        ifAbsent: () => DateTime.now().toIso8601String(),
      );

    await _cachedWeatherLocations.put(locationId, jsonEncode(weatherDetailMap));
  }
}
