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
      // TODO: route to oauth_webview
      emit(CreatePassword());
    });
    on<LoginPressed>((event, emit) {
      emit(Loading());
      // if error
      if (event.password.length < 8) {
        emit(EnterPassword(
            error: 'Password must be at least 8 characters long'));
      }
      // TODO: call api

      // if failed
      // emit(LoginError());
      // else
      // TODO: route to home screen
      // emit(LoginSuccess());
    });
    on<ShowPasswordPressed>((event, emit) {
      if (state is EnterPassword) {
        final currentState = state as EnterPassword;
        emit(EnterPassword(showPassword: !currentState.showPassword));
      }
    });
    on<ForgotPasswordPressed>((event, emit) {
      emit(ForgotPasswordState());
    });
    on<SendPasswordResetInstructions>((event, emit) async {
      //TODO: complete logic
      // for reference, see forgot_password_viewmodel.dart on master branch
    });
  }
}
