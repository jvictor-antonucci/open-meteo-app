import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/entities/coordinate.dart';
import 'package:open_meteo_app/core/enums/weather_status.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/forecast/forecast.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/hourly_forecast/hourly_forecast.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/location_page_header.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/today_detail/property_card.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/today_detail/today_detail.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: LocationPageHeaderDelegate(
              pageHeight: MediaQuery.sizeOf(context).height,
              weatherStatus: WeatherStatus.clearSky,
              coordinate: Coordinate(lat: 16, long: 21),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsetsGeometry.only(top: 24),
            sliver: SliverList.list(
              children: [
                HourlyForecast(
                  items: [
                    HourlyForecastItemDetails(
                      temperature: '18',
                      chanceOfRaining: '10%',
                      formattedDateTime: 'Now',
                      weatherStatus: WeatherStatus.clearSky,
                    ),
                    HourlyForecastItemDetails(
                      temperature: '18',
                      chanceOfRaining: '10%',
                      formattedDateTime: 'Now',
                      weatherStatus: WeatherStatus.clearSky,
                    ),
                    HourlyForecastItemDetails(
                      temperature: '18',
                      chanceOfRaining: '10%',
                      formattedDateTime: 'Now',
                      weatherStatus: WeatherStatus.clearSky,
                    ),
                    HourlyForecastItemDetails(
                      temperature: '18',
                      chanceOfRaining: '10%',
                      formattedDateTime: 'Now',
                      weatherStatus: WeatherStatus.clearSky,
                    ),
                    HourlyForecastItemDetails(
                      temperature: '18',
                      chanceOfRaining: '10%',
                      formattedDateTime: 'Now',
                      weatherStatus: WeatherStatus.clearSky,
                    ),
                  ],
                  currentIndex: 0,
                  onTap: (index) {},
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TodayDetail(
                    items: [
                      PropertyCard(
                        weatherStatus: WeatherStatus.clearSky,
                        label: 'UV Index',
                        formattedValue: '5',
                        description: 'Moderate',
                      ),
                      PropertyCard(
                        weatherStatus: WeatherStatus.clearSky,
                        label: 'UV Index',
                        formattedValue: '5',
                        description: 'Moderate',
                      ),
                      PropertyCard(
                        weatherStatus: WeatherStatus.clearSky,
                        label: 'UV Index',
                        formattedValue: '5',
                        description: 'Moderate',
                      ),
                      PropertyCard(
                        weatherStatus: WeatherStatus.clearSky,
                        label: 'UV Index',
                        formattedValue: '5',
                        description: 'Moderate',
                      ),
                      PropertyCard(
                        weatherStatus: WeatherStatus.clearSky,
                        label: 'UV Index',
                        formattedValue: '5',
                        description: 'Moderate',
                      ),
                      PropertyCard(
                        weatherStatus: WeatherStatus.clearSky,
                        label: 'UV Index',
                        formattedValue: '5',
                        description: 'Moderate',
                      ),
                      PropertyCard(
                        weatherStatus: WeatherStatus.clearSky,
                        label: 'UV Index',
                        formattedValue: '5',
                        description: 'Moderate',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Forecast(),
                SizedBox(height: 160),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
