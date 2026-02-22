import 'package:bloc/bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  final int initialBranch;
  final Function(int branch, {bool goToRoot}) goBranch;

  BottomNavigationCubit({required this.goBranch, required this.initialBranch})
    : super(initialBranch);

  void navigateTo(int branch, {bool goToRoot = false}) async {
    try {
      goBranch.call(branch, goToRoot: goToRoot);
      emit(branch);
    } catch (e) {
      return;
    }
  }
}
