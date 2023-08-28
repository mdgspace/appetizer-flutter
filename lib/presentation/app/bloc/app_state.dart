part of 'app_bloc.dart';

enum NavigateTo {
  inital,
  showLoginScreen,
  showHomeScreen,
}

class AppState {
  final NavigateTo navigateTo;
  User? user;

  AppState({required this.navigateTo, this.user});

  AppState copyWith({
    NavigateTo? navigateTo,
    User? user,
  }) {
    return AppState(
        navigateTo: navigateTo ?? this.navigateTo, user: user ?? this.user!);
  }

  factory AppState.initial() => AppState(navigateTo: NavigateTo.inital);
}
