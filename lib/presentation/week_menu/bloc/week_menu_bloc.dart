import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:appetizer/domain/repositories/leave/leave_repository.dart';
import 'package:appetizer/domain/repositories/menu_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'week_menu_event.dart';
part 'week_menu_state.dart';

class WeekMenuBlocBloc extends Bloc<WeekMenuBlocEvent, WeekMenuBlocState> {
  final MenuRepository menuRepository;
  final LeaveRepository leaveRepository;

  WeekMenuBlocBloc({
    required this.leaveRepository,
    required this.menuRepository,
  }) : super(const WeekMenuBlocLoadingState()) {
    on<FetchWeekMenuData>(_onFetchWeekMenuData);
    on<NextWeekChangeEvent>(_onNextWeekChangeEvent);
    on<PreviousWeekChangeEvent>(_onPreviousWeekChangeEvent);
    on<DayChangeEvent>(_onDayChangeEvent);
    on<DateChangeEvent>(_onDateChangeEvent);
  }

  void _onDayChangeEvent(
      DayChangeEvent event, Emitter<WeekMenuBlocState> emit) {
    if (state is! WeekMenuBlocDisplayState) {
      return;
    }
    int dayNumber = getDayNumber(
        (state as WeekMenuBlocDisplayState).weekMenu, event.newDayIndex);
    emit((state as WeekMenuBlocDisplayState)
        .copyWith(currDayIndex: event.newDayIndex, dayNumber: dayNumber));
  }

  void _onPreviousWeekChangeEvent(
      PreviousWeekChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
    emit(const WeekMenuBlocLoadingState());
    try {
      WeekMenu previousWeekMenu =
          await menuRepository.weekMenuByWeekId(event.previousWeekId);
      int dayNumber = getDayNumber(previousWeekMenu, 0);
      emit(WeekMenuBlocDisplayState(
          weekMenu: previousWeekMenu, currDayIndex: 0, dayNumber: dayNumber));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onNextWeekChangeEvent(
      NextWeekChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
    emit(const WeekMenuBlocLoadingState());
    try {
      WeekMenu nextWeekMenu =
          await menuRepository.weekMenuByWeekId(event.nextWeekId);
      int dayNumber = getDayNumber(nextWeekMenu, 0);
      emit(WeekMenuBlocDisplayState(
          weekMenu: nextWeekMenu, currDayIndex: 0, dayNumber: dayNumber));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onFetchWeekMenuData(
      FetchWeekMenuData event, Emitter<WeekMenuBlocState> emit) async {
    try {
      WeekMenu weekMenu = await menuRepository.currentWeekMenu();
      int dayNumber = getDayNumber(weekMenu, DateTime.now().weekday % 7);
      emit(WeekMenuBlocDisplayState(
        weekMenu: weekMenu,
        currDayIndex: DateTime.now().day % 7,
        dayNumber: dayNumber,
      ));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onDateChangeEvent(
      DateChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
    emit(const WeekMenuBlocLoadingState());
    try {
      WeekMenu weekMenu = await menuRepository.weekMenuByWeekId(event.weekId);
      int dayNumber = getDayNumber(weekMenu, event.dayIndex);
      emit(WeekMenuBlocDisplayState(
        weekMenu: weekMenu,
        currDayIndex: event.dayIndex,
        dayNumber: dayNumber,
      ));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  int getDayNumber(WeekMenu weekMenu, int dayIndex) {
    for (int i = 0; i < weekMenu.dayMenus.length; i++) {
      if (weekMenu.dayMenus[i].date.weekday == dayIndex + 1) {
        return i;
      }
    }
    return -1;
  }
}
