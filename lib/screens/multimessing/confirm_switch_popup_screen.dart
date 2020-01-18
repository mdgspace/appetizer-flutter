import 'package:appetizer/colors.dart';
import 'package:appetizer/components/switch_confirmation_meal_card.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/utils/get_week_id.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:intl/intl.dart';

class ConfirmSwitchPopupScreen extends StatefulWidget {
  final String token;
  final int id;
  final DateTime mealStartDateTime;
  final String title;
  final Map<CircleAvatar, String> menuToWhichToBeSwitched;
  final String dailyItemsToWhichToBeSwitched;
  final DateTime selectedDateTime;

  const ConfirmSwitchPopupScreen({
    Key key,
    this.token,
    this.id,
    this.mealStartDateTime,
    this.title,
    this.menuToWhichToBeSwitched,
    this.dailyItemsToWhichToBeSwitched,
    this.selectedDateTime,
  }) : super(key: key);

  @override
  _ConfirmSwitchPopupScreenState createState() =>
      _ConfirmSwitchPopupScreenState();
}

class _ConfirmSwitchPopupScreenState extends State<ConfirmSwitchPopupScreen> {
  static final double _radius = 16;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  List<CircleAvatar> mealFromWhichToBeSwitchedLeadingImageList = [];
  List<String> mealFromWhichToBeSwitchedItemsList = [];
  Map<CircleAvatar, String> mealFromWhichToBeSwitchedMap = {};
  String mealFromWhichToBeSwitchedDailyItems = '';

  void setLeadingMealImage(List<CircleAvatar> mealLeadingImageList) {
    var randomColor =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(0.2);
    mealLeadingImageList.add(CircleAvatar(
      radius: _radius,
      backgroundColor: randomColor,
    ));
  }

  void setMealFromWhichToBeSwitchedComponents(Meal mealFromWhichToBeSwitched) {
    mealFromWhichToBeSwitchedItemsList = [];
    mealFromWhichToBeSwitchedLeadingImageList = [];
    for (var j = 0; j < mealFromWhichToBeSwitched.items.length; j++) {
      var mealItem = mealFromWhichToBeSwitched.items[j].name;
      mealFromWhichToBeSwitchedItemsList.add(mealItem);
      setLeadingMealImage(mealFromWhichToBeSwitchedLeadingImageList);
    }
  }

  Map<String, MealType> titleToMealTypeMap = {
    "Breakfast": MealType.B,
    "Lunch": MealType.L,
    "Snacks": MealType.S,
    "Dinner": MealType.D,
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: menuWeek(widget.token, getWeekNumber(widget.selectedDateTime)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
                ),
              ),
            );
          } else {
            snapshot.data.days.forEach((dayMenu) {
              String mealDateString = dayMenu.date.toString().substring(0, 10);
              dayMenu.meals.forEach((mealMenu) {
                if (mealDateString ==
                        widget.mealStartDateTime.toString().substring(0, 10) &&
                    titleToMealTypeMap[widget.title] == mealMenu.type) {
                  setMealFromWhichToBeSwitchedComponents(mealMenu);
                  mealFromWhichToBeSwitchedMap = Map.fromIterables(
                    mealFromWhichToBeSwitchedLeadingImageList,
                    mealFromWhichToBeSwitchedItemsList,
                  );
                }
              });
            });

            return SafeArea(
              child: Column(
                children: <Widget>[
                  Text("Switch From"),
                  SwitchConfirmationMealCard(
                    token: widget.token,
                    id: widget.id,
                    title: widget.title,
                    menuItems: mealFromWhichToBeSwitchedMap,
                    dailyItems: mealFromWhichToBeSwitchedDailyItems,
                  ),
                  Image.asset("assets/icons/switch_active.png"),
                  Text("Switch To"),
                  SwitchConfirmationMealCard(
                    token: widget.token,
                    id: widget.id,
                    title: widget.title,
                    menuItems: widget.menuToWhichToBeSwitched,
                    dailyItems: widget.dailyItemsToWhichToBeSwitched,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text("CANCEL"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("SWITCH"),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
