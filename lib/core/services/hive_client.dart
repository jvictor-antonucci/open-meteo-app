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
      Hive.openBox(HiveBoxes.savedLocations),
      Hive.openBox(HiveBoxes.recentSearches),
      Hive.openBox(HiveBoxes.cachedWeatherLocations),
    ).wait;
    isInitialized = true;
  }

  Box<Map<String, dynamic>> get _savedLocations =>
      Hive.box(HiveBoxes.savedLocations);
  Box<String> get _recentSearches => Hive.box(HiveBoxes.recentSearches);
  Box<Map<String, dynamic>> get _cachedWeatherLocations =>
      Hive.box(HiveBoxes.cachedWeatherLocations);

  Future<List<Location>> getSavedLocations() async {
    if (!isInitialized) await init();

    return _savedLocations.values
        .map((location) => Location.fromMap(location))
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

    await _savedLocations.put(location.id, location.toBoxMap());
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

    final weatherDetailMap = _cachedWeatherLocations.get(locationId);
    final now = DateTime.now();

    if (weatherDetailMap == null ||
        (DateTime.parse(
          weatherDetailMap['updatedAt'] ?? now.toIso8601String(),
        ).add(const Duration(minutes: 15)).isAfter(now))) {
      return null;
    }

    return WeatherDetail.fromBox(weatherDetailMap);
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
        (value) => DateTime.now(),
        ifAbsent: () => DateTime.now(),
      );

    await _cachedWeatherLocations.put(locationId, weatherDetailMap);
  }
}
