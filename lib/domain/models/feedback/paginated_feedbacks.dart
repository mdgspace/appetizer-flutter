import 'package:appetizer/domain/models/feedback/appetizer_feedback.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_feedbacks.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PaginatedFeedback {
  int count;
  @JsonKey(name: 'has_next')
  bool hasNext;
  @JsonKey(name: 'has_previous')
  bool hasPrevious;
  List<AppetizerFeedback> feedbacks;

  PaginatedFeedback({
    required this.count,
    required this.hasNext,
    required this.hasPrevious,
    required this.feedbacks,
  });

  // TODO: check if feedbacks parse correctly into the map

  factory PaginatedFeedback.fromJson(Map<String, dynamic> json) =>
      _$PaginatedFeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedFeedbackToJson(this);
}
