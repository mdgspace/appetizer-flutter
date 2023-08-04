import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'day_date_bar_event.dart';
part 'day_date_bar_state.dart';

class DayDateBarBloc extends Bloc<DayDateBarEvent, DayDateBarState> {
  final int startDate, endDate, currDate;
  final String startDay;
  DayDateBarBloc(
      {required this.endDate,
      required this.startDate,
      required this.startDay,
      required this.currDate})
      : super(DayDateBarState(
            endDate: endDate,
            startDate: startDate,
            startDay: startDay,
            currDate: currDate)) {
    on<DateChangeEvent>((DateChangeEvent event, Emitter<DayDateBarState> emit) {
      if (state.currDate != event.newCurrDate) {
        emit(DayDateBarState(
            endDate: endDate,
            startDate: startDate,
            startDay: startDay,
            currDate: event.newCurrDate));
      }
    });
  }
}
