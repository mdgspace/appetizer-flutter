import 'dart:async';
import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/local/local_storage_service.dart';
import 'package:appetizer/domain/models/user/oauth_user.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<NextPressed>(_onNextPressed);
    on<LoginPressed>(_onLoginPressed);
    on<ShowPasswordPressed>(_onShowPasswordPressed);
    on<ForgotPasswordPressed>(_onForgotPasswordPressed);
    on<NewUserSignUp>(_onNewUserSignUp);
    on<CreatedPasswordNewUser>(_onCreatePasswordNewUser);
    // on<ForgotPasswordPressed>((event, emit) {
    //   emit(ForgotPasswordState(emailID: event.emailId));
    // });
    on<SendPasswordResetInstructions>(_onSendPasswordResetInstructions);
  }

  FutureOr<void> _onSendPasswordResetInstructions(event, emit) async {
    //TODO: complete logic
    emit(Loading());
    try {
      await userRepository.sendResetPasswordLink(event.emailId);
      //TODO: show dialog box that instructions have been sent
      //TODO: route (if needed)
    } catch (e) {
      // TODO: show dialog box with error
    }
    // for reference, see forgot_password_viewmodel.dart on master branch
  }

  FutureOr<void> _onCreatePasswordNewUser(event, emit) async {
    if (event.password.length < 8) {
      emit(
        EnterPassword(
          error: 'Password must be at least 8 characters long',
          enrollmentNo: (state as CreatePassword).enrollmentNo,
        ),
      );
      return;
    }
    emit(Loading());
    try {
      // OAuthUser authUser = await userRepository.oAuthComplete(
      //   event.user,
      //   event.password,
      // );
      // User user = await userRepository.userLogin(
      //   authUser.studentData.enrNo.toString(),
      //   event.password,
      // );
      // LocalStorageService localStorageService =
      //     await LocalStorageService.getInstance();
      // localStorageService.currentUser = user;
      // localStorageService.token = user.token!;
      // localStorageService.isLoggedIn = true;
      // localStorageService.isFirstTimeLogin = true;
      // TODO : route to the menu screen and update relevant information about the logged in user
    } catch (e) {
      //TODO: show dialog box with relevant error message
    }
  }

  FutureOr<void> _onNewUserSignUp(event, emit) async {
    // verify user using code
    try {
      OAuthUser user = await userRepository.oAuthRedirect(event.code);
      if (user.isNew) {
        emit(CreatePassword(enrollmentNo: user.studentData.enrNo.toString()));
      } else {
        //TODO: show dialog box that user is already registered
        emit(
          EnterPassword(
            enrollmentNo: user.studentData.enrNo.toString(),
          ),
        );
      }
    } catch (e) {
      //TODO: show error dialog box
    }
  }

  FutureOr<void> _onForgotPasswordPressed(event, emit) async {
    emit(Loading());
    try {
      await userRepository.sendResetPasswordLink(event.emailId);
      // TODO: show dialog box that link has been sent
    } catch (e) {
      // TODO: show dialog box with error message
    }
  }

  FutureOr<void> _onShowPasswordPressed(event, emit) {
    if (state is EnterPassword) {
      final currentState = state as EnterPassword;
      emit(EnterPassword(
        showPassword: !currentState.showPassword,
        enrollmentNo: currentState.enrollmentNo,
      ));
    }
  }

  FutureOr<void> _onNextPressed(event, emit) async {
    emit(Loading());
    bool isOldUser = await userRepository.userIsOldUser(event.enrollmentNo);
    if (isOldUser) {
      emit(EnterPassword(enrollmentNo: event.enrollmentNo));
    } else {
      // TODO: route to the oauthwebscreen and get code and go back in case of any error in oauthwebview screen
      // verify user using oauthredirect
      // below is the code to be uncommented later:
      //try{
      //  OAuthUser oAuthUser = await userRepository.oAuthRedirect(code);
      //  emit(CreatePassword(event.enrollmentNo));
      //} catch(e) {
      //  //TODO: show dialog box with error code
      //}
    }
  }

  FutureOr<void> _onLoginPressed(event, emit) async {
    emit(Loading());
    try {
      final User user =
          await userRepository.userLogin(event.enrollmentNo, event.password);
      LocalStorageService.setValue(
          key: AppConstants.AUTH_TOKEN, value: user.token);
      LocalStorageService.setValue(key: AppConstants.LOGGED_IN, value: true);
      emit(const LoginSuccess());

      // LocalStorageService localStorageService =
      //     await LocalStorageService.getInstance();
      // localStorageService.currentUser = user;
      // localStorageService.token = user.token!;
      // localStorageService.isFirstTimeLogin = true;
    } catch (e) {
      // TODO: show dialog box
    }
  }
}
