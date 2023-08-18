part of 'app_booter_bloc.dart';

abstract class AppBooterEvent extends Equatable {
  const AppBooterEvent();

  @override
  List<Object?> get props => [];
}

class BootUp extends AppBooterEvent {
  const BootUp();
}

class OnBootUp extends AppBooterEvent {
  const OnBootUp();
}
