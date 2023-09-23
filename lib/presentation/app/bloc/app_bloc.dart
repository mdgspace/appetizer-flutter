import 'dart:async';

import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/local/local_storage_service.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/domain/repositories/leave/leave_repository.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

// TODO(manan): add handler for ToggleCheckOutStatusEvent
class AppBloc extends Bloc<AppEvent, AppState> {
  final UserRepository userRepository;
  final LeaveRepository leaveRepository;
  User? _user;

  AppBloc({
    required this.userRepository,
    required this.leaveRepository,
  }) : super(AppState.initial()) {
    on<Initialize>(_onInitialize);
    on<GetUser>(_onGetUser);
    on<NavigateToHomeScreen>(_onNavigateToHome);
    on<NavigateToLoginScreen>(_onNavigateToLogin);
    on<ToggleCheckOutStatusEvent>(_onToggleCheckOutStatus);
  }

  FutureOr<void> _onToggleCheckOutStatus(
      ToggleCheckOutStatusEvent event, Emitter<AppState> emit) async {
    // emit state assumming api call will be successful
    emit(state.copyWith(
        user: state.user!.copyWith(isCheckedOut: !state.user!.isCheckedOut)));
    // call api
    bool finalCheckStatus = !state.user!.isCheckedOut
        ? await leaveRepository.checkin()
        : await leaveRepository.checkout();
    // if api call is unsuccessful then revert state and show snackbar
    if (finalCheckStatus != state.user!.isCheckedOut) {
      emit(state.copyWith(
          user: state.user!.copyWith(isCheckedOut: finalCheckStatus)));
      // TODO: show dialog box with error (Can't show snackbar because of unavailability of context)
    }
  }

  void _onInitialize(Initialize event, Emitter<AppState> emit) {
    final isLoggedIn =
        LocalStorageService.getValue<bool>(AppConstants.LOGGED_IN) ?? false;

    if (!isLoggedIn) {
      add(const NavigateToLoginScreen());
      return;
    }

    add(const GetUser());
  }

  FutureOr<void> _onGetUser(GetUser event, Emitter<AppState> emit) async {
    try {
      final User user = await userRepository.getCurrentUser();
      _user = user;
      emit(state.copyWith(user: user));
      add(const NavigateToHomeScreen());
    } catch (err) {
      LocalStorageService.setValue(key: AppConstants.LOGGED_IN, value: false);
      add(const NavigateToLoginScreen());
    }
  }

  FutureOr<void> _onNavigateToHome(
      NavigateToHomeScreen event, Emitter<AppState> emit) {
    emit(state.copyWith(navigateTo: NavigateTo.showHomeScreen));
  }

  FutureOr<void> _onNavigateToLogin(
      NavigateToLoginScreen event, Emitter<AppState> emit) {
    emit(state.copyWith(navigateTo: NavigateTo.showLoginScreen));
  }

  String get userName => _user?.name ?? 'A';
}
