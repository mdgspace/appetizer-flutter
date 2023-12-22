part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}


class Loading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess();
}

class ResetPassword extends ResetPasswordState {
  const ResetPassword({
    this.error,
    required this.showOldPassword,
    required this.showNewPassword,
    required this.showConfirmPassword,
  });
  final String? error;
  final bool showOldPassword;
  final bool showNewPassword;
  final bool showConfirmPassword;

  ResetPassword copyWith({
    String? error,
    bool? showOldPassword,
    bool? showNewPassword,
    bool? showConfirmPassword,
  }) {
    return ResetPassword(
      error: error ?? this.error,
      showOldPassword: showOldPassword ?? this.showOldPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }

  @override
  List<Object?> get props =>
      [error, showOldPassword, showNewPassword, showConfirmPassword];
}
