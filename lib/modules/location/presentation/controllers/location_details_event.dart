part of 'location_details_bloc.dart';

sealed class LocationDetailsEvent {
  const LocationDetailsEvent();
}

final class LocationDetailsStarted extends LocationDetailsEvent {
  final Location? location;

  const LocationDetailsStarted({this.location});
}

final class LocationDetailsDateChanged extends LocationDetailsEvent {
  final DateTime date;
  final Location location;

  const LocationDetailsDateChanged({
    required this.date,
    required this.location,
  });
}
