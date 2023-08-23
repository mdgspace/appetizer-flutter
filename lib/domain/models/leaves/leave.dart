import 'package:freezed_annotation/freezed_annotation.dart';
part 'leave.freezed.dart';
part 'leave.g.dart';

@freezed
class Leave with _$Leave {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Leave({
    required int id,
    required DateTime dateCreated,
    required String startMealType,
    required String endMealType,
    required DateTime startDatetime,
    required DateTime endDatetime,
    required int mealCount,
    required String status,
  }) = _Leave;

  factory Leave.fromJson(Map<String, dynamic> json) => _$LeaveFromJson(json);
}