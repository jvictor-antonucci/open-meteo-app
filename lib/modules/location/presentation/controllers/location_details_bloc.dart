import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/entities/weather_detail.dart';
import 'package:open_meteo_app/core/utils/result.dart';
import 'package:open_meteo_app/modules/location/data/repositories/location_repository.dart';

part 'location_details_event.dart';
part 'location_details_state.dart';

class LocationDetailsBloc
    extends Bloc<LocationDetailsEvent, LocationDetailsState> {
  final LocationRepository _repository;

  LocationDetailsBloc({required LocationRepository repository})
    : _repository = repository,
      super(LocationDetailsState(status: LocationDetailsStatus.loading)) {
    on<LocationDetailsStarted>(_handleLocationDetailsStarted);
    on<LocationDetailsDateChanged>(_handleLocationDetailsDateChanged);
  }

  Future<void> _handleLocationDetailsStarted(
    LocationDetailsStarted event,
    Emitter<LocationDetailsState> emit,
  ) async {
    if (event.location == null) {
      emit(state.copyWith(status: LocationDetailsStatus.empty));
      return;
    }

    final weatherDetail = await _repository.getWeatherDetail(
      location: event.location!,
    );

    if (weatherDetail is Ok<WeatherDetail>) {
      emit(
        state.copyWith(
          status: LocationDetailsStatus.success,
          weatherDetail: weatherDetail.value,
        ),
      );
      return;
    }

    emit(state.copyWith(status: LocationDetailsStatus.empty));
  }

  Future<void> _handleLocationDetailsDateChanged(
    LocationDetailsDateChanged event,
    Emitter<LocationDetailsState> emit,
  ) async {
    final newWeatherDetail = await _repository.getForecastData(
      location: event.location,
      date: event.date,
    );

    if (newWeatherDetail is Ok<WeatherDetail>) {
      emit(
        state.copyWith(
          weatherDetail: newWeatherDetail.value.copyWith(
            dailyWeather: state.weatherDetail?.dailyWeather,
          ),
        ),
      );
    }
  }
}
