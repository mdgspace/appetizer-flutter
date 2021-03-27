// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

Notification notificationFromJson(String str) =>
    Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  int count;
  bool hasNext;
  bool hasPrevious;
  List<Result> results;

  Notification({
    this.count,
    this.hasNext,
    this.hasPrevious,
    this.results,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        count: json['count'],
        hasNext: json['has_next'],
        hasPrevious: json['has_previous'],
        results: List<Result>.from(
            json['results'].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'has_next': hasNext,
        'has_previous': hasPrevious,
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  int dateCreated;
  String title;
  String message;

  Result({
    this.id,
    this.dateCreated,
    this.title,
    this.message,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
