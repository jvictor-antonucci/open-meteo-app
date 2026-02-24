import 'package:flutter/material.dart';

class TemperatureRangeBar extends StatelessWidget {
  final double globalMin;
  final double globalMax;
  final double dayMin;
  final double dayMax;

  const TemperatureRangeBar({
    super.key,
    required this.globalMin,
    required this.globalMax,
    required this.dayMin,
    required this.dayMax,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final globalRange = globalMax - globalMin;

    final startFraction = (dayMin - globalMin) / globalRange;
    final endFraction = (dayMax - globalMin) / globalRange;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final blueStart = totalWidth * startFraction;
        final blueWidth = totalWidth * (endFraction - startFraction);

        return Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: colors.outline,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Positioned(
              left: blueStart,
              child: Container(
                height: 6,
                width: blueWidth,
                decoration: BoxDecoration(
                  color: colors.tertiary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
