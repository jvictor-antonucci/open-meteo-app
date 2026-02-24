part of 'search_locations_bloc.dart';

enum SearchLocationStatus { empty, success, searching }

class SearchLocationsState {
  final SearchLocationStatus status;
  final List<String> recentSearches;
  final List<Location> searchResult;

  const SearchLocationsState({
    required this.status,
    required this.recentSearches,
    required this.searchResult,
  });

  SearchLocationsState copyWith({
    SearchLocationStatus? status,
    List<String>? recentSearches,
    List<Location>? searchResult,
  }) {
    return SearchLocationsState(
      status: status ?? this.status,
      recentSearches: recentSearches ?? this.recentSearches,
      searchResult: searchResult ?? this.searchResult,
    );
  }
}
