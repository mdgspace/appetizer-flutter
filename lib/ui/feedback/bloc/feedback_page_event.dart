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
  });
  final List<int> rating;
  final String description;

  @override
  List<Object> get props => [rating, description];
}

class FeedbackPageDescriptionChangedEvent extends FeedbackPageEvent {
  const FeedbackPageDescriptionChangedEvent({
    required this.description,
  });

  final String description;

  @override
  List<Object> get props => [description];
}
