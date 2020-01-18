import 'package:appetizer/colors.dart';
import 'package:appetizer/components/switch_confirmation_meal_card.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/utils/get_week_id.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class ConfirmSwitchPopupScreen extends StatefulWidget {
  final String token;
  final int id;
  final String title;
  final Map<CircleAvatar, String> menuToWhichToBeSwitched;
  final String dailyItemsToWhichToBeSwitched;
  final DateTime selectedDateTime;

  const ConfirmSwitchPopupScreen({
    Key key,
    this.token,
    this.id,
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
  Meal mealFromWhichToBeSwitched;

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

  void setMealFromWhichToBeSwitchedComponents() {
    for (var j = 0; j < mealFromWhichToBeSwitched.items.length; j++) {
      var mealItem = mealFromWhichToBeSwitched.items[j].name;
      mealFromWhichToBeSwitchedItemsList.add(mealItem);
      setLeadingMealImage(mealFromWhichToBeSwitchedLeadingImageList);
    }
  }

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
              dayMenu.meals.forEach((mealMenu) {
                if (mealMenu.id == widget.id) {
                  mealFromWhichToBeSwitched = mealMenu;
                }
              });
            });

            setMealFromWhichToBeSwitchedComponents();
            mealFromWhichToBeSwitchedMap = Map.fromIterables(
                mealFromWhichToBeSwitchedLeadingImageList,
                mealFromWhichToBeSwitchedItemsList);

            return Column(
              children: <Widget>[
                SwitchConfirmationMealCard(
                  token: widget.token,
                  id: widget.id,
                  title: widget.title,
                  menuItems: mealFromWhichToBeSwitchedMap,
                  dailyItems: mealFromWhichToBeSwitchedDailyItems,
                ),
                SwitchConfirmationMealCard(
                  token: widget.token,
                  id: widget.id,
                  title: widget.title,
                  menuItems: widget.menuToWhichToBeSwitched,
                  dailyItems: widget.dailyItemsToWhichToBeSwitched,
                )
              ],
            );
          }
        },
      ),
    );
  }
}
