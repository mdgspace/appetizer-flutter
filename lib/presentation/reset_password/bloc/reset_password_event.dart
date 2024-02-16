part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {}

class ResetPasswordPressed extends ResetPasswordEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  ResetPasswordPressed(
      this.oldPassword, this.newPassword, this.confirmPassword);
}

class ToggleObscureResetPassword extends ResetPasswordEvent {
  final bool showOldPassword;
  final bool showNewPassword;
  final bool showConfirmPassword;
  ToggleObscureResetPassword({
    required this.showOldPassword,
    required this.showNewPassword,
    required this.showConfirmPassword,
  });
}
