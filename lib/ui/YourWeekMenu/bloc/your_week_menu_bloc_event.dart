part of 'your_week_menu_bloc_bloc.dart';

abstract class YourWeekMenuBlocEvent extends Equatable {
  const YourWeekMenuBlocEvent();

  @override
  List<Object> get props => [];
}

class DayChangeEvent extends YourWeekMenuBlocEvent {
  const DayChangeEvent({required this.newDayIndex});
  final int newDayIndex;

  @override
  List<Object> get props => [newDayIndex];
}

class NextWeekChangeEvent extends YourWeekMenuBlocEvent {
  const NextWeekChangeEvent({required this.nextWeekId});
  final int nextWeekId;

  @override
  List<Object> get props => [nextWeekId];
}

class PreviousWeekChangeEvent extends YourWeekMenuBlocEvent {
  const PreviousWeekChangeEvent({required this.previousWeekId});
  final int previousWeekId;

  @override
  List<Object> get props => [previousWeekId];
}
