import 'package:json_annotation/json_annotation.dart';

part 'appetizer_feedback.g.dart';

@JsonSerializable()
class AppetizerFeedback {
  int id;
  String type;
  String title;
  String message;
  int timestamp;
  @JsonKey(name: 'meal_id')
  dynamic mealId;
  @JsonKey(name: 'image_url')
  dynamic imageUrl;
  @JsonKey(name: 'date_issue')
  int dateIssue;
  dynamic response;

  AppetizerFeedback({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.mealId,
    required this.imageUrl,
    required this.dateIssue,
    required this.response,
  });

  factory AppetizerFeedback.fromJson(Map<String, dynamic> json) =>
      _$AppetizerFeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$AppetizerFeedbackToJson(this);
}
