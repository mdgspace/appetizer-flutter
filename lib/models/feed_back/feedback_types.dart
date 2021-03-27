// To parse this JSON data, do
//
//     final feedbackType = feedbackTypeFromJson(jsonString);

import 'dart:convert';

List<FeedbackType> feedbackTypeFromJson(String str) =>
    List<FeedbackType>.from(
        json.decode(str).map((x) => FeedbackType.fromJson(x)));

String feedbackTypeToJson(List<FeedbackType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackType {
  int id;
  String code;
  String name;

  FeedbackType({
    this.id,
    this.code,
    this.name,
  });

  factory FeedbackType.fromJson(Map<String, dynamic> json) => FeedbackType(
        id: json['id'],
        code: json['code'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
      };
}
