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
      FeedbackResponse(
        message: json['message'],
        isRead: json['is_read'],
        dateCreated: json['date_created'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'is_read': isRead,
        'date_created': dateCreated,
      };
}
