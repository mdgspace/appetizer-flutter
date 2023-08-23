part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class Loading extends LoginState {}

class CreatePassword extends LoginState {
  final String? error;
  CreatePassword({this.error});
}

class EnterPassword extends LoginState {
  final bool showPassword;
  final String? error;
  EnterPassword({this.showPassword = false, this.error});
}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {}
