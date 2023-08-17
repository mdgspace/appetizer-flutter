import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<NextPressed>((event, emit) {
      emit(Loading());
      // if already in db
      // emit(CreatePassword());
      // else
      emit(CreatePassword());
    });
    on<LoginPressed>((event, emit) {
      emit(Loading());
      // if error
      if (event.password.length < 8) {
        emit(EnterPassword(
            error: 'Password must be at least 8 characters long'));
      }
      // emit(LoginError());
      // else
      // emit(LoginSuccess());
    });
    on<ShowPasswordPressed>((event, emit) {
      if (state is EnterPassword) {
        final currentState = state as EnterPassword;
        emit(EnterPassword(showPassword: !currentState.showPassword));
      }
    });
  }
}
