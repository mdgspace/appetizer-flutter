part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class Initialize extends AppEvent {
  const Initialize();
}

class GetUser extends AppEvent {
  const GetUser({required this.navigateTo});

  final NavigateTo navigateTo;

  @override
  List<Object> get props => [navigateTo];
}

class NavigateToHomeScreen extends AppEvent {
  const NavigateToHomeScreen();
}

class NavigateToLoginScreen extends AppEvent {
  const NavigateToLoginScreen();
}
