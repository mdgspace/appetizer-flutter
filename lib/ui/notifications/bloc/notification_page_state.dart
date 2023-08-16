part of 'notification_page_bloc.dart';

abstract class NotificationPageState extends Equatable {
  const NotificationPageState();

  @override
  List<Object> get props => [];
}

class NotificationPageInitialState extends NotificationPageState {
  const NotificationPageInitialState();

  @override
  List<Object> get props => [];
}

class NotificationPageFetchedState extends NotificationPageState {
  const NotificationPageFetchedState({
    required this.option,
    required this.notifications,
  });

  final int option;
  final List<Notification> notifications;

  @override
  List<Object> get props => [option, notifications];
}

class NotificationPageFailedState extends NotificationPageState {
  const NotificationPageFailedState({
    required this.notifications,
  });

  final List<Notification> notifications;

  @override
  List<Object> get props => [notifications];
}
