import 'package:json_annotation/json_annotation.dart';

part 'appetizer_feedback.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppetizerFeedback {
  String title;
  String message;
  dynamic mealId;
  // dynamic imageUrl;
  int ratings;

  AppetizerFeedback({
    required this.title,
    required this.message,
    required this.mealId,
    // required this.imageUrl,
    required this.ratings,
  });

  factory AppetizerFeedback.fromJson(Map<String, dynamic> json) =>
      _$AppetizerFeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$AppetizerFeedbackToJson(this);
}
