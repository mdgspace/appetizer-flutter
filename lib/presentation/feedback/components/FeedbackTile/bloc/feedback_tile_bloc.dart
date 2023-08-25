import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feedback_tile_event.dart';
part 'feedback_tile_state.dart';

class FeedbackTileBloc extends Bloc<FeedbackTileEvent, FeedbackTileState> {
  FeedbackTileBloc() : super(const FeedbackTileState(rating: 0)) {
    on<FeedbackRatingChangedEvent>(
        (FeedbackRatingChangedEvent event, Emitter<FeedbackTileState> emit) {
      if (state.rating != event.newRating) {
        emit(
          FeedbackTileState(rating: event.newRating),
        );
      }
    });
  }
}
