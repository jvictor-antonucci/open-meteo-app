import 'package:flutter/material.dart';
import 'package:open_meteo_app/modules/location/presentation/widgets/today_detail/property_card.dart';

class TodayDetail extends StatelessWidget {
  final List<PropertyCard> items;
  const TodayDetail({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Today\'s Details',
          style: textStyles.headlineMedium?.apply(color: colors.onSurface),
        ),
        Wrap(
          runSpacing: 12,
          spacing: 12,
          alignment: WrapAlignment.start,
          children: items,
        ),
      ],
    );
  }
}
