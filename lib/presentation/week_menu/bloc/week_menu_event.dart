part of 'week_menu_bloc.dart';

abstract class WeekMenuBlocEvent extends Equatable {
  const WeekMenuBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeekMenuData extends WeekMenuBlocEvent {
  const FetchWeekMenuData();
}

class DayChangeEvent extends WeekMenuBlocEvent {
  const DayChangeEvent({required this.newDayIndex});
  final int newDayIndex;

  @override
  List<Object> get props => [newDayIndex];
}

class NextWeekChangeEvent extends WeekMenuBlocEvent {
  const NextWeekChangeEvent({required this.nextWeekId});
  final int nextWeekId;

  @override
  List<Object> get props => [nextWeekId];
}

class PreviousWeekChangeEvent extends WeekMenuBlocEvent {
  const PreviousWeekChangeEvent({required this.previousWeekId});
  final int previousWeekId;

  @override
  List<Object> get props => [previousWeekId];
}
