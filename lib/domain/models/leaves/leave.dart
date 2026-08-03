import 'package:freezed_annotation/freezed_annotation.dart';
part 'leave.freezed.dart';
part 'leave.g.dart';

DateTime apiDateTimeFromJson(dynamic value) {
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
  if (value is num) {
    return DateTime.fromMillisecondsSinceEpoch(value.toInt());
  }
  if (value is String) {
    return DateTime.parse(value);
  }
  throw FormatException('Invalid datetime value: $value');
}

dynamic apiDateTimeToJson(DateTime value) => value.millisecondsSinceEpoch;

@freezed
class Leave with _$Leave {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Leave({
    required int id,
    @JsonKey(fromJson: apiDateTimeFromJson, toJson: apiDateTimeToJson)
    required DateTime dateCreated,
    required String startMealType,
    required String endMealType,
    @JsonKey(fromJson: apiDateTimeFromJson, toJson: apiDateTimeToJson)
    required DateTime startDatetime,
    @JsonKey(fromJson: apiDateTimeFromJson, toJson: apiDateTimeToJson)
    required DateTime endDatetime,
    required int mealCount,
    required String status,
  }) = _Leave;

  factory Leave.fromJson(Map<String, dynamic> json) => _$LeaveFromJson(json);
}
