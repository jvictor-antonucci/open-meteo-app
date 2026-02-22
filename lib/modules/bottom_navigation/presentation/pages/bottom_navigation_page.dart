import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/controllers/bottom_navigation_cubit.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/widgets/widgets.dart';

class BottomNavigationPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavigationPage({super.key, required this.navigationShell});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: widget.navigationShell,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: CustomBottomNavBar(
            currentIndex: state,
            onTap: (index) => context.read<BottomNavigationCubit>().navigateTo(
              index,
              goToRoot: index == state,
            ),
            items: [
              BottomNavBarItem(icon: LucideIcons.house, label: 'Home'),
              BottomNavBarItem(icon: LucideIcons.bookmark, label: 'Saved'),
              BottomNavBarItem(icon: LucideIcons.search, label: 'Search'),
            ],
          ),
        );
      },
    );
  }
}
