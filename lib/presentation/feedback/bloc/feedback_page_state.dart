part of 'feedback_page_bloc.dart';

// ignore: must_be_immutable
class FeedbackPageState extends Equatable {
  FeedbackPageState({
    required this.rating,
    required this.description,
    required this.mealId,
    required this.submitted,
    required this.error,
  });

  FeedbackPageState.initial()
      : rating = 0,
        description = '',
        mealId = 0,
        submitted = false,
        error = false;

  int rating;
  final String description;
  final int mealId;
  final bool submitted;
  final bool error;

  @override
  List<Object> get props => [rating, description, mealId, error];
}
