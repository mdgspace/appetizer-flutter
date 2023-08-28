import 'package:json_annotation/json_annotation.dart';

part 'feedback_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FeedbackResponse {
  String message;
  bool isRead;
  int dateCreated;

  FeedbackResponse({
    required this.message,
    required this.isRead,
    required this.dateCreated,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedbackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackResponseToJson(this);
}
