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
    on<NotificationPageFetchEvent>(_onNotificationFetch);
    // // TODO: remove swithc bar and option related events and logic
    // on<NotificationPageSwitchChangedEvent>(_onSwitch);
  }

  void _onNotificationFetch(NotificationPageFetchEvent event,
      Emitter<NotificationPageState> emit) async {
    List<Notification> notifications = await repo.getNotifications();
    emit(
      NotificationPageFetchedState(
        option: 0,
        notifications: notifications,
      ),
    );
    // TODO: add fail state
  }

  // void _onSwitch(NotificationPageSwitchChangedEvent event,
  //     Emitter<NotificationPageState> emit) {
  //   // TODO: implement repository call
  //   List<Notification> notifications = [];
  //   emit(NotificationPageFetchedState(
  //       option: event.option, notifications: notifications,),);
  // }
}
