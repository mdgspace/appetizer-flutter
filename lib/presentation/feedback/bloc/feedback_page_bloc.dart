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
      List<Map<String, dynamic>> ratings = [
        {"type": "am", "stars": event.rating[0]},
        {"type": "hc", "stars": event.rating[1]},
        {"type": "wm", "stars": event.rating[2]},
        {"type": "ws", "stars": event.rating[3]},
        {"type": "dn", "stars": event.rating[4]}
      ];
      AppetizerFeedback feedback = AppetizerFeedback(
        id: 0,
        title: 'Feedback',
        message: event.description,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        mealId: event.mealId,
        imageUrl: null,
        dateIssue: DateTime.now().millisecondsSinceEpoch,
        response: null,
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
          error: state.error,
          mealId: state.mealId,
        ),
      );
    }
  }
}
