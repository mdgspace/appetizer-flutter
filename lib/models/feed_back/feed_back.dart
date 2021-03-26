// To parse this JSON data, do
//
//     final feedback = feedbackFromJson(jsonString);

import 'dart:convert';

Feedback feedbackFromJson(String str) => Feedback.fromJson(json.decode(str));

String feedbackToJson(Feedback data) => json.encode(data.toJson());

class Feedback {
  int id;
  String type;
  String title;
  String message;
  int timestamp;
  dynamic mealId;
  dynamic imageUrl;
  int dateIssue;
  dynamic response;

  Feedback({
    this.id,
    this.type,
    this.title,
    this.message,
    this.timestamp,
    this.mealId,
    this.imageUrl,
    this.dateIssue,
    this.response,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => new Feedback(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        message: json["message"],
        timestamp: json["timestamp"],
        mealId: json["meal_id"],
        imageUrl: json["image_url"],
        dateIssue: json["date_issue"],
        response: json["response"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "message": message,
        "timestamp": timestamp,
        "meal_id": mealId,
        "image_url": imageUrl,
        "date_issue": dateIssue,
        "response": response,
      };
}
