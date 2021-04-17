import 'package:appetizer/models/leaves/leave.dart';

class PaginatedLeaves {
  int count;
  bool hasNext;
  bool hasPrevious;
  List<Leave> results;

  PaginatedLeaves({
    this.count,
    this.hasNext,
    this.hasPrevious,
    this.results,
  });

  factory PaginatedLeaves.fromJson(Map<String, dynamic> json) =>
      PaginatedLeaves(
        count: json['count'],
        hasNext: json['has_next'],
        hasPrevious: json['has_previous'],
        results:
            List<Leave>.from(json['results'].map((x) => Leave.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'has_next': hasNext,
        'has_previous': hasPrevious,
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
