import 'package:json_annotation/json_annotation.dart';

part 'switchable_meal.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SwitchableMeal {
  int id;
  String type;
  List<Item> items;
  String startTime;
  String endTime;
  String leaveStatus;
  dynamic wastage;
  String hostelName;

  SwitchableMeal({
    required this.id,
    required this.type,
    required this.items,
    required this.startTime,
    required this.endTime,
    required this.leaveStatus,
    required this.wastage,
    required this.hostelName,
  });

  factory SwitchableMeal.fromJson(Map<String, dynamic> json) =>
      _$SwitchableMealFromJson(json);

  Map<String, dynamic> toJson() => _$SwitchableMealToJson(this);
}

@JsonSerializable()
class Item {
  int id;
  String type;
  String name;

  Item({
    required this.id,
    required this.type,
    required this.name,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
