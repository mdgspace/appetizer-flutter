// To parse this JSON data, do
//
//     final responses = responsesFromJson(jsonString);

import 'dart:convert';

List<Response> responseFromJson(String str) =>
    List<Response>.from(json.decode(str).map((x) => Response.fromJson(x)));
//Response responsesFromJson(String str) => Response.fromJson(json.decode(str));
String responsesToJson(Response data) => json.encode(data.toJson());

class Response {
  String message;
  bool isRead;
  int dateCreated;

  Response({
    this.message,
    this.isRead,
    this.dateCreated,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
