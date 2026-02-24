part of 'saved_locations_bloc.dart';

enum SavedLocationsStatus { loading, started }

class SavedLocationsState {
  final SavedLocationsStatus status;
  final List<Location> savedLocations;
  final Location? currentLocation;

  const SavedLocationsState({
    required this.savedLocations,
    this.currentLocation,
    required this.status,
  });

  SavedLocationsState copyWith({
    SavedLocationsStatus? status,
    List<Location>? savedLocations,
    Location? currentLocation,
  }) {
    return SavedLocationsState(
      status: status ?? this.status,
      savedLocations: savedLocations ?? this.savedLocations,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}
