import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feedback_page_event.dart';
part 'feedback_page_state.dart';

class FeedbackPageBloc extends Bloc<FeedbackPageEvent, FeedbackPageState> {
  FeedbackPageBloc()
      : super(
          FeedbackPageState(
            rating: List<int>.filled(5, 0),
            description: '',
            submitted: false,
            error: false,
          ),
        ) {
    on<FeedbackPageSubmitEvent>(
        (FeedbackPageSubmitEvent event, Emitter<FeedbackPageState> emit) {
      // TODO: implement repository call
      bool _submissionSuccessful = true;
      if (_submissionSuccessful) {
        emit(
          FeedbackPageState(
            rating: event.rating,
            description: event.description,
            submitted: true,
            error: false,
          ),
        );
      } else {
        emit(
          FeedbackPageState(
            rating: event.rating,
            description: event.description,
            submitted: false,
            error: true,
          ),
        );
      }
    });
    on<FeedbackPageDescriptionChangedEvent>(
        (FeedbackPageDescriptionChangedEvent event,
            Emitter<FeedbackPageState> emit) {
      if (event.description != state.description) {
        emit(
          FeedbackPageState(
            rating: state.rating,
            description: event.description,
            submitted: state.submitted,
            error: state.error,
          ),
        );
      }
    });
  }
}
