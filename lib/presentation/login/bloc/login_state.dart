part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial({this.error});

  final String? error;

  @override
  List<Object?> get props => [error];
}

class Loading extends LoginState {}

class CreatePassword extends LoginState {
  const CreatePassword({this.error, required this.enrollmentNo});
  final String? error;
  final String enrollmentNo;

  @override
  List<Object?> get props => [error, enrollmentNo];
}

class EnterPassword extends LoginState {
  const EnterPassword({
    required this.enrollmentNo,
    this.showPassword = false,
    this.error,
  });

  final bool showPassword;
  final String enrollmentNo;
  final String? error;

  @override
  List<Object?> get props => [showPassword, enrollmentNo, error];
}

class ForgotPasswordState extends LoginState {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}

class LoginError extends LoginState {}
