import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/leave_api.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'your_week_menu_bloc_event.dart';
part 'your_week_menu_bloc_state.dart';

class YourWeekMenuBlocBloc
    extends Bloc<YourWeekMenuBlocEvent, YourWeekMenuBlocState> {
  final WeekMenu weekMenu;
  final int currDayIndex;
  final bool isCheckedOut;
  // final MenuApi _menuApi = locator<MenuApi>();
  // final LeaveApi _leaveApi = locator<LeaveApi>();
  YourWeekMenuBlocBloc(
      {required this.weekMenu,
      required this.currDayIndex,
      required this.isCheckedOut})
      : super(YourWeekMenuBlocDisplayState(
            weekMenu: weekMenu,
            currDayIndex: currDayIndex,
            isCheckedOut: isCheckedOut)) {
    on<NextWeekChangeEvent>(
        (NextWeekChangeEvent event, Emitter<YourWeekMenuBlocState> emit) async {
      // emit(const YourWeekMenuBlocLoadingState());
      // WeekMenu nextWeekMenu = await _menuApi.weekMenuByWeekId(event.nextWeekId);
      // emit(YourWeekMenuBlocDisplayState(
      //     weekMenu: nextWeekMenu,
      //     currDayIndex: 0,
      //     isCheckedOut: (state as YourWeekMenuBlocDisplayState).isCheckedOut));
    });
    on<PreviousWeekChangeEvent>((PreviousWeekChangeEvent event,
        Emitter<YourWeekMenuBlocState> emit) async {
      // emit(const YourWeekMenuBlocLoadingState());
      // WeekMenu previousWeekMenu =
      //     await _menuApi.weekMenuByWeekId(event.previousWeekId);
      // emit(YourWeekMenuBlocDisplayState(
      //     weekMenu: previousWeekMenu,
      //     currDayIndex: 0,
      //     isCheckedOut: (state as YourWeekMenuBlocDisplayState).isCheckedOut));
    });
    on<DayChangeEvent>(
        (DayChangeEvent event, Emitter<YourWeekMenuBlocState> emit) {
      emit(YourWeekMenuBlocDisplayState(
          weekMenu: weekMenu,
          currDayIndex: event.newDayIndex,
          isCheckedOut: (state as YourWeekMenuBlocDisplayState).isCheckedOut));
    });
    on<CheckInEvent>(
        (CheckInEvent event, Emitter<YourWeekMenuBlocState> emit) async {
      emit(const YourWeekMenuBlocLoadingState());
      // try {
      //   final bool status = await _leaveApi.checkin();
      //   emit(YourWeekMenuBlocDisplayState(
      //       weekMenu: (state as YourWeekMenuBlocDisplayState).weekMenu,
      //       currDayIndex: (state as YourWeekMenuBlocDisplayState).currDayIndex,
      //       isCheckedOut: status));
      // } on Failure catch (error) {
      //   // TODO: show a snack bar or something
      // }
    });
    on<CheckOutEvent>(
        (CheckOutEvent event, Emitter<YourWeekMenuBlocState> emit) async {
      emit(const YourWeekMenuBlocLoadingState());
      // try {
      //   final bool status = await _leaveApi.checkout();
      //   emit(YourWeekMenuBlocDisplayState(
      //       weekMenu: (state as YourWeekMenuBlocDisplayState).weekMenu,
      //       currDayIndex: (state as YourWeekMenuBlocDisplayState).currDayIndex,
      //       isCheckedOut: status));
      // } on Failure catch (error) {
      //   // TODO: show a snack bar or something
      // }
    });
  }
}
