import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum WeatherMetric {
  humidity(
    description: 'Hourly humidity',
    label: 'Humidity',
    icon: LucideIcons.droplets,
    color: Color(0xFF4C7E80),
  ),
  visibility(
    description: 'Hourly visibility',
    label: 'Visibility',
    icon: LucideIcons.eye,
    color: Color(0xFF7A8FA0),
  ),
  windSpeed(
    description: 'Hourly wind speed',
    label: 'Wind Speed',
    icon: LucideIcons.wind,
    color: Color(0xFF6B9EC9),
  ),
  pressure(
    description: 'Hourly surface pressure',
    label: 'Pressure',
    icon: LucideIcons.gauge,
    color: Color(0xFF8A6BBF),
  ),
  precipitation(
    description: 'Hourly precipitation',
    label: 'Precipitation',
    icon: LucideIcons.cloudRain,
    color: Color(0xFF4A7AA8),
  ),
  uvIndex(
    description: 'Hourly UV index',
    label: 'UV Index',
    icon: LucideIcons.sunDim,
    color: Color(0xFFD4A017),
  ),
  precipitationProbability(
    description: 'Hourly precipitation probability',
    label: 'Rain Chance',
    icon: LucideIcons.umbrella,
    color: Color(0xFF365468),
  );

  const WeatherMetric({
    required this.description,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String description;
  final String label;
  final IconData icon;
  final Color color;

  Color get backgroundColor => color.withAlpha(120);
}
