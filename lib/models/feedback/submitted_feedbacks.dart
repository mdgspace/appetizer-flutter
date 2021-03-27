import 'package:appetizer/models/feedback/appetizer_feedback.dart';

class PaginatedSubmittedFeedbacks {
  int count;
  bool hasNext;
  bool hasPrevious;
  List<AppetizerFeedback> feedbacks;

  PaginatedSubmittedFeedbacks({
    this.count,
    this.hasNext,
    this.hasPrevious,
    this.feedbacks,
  });

  factory PaginatedSubmittedFeedbacks.fromJson(Map<String, dynamic> json) =>
      PaginatedSubmittedFeedbacks(
        count: json['count'],
        hasNext: json['has_next'],
        hasPrevious: json['has_previous'],
        feedbacks: List<AppetizerFeedback>.from(
            json['results'].map((x) => AppetizerFeedback.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'has_next': hasNext,
        'has_previous': hasPrevious,
        'results': List<dynamic>.from(feedbacks.map((x) => x.toJson())),
      };
}
