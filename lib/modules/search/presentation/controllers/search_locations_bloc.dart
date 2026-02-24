import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/utils/result.dart';
import 'package:open_meteo_app/modules/search/data/repositories/search_locations_repository.dart';

part 'search_locations_event.dart';
part 'search_locations_state.dart';

class SearchLocationsBloc
    extends Bloc<SearchLocationsEvent, SearchLocationsState> {
  final SearchLocationsRepository _repository;

  SearchLocationsBloc({required SearchLocationsRepository repository})
    : _repository = repository,
      super(
        SearchLocationsState(
          status: SearchLocationStatus.empty,
          recentSearches: [],
          searchResult: [],
        ),
      ) {
    on<SearchLocationStarted>(_handleSearchLocationStarted);
    on<SearchLocationDone>(_handleSearchLocationDone);
    on<SearchLocationResultSaved>(_handleSearchLocationResultSaved);
  }

  Future<void> _handleSearchLocationStarted(
    SearchLocationStarted event,
    Emitter<SearchLocationsState> emit,
  ) async {
    final recentSearchesResult = await _repository.getRecentSearches();

    if (recentSearchesResult is Ok<List<String>>) {
      emit(state.copyWith(recentSearches: recentSearchesResult.value));
    }
  }

  Future<void> _handleSearchLocationDone(
    SearchLocationDone event,
    Emitter<SearchLocationsState> emit,
  ) async {
    if (event.searchTerm.isEmpty) return;
    emit(state.copyWith(status: SearchLocationStatus.searching));
    final searchResults = await _repository.searchLocations(event.searchTerm);

    if (searchResults is Ok<List<Location>>) {
      emit(
        state.copyWith(
          searchResult: searchResults.value,
          status: searchResults.value.isEmpty
              ? SearchLocationStatus.empty
              : SearchLocationStatus.success,
        ),
      );
      return;
    }

    emit(state.copyWith(status: SearchLocationStatus.empty));
  }

  Future<void> _handleSearchLocationResultSaved(
    SearchLocationResultSaved event,
    Emitter<SearchLocationsState> emit,
  ) async {
    await _repository.saveLocation(event.location);

    final searchResults = state.searchResult;
    searchResults[searchResults.indexOf(event.location)] = event.location
        .copyWith(isSaved: true);

    emit(state.copyWith(searchResult: searchResults));
  }
}
