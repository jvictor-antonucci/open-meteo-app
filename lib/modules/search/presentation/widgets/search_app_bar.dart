import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:open_meteo_app/modules/search/presentation/controllers/search_locations_bloc.dart';
import 'package:open_meteo_app/modules/search/presentation/widgets/search_input.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverAppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: colors.surface,
        leading: GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(LucideIcons.map, color: colors.primary),
          ),
        ),
        title: BlocBuilder<SearchLocationsBloc, SearchLocationsState>(
          builder: (context, state) {
            return SearchInput(recentSearches: state.recentSearches);
          },
        ),
      ),
    );
  }
}
