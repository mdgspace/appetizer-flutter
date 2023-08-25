import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:appetizer/domain/repositories/leave_repository.dart';
import 'package:appetizer/domain/repositories/menu_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'your_week_menu_bloc_event.dart';
part 'your_week_menu_bloc_state.dart';

class YourWeekMenuBlocBloc
    extends Bloc<YourWeekMenuBlocEvent, YourWeekMenuBlocState> {
  final WeekMenu weekMenu;
  final int currDayIndex;
  final bool isCheckedOut;
  final MenuRepository menuRepository;
  final LeaveRepository leaveRepository;
  YourWeekMenuBlocBloc({
    required this.weekMenu,
    required this.currDayIndex,
    required this.isCheckedOut,
    required this.leaveRepository,
    required this.menuRepository,
  }) : super(YourWeekMenuBlocDisplayState(
            weekMenu: weekMenu,
            currDayIndex: currDayIndex,
            isCheckedOut: isCheckedOut)) {
    on<NextWeekChangeEvent>(
        (NextWeekChangeEvent event, Emitter<YourWeekMenuBlocState> emit) async {
      emit(const YourWeekMenuBlocLoadingState());
      WeekMenu nextWeekMenu = await menuRepository.weekMenuByWeekId(event.nextWeekId);
      emit(YourWeekMenuBlocDisplayState(
          weekMenu: nextWeekMenu,
          currDayIndex: 0,
          isCheckedOut: (state as YourWeekMenuBlocDisplayState).isCheckedOut));
    });
    on<PreviousWeekChangeEvent>((PreviousWeekChangeEvent event,
        Emitter<YourWeekMenuBlocState> emit) async {
      emit(const YourWeekMenuBlocLoadingState());
      WeekMenu previousWeekMenu =
          await menuRepository.weekMenuByWeekId(event.previousWeekId);
      emit(YourWeekMenuBlocDisplayState(
          weekMenu: previousWeekMenu,
          currDayIndex: 0,
          isCheckedOut: (state as YourWeekMenuBlocDisplayState).isCheckedOut));
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
      try {
        final bool status = await leaveRepository.checkin();
        emit(YourWeekMenuBlocDisplayState(
            weekMenu: (state as YourWeekMenuBlocDisplayState).weekMenu,
            currDayIndex: (state as YourWeekMenuBlocDisplayState).currDayIndex,
            isCheckedOut: status));
      } catch (error) {
        // TODO: show a dialog box for the error
      }
    });
    on<CheckOutEvent>(
        (CheckOutEvent event, Emitter<YourWeekMenuBlocState> emit) async {
      emit(const YourWeekMenuBlocLoadingState());
      try {
        final bool status = await leaveRepository.checkout();
        emit(YourWeekMenuBlocDisplayState(
            weekMenu: (state as YourWeekMenuBlocDisplayState).weekMenu,
            currDayIndex: (state as YourWeekMenuBlocDisplayState).currDayIndex,
            isCheckedOut: status));
      } catch (error) {
        // TODO: show a dialog box for the error
      }
    });
  }
}
