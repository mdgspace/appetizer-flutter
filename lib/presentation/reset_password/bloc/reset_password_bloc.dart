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
      : super(const ResetPasswordInitial()) {
    on<ResetPasswordPressed>(_onResetPasswordPressed);
    on<ToggleObscureResetPassword>(_onToggleObscureResetPassword);
  }

  FutureOr<void> _onResetPasswordPressed(event, emit) async {
    if (event.newPassword.length < 8) {
      emit(
        const ResetPasswordInitial(
          error: 'Password must be at least 8 characters long',
        ),
      );
      return;
    }
    if (event.newPassword != event.confirmPassword) {
      emit(
        const ResetPasswordInitial(
          error: 'Passwords do not match',
        ),
      );
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
      emit(const ResetPasswordInitial(error: AppConstants.GENERIC_FAILURE));
    }
  }

  FutureOr<void> _onToggleObscureResetPassword(event, emit) async {
    emit(
      (state as ResetPassword).copyWith(
        showOldPassword: event.showOldPassword,
        showNewPassword: event.showNewPassword,
        showConfirmPassword: event.showConfirmPassword,
      ),
    );
  }
}
