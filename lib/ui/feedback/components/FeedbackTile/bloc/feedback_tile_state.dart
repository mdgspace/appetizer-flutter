part of 'feedback_tile_bloc.dart';

class FeedbackTileState extends Equatable {
  const FeedbackTileState({
    required this.rating,
  });
  final int rating;

  @override
  List<Object> get props => [rating];
}
