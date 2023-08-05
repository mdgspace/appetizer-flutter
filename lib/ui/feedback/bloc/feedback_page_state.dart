part of 'feedback_page_bloc.dart';

class FeedbackPageState extends Equatable {
  const FeedbackPageState({
    required this.rating1,
    required this.rating2,
    required this.rating3,
    required this.rating4,
    required this.rating5,
    required this.description,
    required this.submitted,
    required this.error,
  });

  final int rating1;
  final int rating2;
  final int rating3;
  final int rating4;
  final int rating5;
  final String description;
  final bool submitted;
  final bool error;

  @override
  List<Object> get props =>
      [rating1, rating2, rating3, rating4, rating5, description, error];
}
