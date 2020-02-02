import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/menu/meals_menu_cards.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayMenuNew extends StatefulWidget {
  final Day day;
  final DailyItems dailyItems;
  final String selectedHostelCode;
  DayMenuNew(this.day, this.dailyItems, this.selectedHostelCode);

  @override
  _DayMenuNewState createState() => _DayMenuNewState();
}

class _DayMenuNewState extends State<DayMenuNew> {
  InheritedData inheritedData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        (widget.day.mealMap[MealType.B] != null)
            ? ((hostelCodeMap[inheritedData.userDetails.hostelName] ==
                    widget.selectedHostelCode)
                ? YourMealsMenuCardNew(
                    widget.day.mealMap[MealType.B], widget.dailyItems)
                : OtherMealsMenuCardNew(
                    widget.day.mealMap[MealType.B], widget.dailyItems))
            : Container(),
        (widget.day.mealMap[MealType.L] != null)
            ? ((hostelCodeMap[inheritedData.userDetails.hostelName] ==
                    widget.selectedHostelCode)
                ? YourMealsMenuCardNew(
                    widget.day.mealMap[MealType.L], widget.dailyItems)
                : OtherMealsMenuCardNew(
                    widget.day.mealMap[MealType.L], widget.dailyItems))
            : Container(),
        (widget.day.mealMap[MealType.S] != null)
            ? ((hostelCodeMap[inheritedData.userDetails.hostelName] ==
                    widget.selectedHostelCode)
                ? YourMealsMenuCardNew(
                    widget.day.mealMap[MealType.S], widget.dailyItems)
                : OtherMealsMenuCardNew(
                    widget.day.mealMap[MealType.S], widget.dailyItems))
            : Container(),
        (widget.day.mealMap[MealType.D] != null)
            ? ((hostelCodeMap[inheritedData.userDetails.hostelName] ==
                    widget.selectedHostelCode)
                ? YourMealsMenuCardNew(
                    widget.day.mealMap[MealType.D], widget.dailyItems)
                : OtherMealsMenuCardNew(
                    widget.day.mealMap[MealType.D], widget.dailyItems))
            : Container(),
      ],
    );
  }
}
