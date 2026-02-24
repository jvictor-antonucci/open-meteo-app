import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/utils/result.dart';
import 'package:open_meteo_app/modules/saved/data/repositories/saved_locations_repository.dart';

part 'saved_locations_event.dart';
part 'saved_locations_state.dart';

class SavedLocationsBloc
    extends Bloc<SavedLocationsEvent, SavedLocationsState> {
  final SavedLocationsRepository _repository;

  SavedLocationsBloc({required SavedLocationsRepository repository})
    : _repository = repository,
      super(
        SavedLocationsState(
          savedLocations: [],
          status: SavedLocationsStatus.loading,
        ),
      ) {
    on<SavedLocationsStarted>(_handleSavedLocationsStarted);
    on<SavedLocationsUpdatedItem>(_handleSavedLocationsUpdatedItem);
  }

  Future<void> _handleSavedLocationsStarted(
    SavedLocationsStarted event,
    Emitter<SavedLocationsState> emit,
  ) async {
    final (resultCurrentLocation, resultSavedLocations) = await (
      _repository.getCurrentLocation(),
      _repository.getSavedLocations(),
    ).wait;

    emit(
      state.copyWith(
        status: SavedLocationsStatus.started,
        savedLocations: resultSavedLocations is Ok<List<Location>>
            ? resultSavedLocations.value
            : [],
        currentLocation: resultCurrentLocation is Ok<Location>
            ? resultCurrentLocation.value
            : null,
      ),
    );
  }

  Future<void> _handleSavedLocationsUpdatedItem(
    SavedLocationsUpdatedItem event,
    Emitter<SavedLocationsState> emit,
  ) async {
    if (event.location != null) {
      await _repository.toggleSavedLocation(event.location!);
    }

    final savedLocations = await _repository.getSavedLocations();
    emit(
      state.copyWith(
        savedLocations: savedLocations is Ok<List<Location>>
            ? savedLocations.value
            : null,
      ),
    );
  }
}
