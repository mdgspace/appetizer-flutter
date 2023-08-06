import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'your_week_menu_bloc_event.dart';
part 'your_week_menu_bloc_state.dart';

class YourWeekMenuBlocBloc extends Bloc<YourWeekMenuBlocEvent, YourWeekMenuBlocState> {
  YourWeekMenuBlocBloc() : super(YourWeekMenuBlocInitial()) {
    on<YourWeekMenuBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
