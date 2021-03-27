class AppetizerFeedback {
  int id;
  String type;
  String title;
  String message;
  int timestamp;
  dynamic mealId;
  dynamic imageUrl;
  int dateIssue;
  dynamic response;

  AppetizerFeedback({
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

  factory AppetizerFeedback.fromJson(Map<String, dynamic> json) =>
      AppetizerFeedback(
        id: json['id'],
        type: json['type'],
        title: json['title'],
        message: json['message'],
        timestamp: json['timestamp'],
        mealId: json['meal_id'],
        imageUrl: json['image_url'],
        dateIssue: json['date_issue'],
        response: json['response'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'message': message,
        'timestamp': timestamp,
        'meal_id': mealId,
        'image_url': imageUrl,
        'date_issue': dateIssue,
        'response': response,
      };
}
