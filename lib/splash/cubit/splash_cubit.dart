import 'package:bloc/bloc.dart';

enum SplashPageState { first, second, last }

// Holds an state representing the current splash page inside the splash screen.
class SplashCubit extends Cubit<SplashPageState> {
  SplashCubit() : super(SplashPageState.first);

  void setPageState(SplashPageState state) => emit(state);
}
