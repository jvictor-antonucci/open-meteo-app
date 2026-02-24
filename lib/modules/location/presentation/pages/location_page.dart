import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/modules/location/domain/enums/weather_metric.dart';
import 'package:open_meteo_app/modules/location/presentation/controllers/location_details_bloc.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/forecast/forecast.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/hourly_forecast/hourly_forecast.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/location_page_header.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/today_detail/property_card.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/today_detail/today_detail.dart';

class LocationPage extends StatefulWidget {
  final Location location;

  const LocationPage({super.key, required this.location});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
    context.read<LocationDetailsBloc>().add(
      LocationDetailsStarted(location: widget.location),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationDetailsBloc, LocationDetailsState>(
        builder: (context, state) {
          if (state.weatherDetail != null) {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: LocationPageHeaderDelegate(
                    pageHeight: MediaQuery.sizeOf(context).height,
                    weatherStatus: state.weatherDetail!.weatherStatus,
                    coordinate: widget.location.coordinate,
                    city: widget.location.name,
                    country: widget.location.country,
                    formattedApparentTemperature:
                        state.weatherDetail!.apparentTemperature.format,
                    formattedTemperature: widget.location.temperature.format,
                    date:
                        state.weatherDetail!.dailyWeather.firstOrNull?.date ??
                        DateTime.now(),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsGeometry.only(top: 24),
                  sliver: SliverList.list(
                    children: [
                      Visibility(
                        visible: state.weatherDetail!.hourlyWeather.isNotEmpty,
                        child: HourlyForecast(
                          items: state.weatherDetail!.hourlyWeather
                              .map(
                                (hourlyDetail) => HourlyForecastItemDetails(
                                  temperature: hourlyDetail.temperature.format,
                                  chanceOfRaining:
                                      hourlyDetail.precipitationChance.format,
                                  date: hourlyDetail.date,
                                  weatherStatus: hourlyDetail.weatherStatus,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TodayDetail(
                          items: WeatherMetric.values.map((metric) {
                            return PropertyCard(
                              metric: metric,
                              formattedValue: switch (metric) {
                                WeatherMetric.humidity =>
                                  state.weatherDetail!.relativeHumidity.format,
                                WeatherMetric.precipitation =>
                                  state.weatherDetail!.precipitation.format,
                                WeatherMetric.precipitationProbability =>
                                  state
                                      .weatherDetail!
                                      .precipitationChance
                                      .format,
                                WeatherMetric.pressure =>
                                  state.weatherDetail!.surfacePressure.format,
                                WeatherMetric.uvIndex =>
                                  state.weatherDetail!.uvIndex.format,
                                WeatherMetric.visibility =>
                                  state.weatherDetail!.visibility.format,
                                WeatherMetric.windSpeed =>
                                  state.weatherDetail!.windSpeed.format,
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Visibility(
                        visible: state.weatherDetail!.dailyWeather.isNotEmpty,
                        child: Forecast(
                          items: state.weatherDetail!.dailyWeather
                              .map(
                                (e) => ForecastItemData(
                                  date: e.date,
                                  formattedPrecipitationChance:
                                      e.precipitationChance.format,
                                  maxTemperature: e.maxTemperature.value,
                                  minTemperature: e.minTemperature.value,
                                  globalMaxTemp: state
                                      .weatherDetail!
                                      .dailyWeather
                                      .map((e) => e.maxTemperature.value)
                                      .toList()
                                      .reduce(
                                        (value, element) => max(value, element),
                                      ),
                                  globalMinTemp: state
                                      .weatherDetail!
                                      .dailyWeather
                                      .map((e) => e.minTemperature.value)
                                      .toList()
                                      .reduce(
                                        (value, element) => min(value, element),
                                      ),
                                  weatherStatus: e.weatherStatus,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 160),
                    ],
                  ),
                ),
              ],
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
