part of 'day_date_bar_bloc.dart';

class DayDateBarState extends Equatable {
  const DayDateBarState(
      {required this.endDate,
      required this.startDate,
      required this.startDay,
      required this.currDate});

  final int startDate, endDate, currDate;
  final String startDay;

  @override
  List<Object> get props => [startDate, endDate, currDate, startDay];
}
