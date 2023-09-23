part of 'week_menu_bloc.dart';

abstract class WeekMenuBlocState extends Equatable {
  const WeekMenuBlocState();

  @override
  List<Object> get props => [];

  factory WeekMenuBlocState.initial() => const WeekMenuBlocLoadingState();
}

class WeekMenuBlocDisplayState extends WeekMenuBlocState {
  // TODO: remove th variable jugaad, it is used to force rebuild the DayMenuWidget
  const WeekMenuBlocDisplayState({
    required this.weekMenu,
    required this.currDayIndex,
    required this.dayNumber,
    required this.jugaad,
  });

  final WeekMenu weekMenu;
  final int currDayIndex;
  final int dayNumber;
  final bool jugaad;

  WeekMenuBlocDisplayState copyWith(
      {WeekMenu? weekMenu, int? currDayIndex, int? dayNumber}) {
    return WeekMenuBlocDisplayState(
      weekMenu: weekMenu ?? this.weekMenu,
      currDayIndex: currDayIndex ?? this.currDayIndex,
      dayNumber: dayNumber ?? this.dayNumber,
      jugaad: !jugaad,
    );
  }

  @override
  List<Object> get props => [weekMenu, currDayIndex, dayNumber, jugaad];
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
