import 'package:appetizer/enums/enum_values.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'week_menu.freezed.dart';
part 'week_menu.g.dart';

// TODO: remove enums from this file
// TODO: check for DateTime parsing (different in different api)

@freezed
class WeekMenu with _$WeekMenu {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory WeekMenu({
    required int weekId,
    required int year,
    required dynamic name,
    String? hostelName,
    required DailyItems dailyItems,
    @JsonKey(name: 'days') required List<DayMenu> dayMenus,
    required bool isApproved,
  }) = _WeekMenu;

  factory WeekMenu.fromJson(Map<String, dynamic> json) =>
      _$WeekMenuFromJson(json);
}

@freezed
class DailyItems with _$DailyItems {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory DailyItems({
    required int id,
    required List<MealItem> breakfast,
    required List<MealItem> lunch,
    required List<MealItem> dinner,
    List<MealItem>? snack,
  }) = _DailyItems;

  factory DailyItems.fromJson(Map<String, dynamic> json) =>
      _$DailyItemsFromJson(json);
}

@freezed
class MealItem with _$MealItem {
  @JsonSerializable()
  const factory MealItem({
    required int id,
    required MealItemType type,
    required String name,
  }) = _MealItem;

  factory MealItem.fromJson(Map<String, dynamic> json) =>
      _$MealItemFromJson(json);
}

enum MealItemType { MCL, SLD, EXT, MCD, STR, SNK, CPN }

final breakfastTypeValues = EnumValues({
  'ext': MealItemType.EXT,
  'mcd': MealItemType.MCD,
  'mcl': MealItemType.MCL,
  'sld': MealItemType.SLD,
  'snk': MealItemType.SNK,
  'str': MealItemType.STR,
  'cpn': MealItemType.CPN,
});

@freezed
class DayMenu with _$DayMenu {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const DayMenu._();

  factory DayMenu({
    required int id,
    required int dayId,
    required DateTime date,
    required List<Meal> meals,
  }) = _DayMenu;

  // TODO: check if mealMap is parsed correctly
  Map<MealType, Meal> get mealMap {
    Map<MealType, Meal> mealMap = {};
    for (var meal in meals) {
      mealMap[meal.type] = meal;
    }
    return mealMap;
  }

  factory DayMenu.fromJson(Map<String, dynamic> json) =>
      _$DayMenuFromJson(json);
}

@freezed
class Meal with _$Meal {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const Meal._();

  const factory Meal({
    required int id,
    required MealType type,
    CostType? costType,
    required List<MealItem> items,
    @DateTimeSerializer() required DateTime startTime,
    @DateTimeSerializer() required DateTime endTime,
    required LeaveStatus leaveStatus,
    required CouponStatus couponStatus,
    required dynamic wastage,
    @Default(false) bool isSwitchable,
    required SwitchStatus switchStatus,
    String? hostelName,
    String? secretCode,
    // TODO: write getters
    // required bool isOutdated,
    // required bool isLeaveToggleOutdated,
    // required bool isCouponOutdated,
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) = _Meal;

  String get title {
    switch (type) {
      case MealType.B:
        return 'Breakfast';
      case MealType.L:
        return 'Lunch';
      case MealType.S:
        return 'Snacks';
      case MealType.D:
        return 'Dinner';
      default:
        return 'Meal';
    }
  }

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}

class DateTimeSerializer implements JsonConverter<DateTime, String> {
  const DateTimeSerializer();

  @override
  DateTime fromJson(String json) => DateFormat('HH:mm:ss').parse(json);

  @override
  String toJson(DateTime object) => DateFormat('HH:mm:ss').format(object);
}

@freezed
class LeaveStatus with _$LeaveStatus {
  const factory LeaveStatus({
    int? id,
    @Default(LeaveStatusEnum.N) LeaveStatusEnum status,
  }) = _LeaveStatus;

  factory LeaveStatus.fromJson(Map<String, dynamic> json) =>
      _$LeaveStatusFromJson(json);
}

@freezed
class CouponStatus with _$CouponStatus {
  const factory CouponStatus({
    int? id,
    @Default(CouponStatusEnum.N) CouponStatusEnum status,
  }) = _CouponStatus;

  factory CouponStatus.fromJson(Map<String, dynamic> json) =>
      _$CouponStatusFromJson(json);
}

@freezed
class SwitchStatus with _$SwitchStatus {
  const factory SwitchStatus({
    int? id,
    @Default(SwitchStatusEnum.N) SwitchStatusEnum status,
  }) = _SwitchStatus;

  factory SwitchStatus.fromJson(Map<String, dynamic> json) =>
      _$SwitchStatusFromJson(json);
}

enum LeaveStatusEnum { N, A, D, P, U }

enum CouponStatusEnum { N, A }

final couponStatusValues = EnumValues({
  'N': CouponStatusEnum.N,
  'A': CouponStatusEnum.A,
});

final leaveStatusValues = EnumValues({
  'N': LeaveStatusEnum.N,
  'A': LeaveStatusEnum.A,
  'D': LeaveStatusEnum.D,
  'P': LeaveStatusEnum.P,
  'U': LeaveStatusEnum.U
});

enum SwitchStatusEnum { N, A, D, F, T, U }

final switchStatusValues = EnumValues({
  'N': SwitchStatusEnum.N,
  'A': SwitchStatusEnum.A,
  'D': SwitchStatusEnum.D,
  'F': SwitchStatusEnum.F,
  'T': SwitchStatusEnum.T,
  'U': SwitchStatusEnum.U
});

enum CostType { N, S }

final costTypeValues = EnumValues({'N': CostType.N, 'S': CostType.S});

enum MealType { B, L, S, D }

final mealTypeValues = EnumValues(
    {'B': MealType.B, 'D': MealType.D, 'L': MealType.L, 'S': MealType.S});
