import 'package:appetizer/models/user/notification.dart';

class PaginatedNotifications {
  int count;
  bool hasNext;
  bool hasPrevious;
  List<Notification> results;

  PaginatedNotifications({
    required this.count,
    required this.hasNext,
    required this.hasPrevious,
    required this.results,
  });

  factory PaginatedNotifications.fromJson(Map<String, dynamic> json) =>
      PaginatedNotifications(
        count: json['count'],
        hasNext: json['has_next'],
        hasPrevious: json['has_previous'],
        results: List<Notification>.from(
            json['results'].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'has_next': hasNext,
        'has_previous': hasPrevious,
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
