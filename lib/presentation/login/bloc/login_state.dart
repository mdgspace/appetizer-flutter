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
  const CreatePassword({
    this.error,
    required this.enrollmentNo,
    required this.user,
    required this.showPassword,
    required this.showConfirmPassword,
  });

  final String? error;
  final String enrollmentNo;
  final OAuthUser user;
  final bool showPassword;
  final bool showConfirmPassword;

  CreatePassword copyWith({
    String? error,
    String? enrollmentNo,
    OAuthUser? user,
    bool? showPassword,
    bool? showConfirmPassword,
  }) {
    return CreatePassword(
      error: error ?? this.error,
      enrollmentNo: enrollmentNo ?? this.enrollmentNo,
      user: user ?? this.user,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }

  @override
  List<Object?> get props =>
      [error, enrollmentNo, user, showPassword, showConfirmPassword];
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
