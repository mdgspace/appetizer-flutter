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
      List<Notification> notifications = [
        Notification(
            id: 123,
            dateCreated: 532523,
            title: "Yesssir",
            message: "fasfafafassfadasdadsafafasfsdfafasfasfasfasfasfas"),
        Notification(
            id: 123,
            dateCreated: 532523,
            title: "Yesssir",
            message: "fasfafafassfadasdadsafafasfsdfafasfasfasfasfasfas"),
        Notification(
            id: 123,
            dateCreated: 532523,
            title: "Yesssir",
            message: "fasfafafassfadasdadsafafasfsdfafasfasfasfasfasfas")
      ];
      if (submissionSuccessful) {
        emit(
          NotificationPageFetchedState(
            option: 0,
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

    on<NotificationPageSwitchChangedEvent>(
      (NotificationPageSwitchChangedEvent event,
          Emitter<NotificationPageState> emit) {
        List<Notification> notifications = [
          Notification(
              id: 123,
              dateCreated: 532523,
              title: "Yesssir",
              message: "fasfafafassfadasdadsafafasfsdfafasfasfasfasfasfas"),
          Notification(
              id: 123,
              dateCreated: 532523,
              title: "Yesssir",
              message: "fasfafafassfadasdadsafafasfsdfafasfasfasfasfasfas"),
          Notification(
              id: 123,
              dateCreated: 532523,
              title: "Yesssir",
              message: "fasfafafassfadasdadsafafasfsdfafasfasfasfasfasfas")
        ];
        emit(NotificationPageFetchedState(
            option: event.option, notifications: notifications));
      },
    );
  }
}
