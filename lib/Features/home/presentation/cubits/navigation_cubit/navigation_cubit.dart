import 'package:bloc/bloc.dart';
part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(index: 0));
  void selectTab(int index) {
    emit(NavigationState(index: index));
  }
}
