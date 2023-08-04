import 'dart:convert';

Switch switchFromJson(String str) => Switch.fromJson(json.decode(str));

String switchToJson(Switch data) => json.encode(data.toJson());

class Switch {
  int id;
  int toMeal;
  String secretCode;
  String status;

  Switch({
    required this.id,
    required this.toMeal,
    required this.secretCode,
    required this.status,
  });

  factory Switch.fromJson(Map<String, dynamic> json) => Switch(
        id: json['id'],
        toMeal: json['to_meal'],
        secretCode: json['secret_code'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'to_meal': toMeal,
        'secret_code': secretCode,
        'status': status,
      };
}
