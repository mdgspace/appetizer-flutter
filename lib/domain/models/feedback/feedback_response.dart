import 'package:json_annotation/json_annotation.dart';

part 'feedback_response.g.dart';

@JsonSerializable()
class FeedbackResponse {
  String message;
  @JsonKey(name: 'is_read')
  bool isRead;
  @JsonKey(name: 'date_created')
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
