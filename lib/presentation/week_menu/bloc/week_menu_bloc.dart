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
    emit((state as WeekMenuBlocDisplayState)
        .copyWith(currDayIndex: event.newDayIndex));
  }

  void _onPreviousWeekChangeEvent(
      PreviousWeekChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
    emit(const WeekMenuBlocLoadingState());
    try {
      WeekMenu previousWeekMenu =
          await menuRepository.weekMenuByWeekId(event.previousWeekId);
      emit(WeekMenuBlocDisplayState(
          weekMenu: previousWeekMenu, currDayIndex: 0));
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
      emit(WeekMenuBlocDisplayState(weekMenu: nextWeekMenu, currDayIndex: 0));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onFetchWeekMenuData(
      FetchWeekMenuData event, Emitter<WeekMenuBlocState> emit) async {
    try {
      WeekMenu weekMenu = await menuRepository.currentWeekMenu();
      emit(WeekMenuBlocDisplayState(
        weekMenu: weekMenu,
        currDayIndex: DateTime.now().day - weekMenu.dayMenus[0].date.day,
      ));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onDateChangeEvent(
      DateChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
    // emit(const WeekMenuBlocLoadingState());
    print('[TEST] DateChangeEvent');
    try {
      print('[TEST] 1');
      WeekMenu weekMenu = await menuRepository.weekMenuByWeekId(event.weekId);
      // if (weekMenu == null) print('[TEST] weekMenu is null');
      print('[TEST] 2');
      emit(WeekMenuBlocDisplayState(
        weekMenu: weekMenu,
        currDayIndex: event.dayIndex,
      ));
      print('[TEST] 3');
    } on Failure catch (e) {
      print('[TEST] 4');
      emit(WeekMenuErrorState(message: e.message));
    }
  }
}
