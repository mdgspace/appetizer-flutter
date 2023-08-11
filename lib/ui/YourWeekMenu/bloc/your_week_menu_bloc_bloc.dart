import 'package:appetizer/locator.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'your_week_menu_bloc_event.dart';
part 'your_week_menu_bloc_state.dart';

class YourWeekMenuBlocBloc
    extends Bloc<YourWeekMenuBlocEvent, YourWeekMenuBlocState> {
  final WeekMenu weekMenu;
  final int currDayIndex;
  // final MenuApi _menuApi = locator<MenuApi>();
  YourWeekMenuBlocBloc({
    required this.weekMenu,
    required this.currDayIndex,
  }) : super(YourWeekMenuBlocDisplayState(
            weekMenu: weekMenu, currDayIndex: currDayIndex)) {
    on<NextWeekChangeEvent>(
        (NextWeekChangeEvent event, Emitter<YourWeekMenuBlocState> emit) async {
      emit(const YourWeekMenuBlocLoadingState());
      // WeekMenu nextWeekMenu = await _menuApi.weekMenuByWeekId(event.nextWeekId);
      // emit(YourWeekMenuBlocDisplayState(
      //     weekMenu: nextWeekMenu, currDayIndex: 0));
    });
    on<PreviousWeekChangeEvent>((PreviousWeekChangeEvent event,
        Emitter<YourWeekMenuBlocState> emit) async {
      emit(const YourWeekMenuBlocLoadingState());
      // WeekMenu previousWeekMenu =
      //     await _menuApi.weekMenuByWeekId(event.previousWeekId);
      // emit(YourWeekMenuBlocDisplayState(
      //     weekMenu: previousWeekMenu, currDayIndex: 0));
    });
    on<DayChangeEvent>(
        (DayChangeEvent event, Emitter<YourWeekMenuBlocState> emit) {
      emit(YourWeekMenuBlocDisplayState(
          weekMenu: weekMenu, currDayIndex: event.newDayIndex));
    });
  }
}
