import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notification with _$Notification {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Notification({
    required int id,
    required int dateCreated,
    required String title,
    required String message,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

@freezed
class PaginatedNotifications with _$PaginatedNotifications {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory PaginatedNotifications({
    required int count,
    required bool hasNext,
    required bool hasPrevious,
    required List<Notification> results,
  }) = _PaginatedNotifications;

  factory PaginatedNotifications.fromJson(Map<String, dynamic> json) =>
      _$PaginatedNotificationsFromJson(json);
}
