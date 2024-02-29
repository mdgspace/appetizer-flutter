part of 'feedback_page_bloc.dart';

abstract class FeedbackPageEvent extends Equatable {
  const FeedbackPageEvent();

  @override
  List<Object> get props => [];
}

class FeedbackPageSubmitEvent extends FeedbackPageEvent {
  const FeedbackPageSubmitEvent({
    required this.rating,
    required this.description,
    required this.mealId,
  });
  final List<int> rating;
  final String description;
  final int mealId;

  @override
  List<Object> get props => [rating, description, mealId];
}

class FeedbackPageDescriptionChangedEvent extends FeedbackPageEvent {
  const FeedbackPageDescriptionChangedEvent({
    required this.description,
  });

  final String description;

  @override
  List<Object> get props => [description];
}
