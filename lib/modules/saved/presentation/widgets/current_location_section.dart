import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_meteo_app/core/entities/location.dart';
import 'package:open_meteo_app/core/route/routes.dart';
import 'package:open_meteo_app/core/shared/widgets/location_card_tile.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/controllers/bottom_navigation_cubit.dart';

class CurrentLocationSection extends StatelessWidget {
  final Location location;

  const CurrentLocationSection({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8),
        Row(
          spacing: 6,
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: colors.primary.withAlpha(50),
              child: Icon(
                Icons.location_on_outlined,
                size: 14,
                color: colors.primary,
              ),
            ),
            Text(
              'CURRENT LOCATION',
              style: textStyles.labelSmall?.apply(color: colors.primary),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: LocationCardTile(
            onTapCard: () => context.read<BottomNavigationCubit>().goBranch(0),
            country: location.country,
            city: location.name,
            isSaved: false,
            formattedTemp: location.temperature.format,
            weatherStatus: location.weatherStatus,
            coordinates: location.coordinate,
          ),
        ),
      ],
    );
  }
}
