import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationCubit extends Cubit<int> {
  final StatefulNavigationShell _navigationShell;

  BottomNavigationCubit({required StatefulNavigationShell navigationShell})
    : _navigationShell = navigationShell,
      super(navigationShell.currentIndex);

  void navigateTo(int branch, {bool goToRoot = false}) {
    try {
      _navigationShell.goBranch(branch, initialLocation: goToRoot);
      emit(branch);
    } catch (e) {
      return;
    }
  }
}
