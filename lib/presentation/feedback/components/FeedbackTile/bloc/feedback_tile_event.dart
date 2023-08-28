part of 'feedback_tile_bloc.dart';

abstract class FeedbackTileEvent extends Equatable {
  const FeedbackTileEvent();

  @override
  List<Object> get props => [];
}

class FeedbackRatingChangedEvent extends FeedbackTileEvent {
  const FeedbackRatingChangedEvent({
    required this.newRating,
  });
  final int newRating;

  @override
  List<Object> get props => [newRating];
}
