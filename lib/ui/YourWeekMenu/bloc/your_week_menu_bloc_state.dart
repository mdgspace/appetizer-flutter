part of 'your_week_menu_bloc_bloc.dart';

abstract class YourWeekMenuBlocState extends Equatable {
  const YourWeekMenuBlocState();

  @override
  List<Object> get props => [];
}

class YourWeekMenuBlocDisplayState extends YourWeekMenuBlocState {
  const YourWeekMenuBlocDisplayState(
      {required this.weekMenu, required this.currDayIndex});
  final WeekMenu weekMenu;
  final int currDayIndex;

  @override
  List<Object> get props => [weekMenu, currDayIndex];
}

class YourWeekMenuBlocLoadingState extends YourWeekMenuBlocState {
  const YourWeekMenuBlocLoadingState();

  @override
  List<Object> get props => [];
}
