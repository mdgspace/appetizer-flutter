import 'package:json_annotation/json_annotation.dart';

part 'switch.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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

  factory Switch.fromJson(Map<String, dynamic> json) => _$SwitchFromJson(json);

  Map<String, dynamic> toJson() => _$SwitchToJson(this);
}
