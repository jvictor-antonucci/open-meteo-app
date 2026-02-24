part of 'saved_locations_bloc.dart';

sealed class SavedLocationsEvent {
  const SavedLocationsEvent();
}

final class SavedLocationsStarted extends SavedLocationsEvent {}

final class SavedLocationsUpdatedItem extends SavedLocationsEvent {
  final Location? location;

  const SavedLocationsUpdatedItem({this.location});
}
