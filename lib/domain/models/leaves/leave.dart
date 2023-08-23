import 'package:freezed_annotation/freezed_annotation.dart';
part 'leave.freezed.dart';
part 'leave.g.dart';

@freezed
class Leave with _$Leave {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Leave({
    required int id,
    @JsonKey(name: 'date_created')
    required DateTime dateCreated,
    @JsonKey(name: 'start_meal_type')
    required String startMealType,
    @JsonKey(name: 'end_meal_type')
    required String endMealType,
    @JsonKey(name: 'start_datetime')
    required DateTime startDatetime,
    @JsonKey(name: 'end_datetime')
    required DateTime endDatetime,
    @JsonKey(name: 'meal_count')
    required int mealCount,
    required String status,
  }) = _Leave;

  factory Leave.fromJson(Map<String, dynamic> json) => _$LeaveFromJson(json);
}