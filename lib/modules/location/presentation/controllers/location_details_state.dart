part of 'location_details_bloc.dart';

enum LocationDetailsStatus { loading, success, empty }

class LocationDetailsState {
  final LocationDetailsStatus status;
  final WeatherDetail? weatherDetail;

  const LocationDetailsState({required this.status, this.weatherDetail});

  LocationDetailsState copyWith({
    LocationDetailsStatus? status,
    WeatherDetail? weatherDetail,
  }) {
    return LocationDetailsState(
      status: status ?? this.status,
      weatherDetail: weatherDetail ?? this.weatherDetail,
    );
  }
}
