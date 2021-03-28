import 'dart:convert';

import 'package:appetizer/enums/enum_values.dart';
import 'package:intl/intl.dart';

class WeekMenu {
  int weekId;
  int year;
  dynamic name;
  String hostelName;
  DailyItems dailyItems;
  List<Day> days;
  bool isApproved;

  WeekMenu({
    this.weekId,
    this.year,
    this.name,
    this.hostelName,
    this.dailyItems,
    this.days,
    this.isApproved,
  });

  factory WeekMenu.fromJson(Map<String, dynamic> json) => WeekMenu(
        weekId: json['week_id'],
        year: json['year'],
        name: json['name'],
        hostelName: json['hostel_name'],
        dailyItems: DailyItems.fromJson(json['daily_items']),
        days: List<Day>.from(json['days'].map((x) => Day.fromJson(x))),
        isApproved: json['is_approved'],
      );

  Map<String, dynamic> toJson() => {
        'week_id': weekId,
        'year': year,
        'name': name,
        'hostel_name': hostelName,
        'daily_items': dailyItems.toJson(),
        'days': List<dynamic>.from(days.map((x) => x.toJson())),
        'is_approved': isApproved,
      };
}

class DailyItems {
  int id;
  List<MealItem> breakfast;
  List<MealItem> lunch;
  List<MealItem> dinner;
  List<MealItem> snack;

  DailyItems({
    this.id,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snack,
  });

  factory DailyItems.fromJson(Map<String, dynamic> json) => DailyItems(
        id: json['id'],
        breakfast: List<MealItem>.from(
            json['breakfast'].map((x) => MealItem.fromJson(x))),
        lunch:
            List<MealItem>.from(json['lunch'].map((x) => MealItem.fromJson(x))),
        dinner: List<MealItem>.from(
            json['dinner'].map((x) => MealItem.fromJson(x))),
        snack:
            List<MealItem>.from(json['snack'].map((x) => MealItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'breakfast': List<dynamic>.from(breakfast.map((x) => x.toJson())),
        'lunch': List<dynamic>.from(lunch.map((x) => x.toJson())),
        'dinner': List<dynamic>.from(dinner.map((x) => x.toJson())),
        'snack': List<dynamic>.from(snack.map((x) => x.toJson())),
      };
}

List<MealItem> mealItemFromJson(String str) =>
    List<MealItem>.from(json.decode(str).map((x) => MealItem.fromJson(x)));

String mealItemToJson(List<MealItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MealItem {
  int id;
  MealItemType type;
  String name;

  MealItem({
    this.id,
    this.type,
    this.name,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) => MealItem(
        id: json['id'],
        type: breakfastTypeValues.map[json['type']],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': breakfastTypeValues.reverse[type],
        'name': name,
      };
}

enum MealItemType { MCL, SLD, EXT, MCD, STR, SNK }

final breakfastTypeValues = EnumValues({
  'ext': MealItemType.EXT,
  'mcd': MealItemType.MCD,
  'mcl': MealItemType.MCL,
  'sld': MealItemType.SLD,
  'snk': MealItemType.SNK,
  'str': MealItemType.STR
});

class Day {
  int id;
  int dayId;
  DateTime date;
  List<Meal> meals;
  Map<MealType, Meal> _mealMap;

  Day({
    this.id,
    this.dayId,
    this.date,
    this.meals,
  }) {
    _mealMap = {};
    meals.forEach((meal) {
      _mealMap[meal.type] = meal;
    });
  }

  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        id: json['id'],
        dayId: json['day_id'],
        date: DateTime.parse(json['date']),
        meals: List<Meal>.from(json['meals'].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'day_id': dayId,
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'meals': List<dynamic>.from(meals.map((x) => x.toJson())),
      };

  Map<MealType, Meal> get mealMap => _mealMap;
}

class Meal {
  int id;
  MealType type;
  CostType costType;
  List<MealItem> items;
  String startTime;
  String endTime;
  LeaveStatus leaveStatus;
  dynamic wastage;
  bool isSwitchable;
  SwitchStatus switchStatus;
  String hostelName;
  String secretCode;

  Meal({
    this.id,
    this.type,
    this.costType,
    this.items,
    this.startTime,
    this.endTime,
    this.leaveStatus,
    this.wastage,
    this.isSwitchable,
    this.switchStatus,
    this.hostelName,
    this.secretCode,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json['id'],
        type: mealTypeValues.map[json['type']],
        costType: costTypeValues.map[json['cost_type']],
        items:
            List<MealItem>.from(json['items'].map((x) => MealItem.fromJson(x))),
        startTime: json['start_time'],
        endTime: json['end_time'],
        leaveStatus: LeaveStatus.fromJson(json['leave_status']),
        wastage: json['wastage'],
        isSwitchable: json['is_switchable'],
        switchStatus: SwitchStatus.fromJson(json['switch_status']),
        hostelName: json['hostel_name'],
        secretCode: json['secret_code'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': mealTypeValues.reverse[type],
        'cost_type': costTypeValues.reverse[costType],
        'items': List<dynamic>.from(items.map((x) => x.toJson())),
        'start_time': startTime,
        'end_time': endTime,
        'leave_status': leaveStatus.toJson(),
        'wastage': wastage,
        'is_switchable': isSwitchable,
        'switch_status': switchStatus.toJson(),
        'hostel_name': hostelName,
        'secret_code': secretCode,
      };

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
    }
    print("Meal type didn't match returning 'Meal'");
    return 'Meal';
  }

  bool _isOutdated;

  bool get isOutdated => _isOutdated;

  set isOutdated(bool value) {
    _isOutdated = value;
  }

  bool _isLeaveToggleOutdated;

  bool get isLeaveToggleOutdated => _isLeaveToggleOutdated;

  set isLeaveToggleOutdated(bool value) {
    _isLeaveToggleOutdated = value;
  }

  bool get mealSwitchStatusBool =>
      switchStatus.status == SwitchStatusEnum.N ? true : false;

  bool get mealLeaveStatusBool =>
      leaveStatus.status == LeaveStatusEnum.N ? true : false;

  DateTime get startTimeObject => _timeFormat.parse(startTime);

  DateTime get endTimeObject => _timeFormat.parse(endTime);

  final DateFormat _timeFormat = DateFormat('HH:mm:ss');

  DateTime _startDateTime;

  DateTime get startDateTime => _startDateTime;

  set startDateTime(DateTime value) {
    _startDateTime = value;
  }

  DateTime _endDateTime;

  DateTime get endDateTime => _endDateTime;

  set endDateTime(DateTime value) {
    _endDateTime = value;
  }
}

class LeaveStatus {
  int id;
  LeaveStatusEnum status;

  LeaveStatus({
    this.id,
    this.status,
  });

  factory LeaveStatus.fromJson(Map<String, dynamic> json) => LeaveStatus(
        id: json['id'],
        status: leaveStatusValues.map[json['status']],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': leaveStatusValues.reverse[status],
      };
}

class SwitchStatus {
  int id;
  SwitchStatusEnum status;

  SwitchStatus({
    this.id,
    this.status,
  });

  factory SwitchStatus.fromJson(Map<String, dynamic> json) => SwitchStatus(
        id: json['id'],
        status: switchStatusValues.map[json['status']],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': switchStatusValues.reverse[status],
      };
}

enum LeaveStatusEnum { N, A, D, P, U }

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
