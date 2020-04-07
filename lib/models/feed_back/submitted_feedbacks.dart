// To parse this JSON data, do
//
//     final submittedFeedbacks = submittedFeedbacksFromJson(jsonString);

import 'dart:convert';

SubmittedFeedbacksList submittedFeedbacksFromJson(String str) =>
    SubmittedFeedbacksList.fromJson(json.decode(str));

String submittedFeedbacksToJson(SubmittedFeedbacksList data) =>
    json.encode(data.toJson());

class SubmittedFeedbacksList {
  int count;
  bool hasNext;
  bool hasPrevious;
  List<Feedbacks> feedbacks;

  SubmittedFeedbacksList({
    this.count,
    this.hasNext,
    this.hasPrevious,
    this.feedbacks,
  });

  factory SubmittedFeedbacksList.fromJson(Map<String, dynamic> json) =>
      new SubmittedFeedbacksList(
        count: json["count"],
        hasNext: json["has_next"],
        hasPrevious: json["has_previous"],
        feedbacks: new List<Feedbacks>.from(
            json["results"].map((x) => Feedbacks.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "results": new List<dynamic>.from(feedbacks.map((x) => x.toJson())),
      };
}

class Feedbacks {
  int id;
  String type;
  String title;
  String message;
  int timestamp;
  dynamic mealId;
  dynamic imageUrl;
  int dateIssue;
  dynamic response;

  Feedbacks({
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

  factory Feedbacks.fromJson(Map<String, dynamic> json) => new Feedbacks(
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
