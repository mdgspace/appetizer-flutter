part of 'feedback_page_bloc.dart';

abstract class FeedbackPageEvent extends Equatable {
  const FeedbackPageEvent();

  @override
  List<Object> get props => [];
}

class FeedbackPageSubmitEvent extends FeedbackPageEvent {
  const FeedbackPageSubmitEvent({
    required this.rating1,
    required this.rating2,
    required this.rating3,
    required this.rating4,
    required this.rating5,
    required this.description,
  });
  final int rating1;
  final int rating2;
  final int rating3;
  final int rating4;
  final int rating5;
  final String description;

  @override
  List<Object> get props => [rating1, rating2, rating3, rating4, rating5, description];
}

class FeedbackPageDescriptionChangedEvent extends FeedbackPageEvent {
  const FeedbackPageDescriptionChangedEvent({
    required this.description,
  });

  final String description;

  @override
  List<Object> get props => [description];
}
