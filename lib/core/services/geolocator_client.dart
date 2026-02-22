import 'package:geolocator/geolocator.dart';
import 'package:open_meteo_app/core/entities/coordinate.dart';

class GeolocatorClient {
  bool isEnabled = false;
  bool isPermitted = false;

  GeolocatorClient();

  Future<void> init() async {
    isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return;

    switch (await Geolocator.checkPermission()) {
      case LocationPermission.deniedForever:
        return;
      case LocationPermission.denied:
      case LocationPermission.unableToDetermine:
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
        isPermitted = true;
      default:
        isPermitted = true;
    }
  }

  Future<Coordinate> getCurrentPosition() async {
    if (!isPermitted) await init();

    final currentPosition = await Geolocator.getCurrentPosition();

    return Coordinate(
      lat: currentPosition.latitude,
      long: currentPosition.longitude,
      elevation: currentPosition.altitude,
    );
  }
}
