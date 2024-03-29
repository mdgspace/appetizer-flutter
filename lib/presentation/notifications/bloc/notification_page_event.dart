part of 'notification_page_bloc.dart';

abstract class NotificationPageEvent extends Equatable {
  const NotificationPageEvent();

  @override
  List<Object> get props => [];
}

class NotificationPageFetchEvent extends NotificationPageEvent {
  const NotificationPageFetchEvent({
    required this.notifications,
  });

  final List<Notification> notifications;

  @override
  List<Object> get props => [notifications];
}

// class NotificationPageSwitchChangedEvent extends NotificationPageEvent {
//   const NotificationPageSwitchChangedEvent({
//     required this.option,
//   });

//   final int option;

//   @override
//   List<Object> get props => [option];
// }
