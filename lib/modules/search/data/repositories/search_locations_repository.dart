import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/services/hive_client.dart';
import 'package:open_meteo_app/core/services/location_api_client.dart';
import 'package:open_meteo_app/core/utils/result.dart';
import 'package:open_meteo_app/core/utils/string_extensions.dart';

class SearchLocationsRepository {
  final LocationApiClient _locationClient;
  final HiveClient _hiveClient;

  const SearchLocationsRepository({
    required LocationApiClient locationClient,
    required HiveClient hiveClient,
  }) : _hiveClient = hiveClient,
       _locationClient = locationClient;

  Future<Result<List<String>>> getRecentSearches() async {
    try {
      final recentSearches = await _hiveClient.getRecentSearches();

      return Result.ok(recentSearches);
    } catch (e) {
      return Result.error(e as Exception);
    }
  }

  Future<Result<List<Location>>> searchLocations(String search) async {
    final locations = <Location>[];
    final normalizedSearch = search.normalize();

    final locationsResult = await _locationClient.getLocations(
      name: normalizedSearch,
    );
    if (locationsResult is Ok<List<Location>>) {
      await _hiveClient.saveRecentSearch(search);
      await locationsResult.value.map((location) async {
        locations.add(
          location.copyWith(isSaved: await _hiveClient.isSaved(location.id)),
        );
      }).wait;
    }

    return Result.ok(locations);
  }

  Future<void> saveLocation(Location location) async {
    await _hiveClient.toggleSaveLocation(location);
  }
}
