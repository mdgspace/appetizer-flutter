part of 'feedback_page_bloc.dart';

class FeedbackPageState extends Equatable {
  const FeedbackPageState({
    required this.rating,
    required this.description,
    required this.submitted,
    required this.error,
  });

  const FeebackPageState.initial()
      : rating = const [0, 0, 0, 0, 0],
        description = '',
        submitted = false,
        error = false;

  final List<int> rating;
  final String description;
  final bool submitted;
  final bool error;

  @override
  List<Object> get props => [rating, description, error];
}
