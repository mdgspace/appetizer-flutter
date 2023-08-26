import 'package:appetizer/data/services/local/local_storage_service.dart';
import 'package:appetizer/domain/models/user/oauth_user.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/domain/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<NextPressed>((event, emit) async {
      emit(Loading());
      bool isOldUser = await userRepository.userIsOldUser(event.enrollmentNo);
      if (isOldUser) {
        emit(EnterPassword(enrollmentNo: event.enrollmentNo));
      } else {
        emit(CreatePassword(enrollmentNo: event.enrollmentNo));
      }
    });
    on<LoginPressed>((event, emit) async {
      emit(Loading());
      try {
        User user =
            await userRepository.userLogin(event.enrollmentNo, event.password);
        LocalStorageService localStorageService =
            await LocalStorageService.getInstance();
        localStorageService.currentUser = user;
        localStorageService.token = user.token!;
        localStorageService.isLoggedIn = true;
        localStorageService.isFirstTimeLogin = true;
        // TODO: route to home screen
      } catch (e) {
        // TODO: show dialog box
      }
    });
    on<ShowPasswordPressed>((event, emit) {
      if (state is EnterPassword) {
        final currentState = state as EnterPassword;
        emit(EnterPassword(
          showPassword: !currentState.showPassword,
          enrollmentNo: currentState.enrollmentNo,
        ));
      }
    });
    on<ForgotPasswordPressed>((event, emit) async {
      emit(Loading());
      try {
        await userRepository.sendResetPasswordLink(event.emailId);
        // TODO: show dialog box that link has been sent
      } catch (e) {
        // TODO: show dialog box with error message
      }
    });
    on<NewUserSignUp>((event, emit) async {
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
    });
    on<CreatedPasswordNewUser>((event, emit) async {
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
        OAuthUser authUser = await userRepository.oAuthComplete(
          event.user,
          event.password,
        );
        User user = await userRepository.userLogin(
          authUser.studentData.enrNo.toString(),
          event.password,
        );
        LocalStorageService localStorageService =
            await LocalStorageService.getInstance();
        localStorageService.currentUser = user;
        localStorageService.token = user.token!;
        localStorageService.isLoggedIn = true;
        localStorageService.isFirstTimeLogin = true;
        // TODO : route to the menu screen and update relevant information about the logged in user
      } catch (e) {
        //TODO: show dialog box with relevant error message
      }
    });
    on<ForgotPasswordPressed>((event, emit) {
      emit(ForgotPasswordState(emailID: event.emailId));
    });
    on<SendPasswordResetInstructions>((event, emit) async {
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
    });
  }
}
