part of 'week_menu_bloc.dart';

abstract class WeekMenuBlocState extends Equatable {
  const WeekMenuBlocState();

  @override
  List<Object> get props => [];

  factory WeekMenuBlocState.initial() => const WeekMenuBlocLoadingState();
}

class WeekMenuBlocDisplayState extends WeekMenuBlocState {
  const WeekMenuBlocDisplayState({
    required this.weekMenu,
    required this.currDayIndex,
    required this.isCheckedOut,
  });

  final WeekMenu weekMenu;
  final int currDayIndex;
  final bool isCheckedOut;

  @override
  List<Object> get props => [weekMenu, currDayIndex];
}

class WeekMenuBlocLoadingState extends WeekMenuBlocState {
  const WeekMenuBlocLoadingState();

  @override
  List<Object> get props => [];
}

class WeekMenuErrorState extends WeekMenuBlocState {
  final String message;

  const WeekMenuErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
