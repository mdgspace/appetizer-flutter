import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'day_date_bar_event.dart';
part 'day_date_bar_state.dart';

class DayDateBarBloc extends Bloc<DayDateBarEvent, DayDateBarState> {
  DayDateBarBloc() : super(DayDateBarInitialState()) {
    on<DayDateBarChangedEvent>((event, emit) {
      emit(DayDateBarState(date: event.newDate));
    });
  }
}
