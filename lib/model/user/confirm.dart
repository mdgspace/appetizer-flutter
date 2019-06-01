// To parse this JSON data, do
//
//     final confirm = confirmFromJson(jsonString);

import 'dart:convert';

Confirm confirmFromJson(String str) => Confirm.fromJson(json.decode(str));

String confirmToJson(Confirm data) => json.encode(data.toJson());

class Confirm {
  String detail;

  Confirm({
    this.detail,
  });

  factory Confirm.fromJson(Map<String, dynamic> json) => new Confirm(
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
  };
}
