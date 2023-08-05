import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feedback_page_event.dart';
part 'feedback_page_state.dart';

class FeedbackPageBloc extends Bloc<FeedbackPageEvent, FeedbackPageState> {
  FeedbackPageBloc()
      : super(
          const FeedbackPageState(
            rating1: 0,
            rating2: 0,
            rating3: 0,
            rating4: 0,
            rating5: 0,
            description: '',
            submitted: false,
            error: false,
          ),
        ) {
    on<FeedbackPageSubmitEvent>(
        (FeedbackPageSubmitEvent event, Emitter<FeedbackPageState> emit) {
      // TODO: implement repository call
      bool submissionSuccessful = true;
      if (submissionSuccessful) {
        emit(
          FeedbackPageState(
            rating1: event.rating1,
            rating2: event.rating2,
            rating3: event.rating3,
            rating4: event.rating4,
            rating5: event.rating5,
            description: event.description,
            submitted: true,
            error: false,
          ),
        );
      }
      else {
        emit(
          FeedbackPageState(
            rating1: event.rating1,
            rating2: event.rating2,
            rating3: event.rating3,
            rating4: event.rating4,
            rating5: event.rating5,
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
            rating1: state.rating1,
            rating2: state.rating2,
            rating3: state.rating3,
            rating4: state.rating4,
            rating5: state.rating5,
            description: event.description,
            submitted: state.submitted,
            error: state.error,
          ),
        );
      }
    });
  }
}
