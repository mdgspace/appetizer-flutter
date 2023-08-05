import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/models/menu/week_menu.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/DayDateBar/day_date_bar.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/YourMealMenuCard/your_meal_menu_card.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/your_meal_daily_cards_combined.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/your_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MealItem dmi = MealItem(
      id: 1,
      type: MealItemType.SLD,
      name: "dummy daily meal item SLD",
    );
    MealItem dnmi = MealItem(
      id: 2,
      type: MealItemType.STR,
      name: "dummy str type meal item",
    );
    List<MealItem> ddmi = [dmi];
    DailyItems ddi = DailyItems(
      id: 1,
      breakfast: ddmi,
      lunch: ddmi,
      dinner: ddmi,
      snack: ddmi,
    );
    Meal dummlb = Meal(
      id: 1,
      type: MealType.B,
      items: [dnmi],
      startTime: DateTime(2023, 8, 5, 9, 30),
      endTime: DateTime(2023, 8, 5, 10, 30),
      leaveStatus: LeaveStatus(id: 1, status: LeaveStatusEnum.N),
      wastage: 0,
      isSwitchable: false,
      switchStatus: SwitchStatus(id: 1, status: SwitchStatusEnum.D),
      isOutdated: false,
      isLeaveToggleOutdated: false,
      isCouponOutdated: true,
      startDateTime: DateTime(2023, 8, 5, 9, 30),
      endDateTime: DateTime(2023, 8, 5, 10, 30),
      couponStatus: CouponStatus(
        id: 1,
        status: CouponStatusEnum.N,
      ),
    );
    Meal dummll = Meal(
      id: 1,
      type: MealType.L,
      items: [dnmi],
      startTime: DateTime(2023, 8, 5, 9, 30),
      endTime: DateTime(2023, 8, 5, 10, 30),
      leaveStatus: LeaveStatus(id: 1, status: LeaveStatusEnum.N),
      wastage: 0,
      isSwitchable: false,
      switchStatus: SwitchStatus(id: 1, status: SwitchStatusEnum.D),
      isOutdated: false,
      isLeaveToggleOutdated: false,
      isCouponOutdated: true,
      startDateTime: DateTime(2023, 8, 5, 9, 30),
      endDateTime: DateTime(2023, 8, 5, 10, 30),
      couponStatus: CouponStatus(
        id: 1,
        status: CouponStatusEnum.N,
      ),
    );
    Meal dummld = Meal(
      id: 1,
      type: MealType.D,
      items: [dnmi],
      startTime: DateTime(2023, 8, 5, 9, 30),
      endTime: DateTime(2023, 8, 5, 10, 30),
      leaveStatus: LeaveStatus(id: 1, status: LeaveStatusEnum.N),
      wastage: 0,
      isSwitchable: false,
      switchStatus: SwitchStatus(id: 1, status: SwitchStatusEnum.D),
      isOutdated: false,
      isLeaveToggleOutdated: false,
      isCouponOutdated: true,
      startDateTime: DateTime(2023, 8, 5, 9, 30),
      endDateTime: DateTime(2023, 8, 5, 10, 30),
      couponStatus: CouponStatus(
        id: 1,
        status: CouponStatusEnum.N,
      ),
    );
    List<Meal> dml = [dummlb, dummll, dummld];
    DayMenu dumdam = DayMenu(
      id: 1,
      dayId: 1,
      date: DateTime(2023, 1, 1),
      meals: dml,
    );
    List<DayMenu> ddm = [
      dumdam,
    ];
    for (int i = 1; i < 7; i++) {
      dumdam.id = i + 1;
      dumdam.date = DateTime(2023, 1, i + 1);
      ddm.add(dumdam);

      print(ddm[i].date.day);
    }
    WeekMenu dummy = WeekMenu(
        weekId: 1,
        year: 2023,
        name: "name",
        dailyItems: ddi,
        dayMenus: ddm,
        isApproved: true);
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: Container(
          color: AppTheme.green,
          child: YourWeekMenu(weekMenu: dummy),
        ),
      ),
    );
  }
}
