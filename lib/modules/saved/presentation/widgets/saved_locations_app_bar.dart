import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:open_meteo_app/core/theme/open_meteo_app_font_theme.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/controllers/bottom_navigation_cubit.dart';

class SavedLocationsAppBar extends StatelessWidget {
  const SavedLocationsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return SliverAppBar(
      backgroundColor: colors.surface,
      surfaceTintColor: colors.surface,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Saved',
              style: textStyles.titleMedium?.apply(
                color: colors.surfaceContainer,
              ),
            ),
            Text(
              'Your Favorite Locations',
              style: CustomTextStyles.pageSubtitle,
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            borderRadius: BorderRadius.circular(14),
            color: colors.surfaceContainer,
            child: InkWell(
              onTap: () => context.read<BottomNavigationCubit>().navigateTo(2),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  spacing: 4,
                  children: [
                    Icon(
                      LucideIcons.plus600,
                      size: 18,
                      color: colors.onInverseSurface,
                    ),
                    Text(
                      'Add',
                      style: textStyles.bodyMedium?.apply(
                        color: colors.onInverseSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
