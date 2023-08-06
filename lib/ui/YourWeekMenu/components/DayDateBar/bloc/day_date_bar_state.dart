part of 'day_date_bar_bloc.dart';

class DayDateBarState extends Equatable {
  const DayDateBarState(
      {required this.dates, required this.dateToMonthYear, required this.currDate});

  final int currDate;
  final List<int> dates;
  final Map<int, String> dateToMonthYear;

  @override
  List<Object> get props => [dates, dateToMonthYear, currDate];
}
