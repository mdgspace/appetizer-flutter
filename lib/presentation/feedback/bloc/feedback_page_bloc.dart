import 'package:appetizer/domain/repositories/feedback_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feedback_page_event.dart';
part 'feedback_page_state.dart';

class FeedbackPageBloc extends Bloc<FeedbackPageEvent, FeedbackPageState> {
  final FeedbackRepository repo;
  FeedbackPageBloc({
    required this.repo,
  }) : super(
          const FeedbackPageState.initial(),
        ) {
    on<FeedbackPageSubmitEvent>(_onSubmit);
    on<FeedbackPageDescriptionChangedEvent>(_onDescriptionChange);
  }

  void _onSubmit(
      FeedbackPageSubmitEvent event, Emitter<FeedbackPageState> emit) {
    // TODO: implement repository call
    bool submissionSuccessful = true;
    if (submissionSuccessful) {
      emit(
        FeedbackPageState(
          rating: event.rating,
          description: event.description,
          submitted: true,
          error: false,
        ),
      );
    }
    // else {
    //   emit(
    //     FeedbackPageState(
    //       rating: event.rating,
    //       description: event.description,
    //       submitted: false,
    //       error: true,
    //     ),
    //   );
    // }
  }

  void _onDescriptionChange(FeedbackPageDescriptionChangedEvent event,
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
  }
}
