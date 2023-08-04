part of 'day_date_bar_bloc.dart';

abstract class DayDateBarEvent extends Equatable {
  const DayDateBarEvent();

  @override
  List<Object> get props => [];
}

// emitted whenever the user swithes to a new date on the menu screen
class DateChangeEvent extends DayDateBarEvent {
  const DateChangeEvent({required this.newCurrDate});

  final int newCurrDate;

  @override
  List<Object> get props => [newCurrDate];
}
