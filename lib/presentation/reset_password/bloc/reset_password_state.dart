part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial({this.error});

  final String? error;

  @override
  List<Object?> get props => [error];
}

class Loading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess();
}

class ResetPassword extends ResetPasswordState {
  const ResetPassword({
    required this.showOldPassword,
    required this.showNewPassword,
    required this.showConfirmPassword,
  });

  final bool showOldPassword;
  final bool showNewPassword;
  final bool showConfirmPassword;

  ResetPassword copyWith({
    bool? showOldPassword,
    bool? showNewPassword,
    bool? showConfirmPassword,
  }) {
    return ResetPassword(
      showOldPassword: showOldPassword ?? this.showOldPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }

  @override
  List<Object?> get props =>
      [showOldPassword, showNewPassword, showConfirmPassword];
}
