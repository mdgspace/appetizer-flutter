import 'package:appetizer/domain/models/feedback/appetizer_feedback.dart';
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
          FeedbackPageState.initial(),
        ) {
    on<FeedbackPageSubmitEvent>(_onSubmit);
    on<FeedbackPageDescriptionChangedEvent>(_onDescriptionChange);
  }

  void _onSubmit(
      FeedbackPageSubmitEvent event, Emitter<FeedbackPageState> emit) async {
    try {
      int ratings = event.rating;
      AppetizerFeedback feedback = AppetizerFeedback(
        title: 'Feedback',
        message: event.description,
        mealId: event.mealId,
        // imageUrl: null,
        ratings: ratings,
      );
      await repo.newFeedback(feedback);
      emit(
        FeedbackPageState(
          rating: event.rating,
          description: event.description,
          submitted: true,
          error: false,
          mealId: event.mealId,
        ),
      );
    } catch (e) {
      emit(
        FeedbackPageState(
          rating: event.rating,
          description: event.description,
          submitted: false,
          error: true,
          mealId: event.mealId,
        ),
      );
    }

    // bool submissionSuccessful = true;
    // if (submissionSuccessful) {}
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
          error: false,
          mealId: state.mealId,
        ),
      );
    }
  }
}
