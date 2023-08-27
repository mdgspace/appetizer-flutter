import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:appetizer/domain/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/presentation/coupons/coupons_view.dart';
import 'package:appetizer/presentation/leaves_and_rebate/leaves_and_rebate.dart';
import 'package:appetizer/presentation/profile/profile_view.dart';
import 'package:appetizer/utils/local_storage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const AppetizerApp(),
    ),
  );
}

class AppetizerApp extends StatelessWidget {
  const AppetizerApp({super.key});

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
    User baka = User(
        email: 'nishtha_k@iitr.ch.ac.in',
        hostelName: 'Himalaya Bhawan',
        hostelCode: 'HB',
        enrNo: 21115095,
        name: 'Nishtha Kaura',
        contactNo: '810333423',
        branch: 'EED',
        imageUrl: 'imageUrl',
        isCheckedOut: false,
        dob: '12-06-1998',
        degree: 'B Tech',
        admissionYear: '2021',
        isNew: false);

    PaginatedLeaves dummyLeaves = PaginatedLeaves.fromJson({
      "count": 1,
      "has_next": false,
      "has_previous": false,
      "results": [
        {
          "id": 51,
          "date_created": 1675078095318,
          "start_meal_type": "Dinner",
          "start_datetime": 1675260000000,
          "status": "P",
          "meal_count": 1,
          "end_meal_type": "Dinner",
          "end_datetime": 1675260000000
        }
      ]
    });
    PaginatedYearlyRebate dummyRebate = PaginatedYearlyRebate.fromJson({
      "count": 3,
      "has_next": false,
      "has_previous": false,
      "results": [
        {
          "month_id": 8,
          "year": 2023,
          "bill": null,
          "expenses": 0,
          "rebate": 0,
          "start_date": 1690828200000
        },
        {
          "month_id": 2,
          "year": 2023,
          "bill": null,
          "expenses": 0,
          "rebate": 0,
          "start_date": 1675189800000
        },
        {
          "month_id": 1,
          "year": 2023,
          "bill": null,
          "expenses": 0,
          "rebate": 0,
          "start_date": 1672511400000
        }
      ]
    });
    int mealsSkipped = 1, remainingLeaves = 104;
    // return MaterialApp(
    //   home: ProfilePage(
    //     data: baka,
    //   ),
    // );
    return const MaterialApp(
      home: CouponsPage(),
    );
    // return MaterialApp(
    //   home: Scaffold(
    // body: LeavesAndRebate(
    //       isCheckedOut: false,
    //       initialYearlyRebates: dummyRebate,
    //       mealsSkipped: mealsSkipped,
    //       remainingLeaves: remainingLeaves,
    //       currYearLeaves: dummyLeaves,
    //     ),
    //   ),
    // );
  }
}
