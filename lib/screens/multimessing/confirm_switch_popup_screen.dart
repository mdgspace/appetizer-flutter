import 'package:appetizer/colors.dart';
import 'package:appetizer/components/switch_confirmation_meal_card.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/services/multimessing/switch_meals.dart';
import 'package:appetizer/utils/get_week_id.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class ConfirmSwitchPopupScreen extends StatefulWidget {
  final String token;
  final int id;
  final DateTime mealStartDateTime;
  final String title;
  final Map<CircleAvatar, String> menuToWhichToBeSwitched;
  final String dailyItemsToWhichToBeSwitched;
  final DateTime selectedDateTime;
  final String selectedHostelCode;

  const ConfirmSwitchPopupScreen({
    Key key,
    this.token,
    this.id,
    this.mealStartDateTime,
    this.title,
    this.menuToWhichToBeSwitched,
    this.dailyItemsToWhichToBeSwitched,
    this.selectedDateTime,
    this.selectedHostelCode,
  }) : super(key: key);

  @override
  _ConfirmSwitchPopupScreenState createState() =>
      _ConfirmSwitchPopupScreenState();
}

class _ConfirmSwitchPopupScreenState extends State<ConfirmSwitchPopupScreen> {
  static final double _radius = 16;
  int currentHostelMealId;

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

  TextStyle getSwitchToOrFromStyle() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm Meal Switch",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: Container(),
        backgroundColor: appiBrown,
        centerTitle: true,
      ),
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
                  currentHostelMealId = mealMenu.id;
                  setMealFromWhichToBeSwitchedComponents(mealMenu);
                  mealFromWhichToBeSwitchedMap = Map.fromIterables(
                    mealFromWhichToBeSwitchedLeadingImageList,
                    mealFromWhichToBeSwitchedItemsList,
                  );
                }
              });
            });

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Switch From",
                          style: getSwitchToOrFromStyle(),
                        ),
                      ),
                      SwitchConfirmationMealCard(
                        token: widget.token,
                        id: widget.id,
                        title: widget.title,
                        menuItems: mealFromWhichToBeSwitchedMap,
                        dailyItems: mealFromWhichToBeSwitchedDailyItems,
                        mealStartDateTime: widget.mealStartDateTime,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/switch_active.png",
                            scale: 1.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Switch To",
                          style: getSwitchToOrFromStyle(),
                        ),
                      ),
                      SwitchConfirmationMealCard(
                        token: widget.token,
                        id: widget.id,
                        title: widget.title,
                        menuItems: widget.menuToWhichToBeSwitched,
                        dailyItems: widget.dailyItemsToWhichToBeSwitched,
                        mealStartDateTime: widget.mealStartDateTime,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                color: appiYellow,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "SWITCH",
                              style: TextStyle(
                                color: appiYellow,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              switchMeals(
                                currentHostelMealId,
                                widget.selectedHostelCode,
                                widget.token,
                              ).then((switchResponse) {
                                SharedPreferences.getInstance().then((prefs) {
                                  prefs.setString(
                                      "secretKey", switchResponse.secretCode);
                                });
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
