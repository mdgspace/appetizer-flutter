part of 'login_bloc.dart';

abstract class LoginEvent {}

class NextPressed extends LoginEvent {
  final String enrollmentNo;
  NextPressed(this.enrollmentNo);
}

class LoginPressed extends LoginEvent {
  final String password;
  final String enrollmentNo;
  LoginPressed(this.password, this.enrollmentNo);
}

class SetPassword extends LoginEvent {
  final String password;
  final String confirmPassword;
  final String enrollmentNo;
  final OAuthUser user;
  SetPassword(this.password, this.confirmPassword, this.enrollmentNo, this.user);
}

class ShowPasswordPressed extends LoginEvent {}

class ToggleObscureCreatePassword extends LoginEvent {
  final bool showPassword;
  final bool showConfirmPassword;
  ToggleObscureCreatePassword({
    required this.showPassword,
    required this.showConfirmPassword,
  });
}

class SendPasswordResetInstructions extends LoginEvent {
  final String emailId;
  SendPasswordResetInstructions({required this.emailId});
}

class ForgotPasswordPressed extends LoginEvent {}

class CreatedPasswordNewUser extends LoginEvent {
  final OAuthUser user;
  final String password;
  CreatedPasswordNewUser({required this.password, required this.user});
}

class NewUserSignUp extends LoginEvent {
  // this event will be added after the oauth screen returns
  final String code;
  NewUserSignUp({required this.code});
}
