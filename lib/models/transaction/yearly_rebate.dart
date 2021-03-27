// To parse this JSON data, do
//
//     final yearlyRebate = yearlyRebateFromJson(jsonString);

import 'dart:convert';

YearlyRebate yearlyRebateFromJson(String str) =>
    YearlyRebate.fromJson(json.decode(str));

String yearlyRebateToJson(YearlyRebate data) => json.encode(data.toJson());

class YearlyRebate {
  int count;
  bool hasNext;
  bool hasPrevious;
  List<Result> results;

  YearlyRebate({
    this.count,
    this.hasNext,
    this.hasPrevious,
    this.results,
  });

  factory YearlyRebate.fromJson(Map<String, dynamic> json) => YearlyRebate(
        count: json['count'],
        hasNext: json['has_next'],
        hasPrevious: json['has_previous'],
        results: List<Result>.from(
            json['results'].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'has_next': hasNext,
        'has_previous': hasPrevious,
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int monthId;
  int year;
  dynamic bill;
  int expenses;
  int rebate;
  int startDate;

  Result({
    this.monthId,
    this.year,
    this.bill,
    this.expenses,
    this.rebate,
    this.startDate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        monthId: json['month_id'],
        year: json['year'],
        bill: json['bill'],
        expenses: json['expenses'],
        rebate: json['rebate'],
        startDate: json['start_date'],
      );

  Map<String, dynamic> toJson() => {
        'month_id': monthId,
        'year': year,
        'bill': bill,
        'expenses': expenses,
        'rebate': rebate,
        'start_date': startDate,
      };
}
