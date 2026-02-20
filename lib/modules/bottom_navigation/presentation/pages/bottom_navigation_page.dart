import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/controllers/bottom_navigation_cubit.dart';

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
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              context.read<BottomNavigationCubit>().navigateTo(
                index,
                goToRoot: state == index,
              );
            },
            items: const [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                label: 'Saved',
                icon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                label: 'Search',
                icon: Icon(Icons.search),
              ),
            ],
          ),
        );
      },
    );
  }
}
