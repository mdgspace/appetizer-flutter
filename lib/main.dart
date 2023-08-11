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

      // print(ddm[i].date.day);
    }
    WeekMenu dummy = WeekMenu(
        weekId: 1,
        year: 2023,
        name: "name",
        dailyItems: ddi,
        dayMenus: ddm,
        isApproved: true);
    WeekMenu menu = WeekMenu.fromJson({
      "week_id": 32,
      "year": 2023,
      "name": null,
      "daily_items": {
        "id": 13,
        "breakfast": [
          {"id": 1, "type": "sld", "name": "Bread/Butter"},
          {"id": 8, "type": "sld", "name": "Jalebi"}
        ],
        "lunch": [
          {"id": 9, "type": "sld", "name": "Dosa"}
        ],
        "dinner": [
          {"id": 12, "type": "sld", "name": "Chappti"}
        ],
        "snack": []
      },
      "days": [
        {
          "id": 66,
          "day_id": 0,
          "date": "2023-08-07",
          "meals": [
            {
              "id": 180,
              "type": "B",
              "items": [
                {"id": 1, "type": "sld", "name": "Bread/Butter"}
              ],
              "start_time": "07:30:00",
              "end_time": "09:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 181,
              "type": "L",
              "items": [
                {"id": 9, "type": "sld", "name": "Dosa"}
              ],
              "start_time": "12:30:00",
              "end_time": "14:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 182,
              "type": "D",
              "items": [
                {"id": 15, "type": "sld", "name": "Roti"}
              ],
              "start_time": "19:30:00",
              "end_time": "21:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            }
          ]
        },
        {
          "id": 67,
          "day_id": 1,
          "date": "2023-08-08",
          "meals": [
            {
              "id": 183,
              "type": "B",
              "items": [
                {"id": 9, "type": "sld", "name": "Dosa"}
              ],
              "start_time": "07:30:00",
              "end_time": "09:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 184,
              "type": "L",
              "items": [
                {"id": 1, "type": "sld", "name": "Bread/Butter"}
              ],
              "start_time": "12:30:00",
              "end_time": "14:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            }
          ]
        },
        {
          "id": 68,
          "day_id": 2,
          "date": "2023-08-09",
          "meals": [
            {
              "id": 185,
              "type": "D",
              "items": [
                {"id": 1, "type": "sld", "name": "Bread/Butter"}
              ],
              "start_time": "19:30:00",
              "end_time": "21:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            }
          ]
        },
        {
          "id": 69,
          "day_id": 3,
          "date": "2023-08-10",
          "meals": [
            {
              "id": 186,
              "type": "B",
              "items": [
                {"id": 1, "type": "sld", "name": "Bread/Butter"}
              ],
              "start_time": "07:30:00",
              "end_time": "09:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 187,
              "type": "L",
              "items": [
                {"id": 15, "type": "sld", "name": "Roti"}
              ],
              "start_time": "12:30:00",
              "end_time": "14:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 188,
              "type": "D",
              "items": [
                {"id": 9, "type": "sld", "name": "Dosa"}
              ],
              "start_time": "19:30:00",
              "end_time": "21:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            }
          ]
        },
        {
          "id": 70,
          "day_id": 4,
          "date": "2023-08-11",
          "meals": [
            {
              "id": 189,
              "type": "B",
              "items": [
                {"id": 1, "type": "sld", "name": "Bread/Butter"},
                {"id": 9, "type": "sld", "name": "Dosa"}
              ],
              "start_time": "07:30:00",
              "end_time": "09:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 190,
              "type": "L",
              "items": [
                {"id": 6, "type": "sld", "name": "Paratha"}
              ],
              "start_time": "12:30:00",
              "end_time": "14:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 191,
              "type": "D",
              "items": [
                {"id": 12, "type": "sld", "name": "Chappti"}
              ],
              "start_time": "19:30:00",
              "end_time": "21:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            }
          ]
        },
        {
          "id": 71,
          "day_id": 5,
          "date": "2023-08-12",
          "meals": [
            {
              "id": 192,
              "type": "B",
              "items": [
                {"id": 6, "type": "sld", "name": "Paratha"}
              ],
              "start_time": "07:30:00",
              "end_time": "09:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 193,
              "type": "L",
              "items": [
                {"id": 1, "type": "sld", "name": "Bread/Butter"},
                {"id": 9, "type": "sld", "name": "Dosa"}
              ],
              "start_time": "12:30:00",
              "end_time": "14:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 194,
              "type": "D",
              "items": [
                {"id": 12, "type": "sld", "name": "Chappti"}
              ],
              "start_time": "19:30:00",
              "end_time": "21:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            }
          ]
        },
        {
          "id": 72,
          "day_id": 6,
          "date": "2023-08-13",
          "meals": [
            {
              "id": 195,
              "type": "B",
              "items": [
                {"id": 6, "type": "sld", "name": "Paratha"}
              ],
              "start_time": "07:30:00",
              "end_time": "09:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 196,
              "type": "L",
              "items": [
                {"id": 12, "type": "sld", "name": "Chappti"}
              ],
              "start_time": "12:30:00",
              "end_time": "14:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            },
            {
              "id": 197,
              "type": "D",
              "items": [
                {"id": 1, "type": "sld", "name": "Bread/Butter"},
                {"id": 9, "type": "sld", "name": "Dosa"}
              ],
              "start_time": "19:30:00",
              "end_time": "21:00:00",
              "leave_status": {"status": "N"},
              "coupon_status": {"status": "N"},
              "wastage": null
            }
          ]
        }
      ],
      "is_approved": true
    });
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: Container(
          child: // Text("hello")
              YourWeekMenu(weekMenu: menu, isCheckedOut: false),
        ),
      ),
    );
  }
}
