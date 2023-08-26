import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<Initialize>(_onInitialize);
    on<GetUser>(_onGetUser);
    on<NavigateToHomeScreen>(_onNavigateToHome);
    on<NavigateToLoginScreen>(_onNavigateToLogin);
  }

  FutureOr<void> _onInitialize(Initialize event, Emitter<AppState> emit) {}

  FutureOr<void> _onGetUser(GetUser event, Emitter<AppState> emit) {}

  FutureOr<void> _onNavigateToHome(
      NavigateToHomeScreen event, Emitter<AppState> emit) {}

  FutureOr<void> _onNavigateToLogin(
      NavigateToLoginScreen event, Emitter<AppState> emit) {}
}
