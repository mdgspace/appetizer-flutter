part of 'feedback_page_bloc.dart';

class FeedbackPageState extends Equatable {
  const FeedbackPageState({
    required this.rating,
    required this.description,
    required this.submitted,
    required this.error,
  });

  final List<int> rating;
  final String description;
  final bool submitted;
  final bool error;

  @override
  List<Object> get props =>
      [rating, description, error];
}
