import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'day_date_bar_event.dart';
part 'day_date_bar_state.dart';

class DayDateBarBloc extends Bloc<DayDateBarEvent, DayDateBarState> {
  final int currDate;
  final List<int> dates;
  final Map<int, String> dateToMonthYear;
  DayDateBarBloc(
      {required this.dates,
      required this.dateToMonthYear,
      required this.currDate})
      : super(DayDateBarState(
            dateToMonthYear: dateToMonthYear,
            dates: dates,
            currDate: currDate)) {
    on<DateChangeEvent>((DateChangeEvent event, Emitter<DayDateBarState> emit) {
      if (state.currDate != event.newCurrDate) {
        emit(DayDateBarState(
            dateToMonthYear: dateToMonthYear,
            dates: dates,
            currDate: event.newCurrDate));
      }
    });
  }
}
