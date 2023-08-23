import 'dart:convert';

Coupon notificationFromJson(String str) =>
    Coupon.fromJson(json.decode(str));

String notificationToJson(Coupon data) => json.encode(data.toJson());

class Coupon {
  int id;
  String meal;
  String title;

  Coupon({
    required this.id,
    required this.meal,
    required this.title,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json['id'],
        meal: json['meal'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'meal': meal,
        'title': title,
      };
}
