import 'package:appetizer/domain/models/user/notification.dart';
import 'package:appetizer/domain/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_page_event.dart';
part 'notification_page_state.dart';

class NotificationPageBloc
    extends Bloc<NotificationPageEvent, NotificationPageState> {
  final UserRepository repo;
  NotificationPageBloc({
    required this.repo,
  }) : super(const NotificationPageInitialState()) {
    on<NotificationPageFetchEvent>(
      (NotificationPageFetchEvent event,
          Emitter<NotificationPageState> emit) async {
        List<Notification> notifications = await repo.getNotifications();
        emit(
          NotificationPageFetchedState(
            option: 0,
            notifications: notifications,
          ),
        );
        // TODO: add fail state
      },
    );
    // TODO: remove swithc bar and option related events and logic
    // on<NotificationPageSwitchChangedEvent>(
    //   (NotificationPageSwitchChangedEvent event,
    //       Emitter<NotificationPageState> emit) {
    //     List<Notification> notifications = [
    //       const Notification(
    //           id: 123,
    //           dateCreated: 532523,
    //           title: "Yesssir",
    //           message: "fasfafafassfadasdadsafafasfsdfafasfasfasfasfasfas"),
    //       const Notification(
    //           id: 123,
    //           dateCreated: 532523,
    //           title: "Yesssir",
    //           message: "fasfafafassfadasdadsafafasfsdfafasfasfasfasfasfas"),
    //       const Notification(
    //           id: 123,
    //           dateCreated: 532523,
    //           title: "Yesssir",
    //           message: "fasfafafassfadasdadsafafasfsdfafasfasfasfasfasfas")
    //     ];
    //     emit(NotificationPageFetchedState(
    //         option: event.option, notifications: notifications));
    //   },
    // );
  }
}
