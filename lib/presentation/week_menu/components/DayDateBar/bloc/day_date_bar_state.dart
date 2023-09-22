part of 'day_date_bar_bloc.dart';

class DayDateBarState extends Equatable {
  const DayDateBarState({
    required this.date,
  });

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class DayDateBarInitialState extends DayDateBarState {
  DayDateBarInitialState() : super(date: DateTime.now());
}
