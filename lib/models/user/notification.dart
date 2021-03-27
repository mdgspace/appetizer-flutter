import 'dart:convert';

Notification notificationFromJson(String str) =>
    Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  int id;
  int dateCreated;
  String title;
  String message;

  Notification({
    this.id,
    this.dateCreated,
    this.title,
    this.message,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json['id'],
        dateCreated: json['date_created'],
        title: json['title'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_created': dateCreated,
        'title': title,
        'message': message,
      };
}
