// To parse this JSON data, do
//
//     final createLeave = createLeaveFromJson(jsonString);

import 'dart:convert';

CreateLeave createLeaveFromJson(String str) =>
    CreateLeave.fromJson(json.decode(str));

String createLeaveToJson(CreateLeave data) => json.encode(data.toJson());

class CreateLeave {
  int meal;

  CreateLeave({
    this.meal,
  });

  factory CreateLeave.fromJson(Map<String, dynamic> json) => CreateLeave(
        meal: json['meal'],
      );

  Map<String, dynamic> toJson() => {
        'meal': meal,
      };
}
