part of 'search_locations_bloc.dart';

sealed class SearchLocationsEvent {
  const SearchLocationsEvent();
}

final class SearchLocationStarted extends SearchLocationsEvent {}

final class SearchLocationDone extends SearchLocationsEvent {
  final String searchTerm;

  const SearchLocationDone({required this.searchTerm});
}

final class SearchLocationResultSaved extends SearchLocationsEvent {
  final Location location;

  const SearchLocationResultSaved({required this.location});
}
