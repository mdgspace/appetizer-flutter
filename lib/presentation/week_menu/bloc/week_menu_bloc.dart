import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:appetizer/domain/repositories/leave_repository.dart';
import 'package:appetizer/domain/repositories/menu_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'week_menu_event.dart';
part 'week_menu_state.dart';

class WeekMenuBlocBloc extends Bloc<WeekMenuBlocEvent, WeekMenuBlocState> {
  late WeekMenu weekMenu;
  // final int currDayIndex;
  final bool isCheckedOut;
  final MenuRepository menuRepository;
  final LeaveRepository leaveRepository;

  WeekMenuBlocBloc({
    // required this.weekMenu,
    // required this.currDayIndex,
    required this.isCheckedOut,
    required this.leaveRepository,
    required this.menuRepository,
  }) : super(const WeekMenuBlocLoadingState()) {
    on<FetchWeekMenuData>(
        (FetchWeekMenuData event, Emitter<WeekMenuBlocState> emit) async {
      try {
        WeekMenu weekMenu = await menuRepository.currentWeekMenu();
        emit(WeekMenuBlocDisplayState(
          weekMenu: weekMenu,
          currDayIndex: DateTime.now().day - weekMenu.dayMenus[0].date.day,
          isCheckedOut: isCheckedOut,
        ));
      } on Failure catch (e) {
        emit(WeekMenuErrorState(message: e.message));
      }
    });
    on<NextWeekChangeEvent>(
        (NextWeekChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
      emit(const WeekMenuBlocLoadingState());
      try {
        WeekMenu nextWeekMenu =
            await menuRepository.weekMenuByWeekId(event.nextWeekId);
        emit(WeekMenuBlocDisplayState(
            weekMenu: nextWeekMenu,
            currDayIndex: 0,
            isCheckedOut: (state as WeekMenuBlocDisplayState).isCheckedOut));
      } on Failure catch (e) {
        emit(WeekMenuErrorState(message: e.message));
      }
    });
    on<PreviousWeekChangeEvent>(
        (PreviousWeekChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
      emit(const WeekMenuBlocLoadingState());
      try {
        WeekMenu previousWeekMenu =
            await menuRepository.weekMenuByWeekId(event.previousWeekId);
        emit(WeekMenuBlocDisplayState(
            weekMenu: previousWeekMenu,
            currDayIndex: 0,
            isCheckedOut: (state as WeekMenuBlocDisplayState).isCheckedOut));
      } on Failure catch (e) {
        emit(WeekMenuErrorState(message: e.message));
      }
    });
    on<DayChangeEvent>((DayChangeEvent event, Emitter<WeekMenuBlocState> emit) {
      emit(WeekMenuBlocDisplayState(
          weekMenu: weekMenu,
          currDayIndex: event.newDayIndex,
          isCheckedOut: (state as WeekMenuBlocDisplayState).isCheckedOut));
    });
    on<CheckInEvent>(
        (CheckInEvent event, Emitter<WeekMenuBlocState> emit) async {
      emit(const WeekMenuBlocLoadingState());
      try {
        final bool status = await leaveRepository.checkin();
        emit(WeekMenuBlocDisplayState(
            weekMenu: (state as WeekMenuBlocDisplayState).weekMenu,
            currDayIndex: (state as WeekMenuBlocDisplayState).currDayIndex,
            isCheckedOut: status));
      } catch (error) {
        // TODO: show a dialog box for the error
      }
    });
    on<CheckOutEvent>(
        (CheckOutEvent event, Emitter<WeekMenuBlocState> emit) async {
      emit(const WeekMenuBlocLoadingState());
      try {
        final bool status = await leaveRepository.checkout();
        emit(WeekMenuBlocDisplayState(
            weekMenu: (state as WeekMenuBlocDisplayState).weekMenu,
            currDayIndex: (state as WeekMenuBlocDisplayState).currDayIndex,
            isCheckedOut: status));
      } catch (error) {
        // TODO: show a dialog box for the error
      }
    });
  }
}
