import 'dart:convert';

PaginatedYearlyRebate paginatedYearlyRebateFromJson(String str) =>
    PaginatedYearlyRebate.fromJson(json.decode(str));

String paginatedYearlyRebateToJson(PaginatedYearlyRebate data) =>
    json.encode(data.toJson());

class PaginatedYearlyRebate {
  int count;
  bool hasNext;
  bool hasPrevious;
  List<YearlyRebate> results;

  PaginatedYearlyRebate({
    this.count,
    this.hasNext,
    this.hasPrevious,
    this.results,
  });

  factory PaginatedYearlyRebate.fromJson(Map<String, dynamic> json) =>
      PaginatedYearlyRebate(
        count: json['count'],
        hasNext: json['has_next'],
        hasPrevious: json['has_previous'],
        results: List<YearlyRebate>.from(
            json['results'].map((x) => YearlyRebate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'has_next': hasNext,
        'has_previous': hasPrevious,
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class YearlyRebate {
  int monthId;
  int year;
  dynamic bill;
  int expenses;
  int rebate;
  int startDate;

  YearlyRebate({
    this.monthId,
    this.year,
    this.bill,
    this.expenses,
    this.rebate,
    this.startDate,
  });

  factory YearlyRebate.fromJson(Map<String, dynamic> json) => YearlyRebate(
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
