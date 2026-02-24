import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/services/geolocator_client.dart';
import 'package:open_meteo_app/core/services/hive_client.dart';
import 'package:open_meteo_app/core/services/location_api_client.dart';
import 'package:open_meteo_app/core/utils/result.dart';

class SavedLocationsRepository {
  final HiveClient _localClient;
  final GeolocatorClient _geolocatorClient;
  final LocationApiClient _locationApiClient;

  const SavedLocationsRepository({
    required HiveClient localClient,
    required GeolocatorClient geolocatorClient,
    required LocationApiClient locationApiClient,
  }) : _localClient = localClient,
       _geolocatorClient = geolocatorClient,
       _locationApiClient = locationApiClient;

  Future<Result<List<Location>>> getSavedLocations() async {
    try {
      final savedLocations = await _localClient.getSavedLocations();

      return Result.ok(savedLocations);
    } catch (e) {
      return Result.error(e as Exception);
    }
  }

  Future<void> toggleSavedLocation(Location location) async {
    await _localClient.toggleSaveLocation(location);
  }

  Future<Result<Location>> getCurrentLocation() async {
    if (!_geolocatorClient.isPermitted) {
      return Result.error(Exception('Geolocation service denied'));
    }
    try {
      final Coordinate coordinate = await _geolocatorClient
          .getCurrentPosition();

      final resultCurrentLocation = await _locationApiClient.getLocationByCoord(
        coordinate,
      );

      return resultCurrentLocation;
    } catch (e) {
      return Result.error(e as Exception);
    }
  }
}
