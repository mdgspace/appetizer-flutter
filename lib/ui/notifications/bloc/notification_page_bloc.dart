import 'package:appetizer/models/user/notification.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_page_event.dart';
part 'notification_page_state.dart';

class NotificationPageBloc
    extends Bloc<NotificationPageEvent, NotificationPageState> {
  NotificationPageBloc() : super(const NotificationPageInitialState()) {
    on<NotificationPageFetchEvent>((NotificationPageFetchEvent event,
        Emitter<NotificationPageState> emit) {
      // TODO: implement repository call
      bool submissionSuccessful = true;
      List<Notification> notifications = [];
      if (submissionSuccessful) {
        emit(
          NotificationPageFetchedState(
            notifications: notifications,
          ),
        );
      } else {
        emit(
          NotificationPageFailedState(
            notifications: event.notifications,
          ),
        );
      }
    });
  }
}
