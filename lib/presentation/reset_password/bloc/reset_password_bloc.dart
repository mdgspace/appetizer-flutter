import 'dart:async';

import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final UserRepository userRepository;
  ResetPasswordBloc({required this.userRepository})
      : super(const ResetPassword(
          showOldPassword: false,
          showNewPassword: false,
          showConfirmPassword: false,
        )) {
    on<ResetPasswordPressed>(_onResetPasswordPressed);
    on<ToggleObscureResetPassword>(_onToggleObscureResetPassword);
  }
  FutureOr<void> _onResetPasswordPressed(
      ResetPasswordPressed event, Emitter<ResetPasswordState> emit) async {
    bool isValidated = true;
    if (event.oldPassword.isEmpty ||
        event.newPassword.isEmpty ||
        event.confirmPassword.isEmpty) {
      emit(
        (state as ResetPassword).copyWith(
          error: 'All fields are required',
        ),
      );
      isValidated = false;
    } else if (event.newPassword.length < 8) {
      emit(
        (state as ResetPassword).copyWith(
          error: 'Password must be at least 8 characters long',
        ),
      );
      isValidated = false;
    } else if (event.newPassword != event.confirmPassword) {
      emit(
        (state as ResetPassword).copyWith(error: 'Passwords do not match'),
      );
      isValidated = false;
    } else if (event.oldPassword == event.newPassword) {
      emit(
        (state as ResetPassword).copyWith(
          error: 'New password cannot be same as old password',
        ),
      );
      isValidated = false;
    }

    if (!isValidated) {
      emit(ResetPassword(
        error: null,
        showOldPassword: (state as ResetPassword).showOldPassword,
        showNewPassword: (state as ResetPassword).showNewPassword,
        showConfirmPassword: (state as ResetPassword).showConfirmPassword,
      ));
      return;
    }

    emit(Loading());
    try {
      await userRepository.changePassword(
        event.oldPassword,
        event.newPassword,
      );
      emit(const ResetPasswordSuccess());
    } catch (e) {
      emit(const ResetPassword(
        error: AppConstants.GENERIC_FAILURE,
        showOldPassword: false,
        showNewPassword: false,
        showConfirmPassword: false,
      ));
      emit((state as ResetPassword).copyWith(error: null));
    }
  }

  FutureOr<void> _onToggleObscureResetPassword(ToggleObscureResetPassword event,
      Emitter<ResetPasswordState> emit) async {
    emit(
      (state as ResetPassword).copyWith(
        showOldPassword: event.showOldPassword,
        showNewPassword: event.showNewPassword,
        showConfirmPassword: event.showConfirmPassword,
      ),
    );
  }
}
