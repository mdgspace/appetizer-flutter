part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class Loading extends LoginState {}

class CreatePassword extends LoginState {
  final String? error;
  final String enrollmentNo;
  CreatePassword({this.error, required this.enrollmentNo});
}

class EnterPassword extends LoginState {
  final bool showPassword;
  final String enrollmentNo;
  final String? error;
  EnterPassword({this.showPassword = false, this.error, required this.enrollmentNo});
}

class ForgotPasswordState extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {}
