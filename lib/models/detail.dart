// To parse this JSON data, do
//
//     final confirm = confirmFromJson(jsonString);

import 'dart:convert';

Detail confirmFromJson(String str) => Detail.fromJson(json.decode(str));

String confirmToJson(Detail data) => json.encode(data.toJson());

class Detail {
  String detail;

  Detail({
    this.detail,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => new Detail(
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
      };
}
