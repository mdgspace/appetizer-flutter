part of 'day_date_bar_bloc.dart';

class DayDateBarEvent extends Equatable {
  const DayDateBarEvent();

  @override
  List<Object?> get props => [];
}

class DayDateBarInitialEvent extends DayDateBarEvent {}

class DayDateBarChangedEvent extends DayDateBarEvent {
  const DayDateBarChangedEvent({required this.newDate});

  final DateTime newDate;

  @override
  List<Object?> get props => [newDate];
}