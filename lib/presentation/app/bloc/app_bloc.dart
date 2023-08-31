import 'dart:async';

import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/local/local_storage_service.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserRepository repo;
  AppBloc({
    required this.repo,
  }) : super(AppState.initial()) {
    on<Initialize>(_onInitialize);
    on<GetUser>(_onGetUser);
    on<NavigateToHomeScreen>(_onNavigateToHome);
    on<NavigateToLoginScreen>(_onNavigateToLogin);
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
      final User user = await repo.getCurrentUser();
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
}
