part of 'login_bloc.dart';

abstract class LoginEvent {}

class NextPressed extends LoginEvent {
  final String enrollmentNo;
  NextPressed(this.enrollmentNo);
}

class LoginPressed extends LoginEvent {
  final String password;
  LoginPressed(this.password);
}

class ShowPasswordPressed extends LoginEvent {}

class ForgotPasswordPressed extends LoginEvent {}

class SendPasswordResetInstructions extends LoginEvent {}
