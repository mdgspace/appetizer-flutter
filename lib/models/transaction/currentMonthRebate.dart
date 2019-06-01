// To parse this JSON data, do
//
//     final monthlyRebate = monthlyRebateFromJson(jsonString);

import 'dart:convert';

MonthlyRebate monthlyRebateFromJson(String str) => MonthlyRebate.fromJson(json.decode(str));

String monthlyRebateToJson(MonthlyRebate data) => json.encode(data.toJson());

class MonthlyRebate {
  int rebate;

  MonthlyRebate({
    this.rebate,
  });

  factory MonthlyRebate.fromJson(Map<String, dynamic> json) => new MonthlyRebate(
    rebate: json["rebate"],
  );

  Map<String, dynamic> toJson() => {
    "rebate": rebate,
  };
}
