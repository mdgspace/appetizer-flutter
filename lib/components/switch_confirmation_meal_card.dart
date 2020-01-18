import 'package:appetizer/colors.dart';
import 'package:appetizer/utils/month_int_to_month_string.dart';
import 'package:appetizer/utils/week_day_int_to_full_day_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SwitchConfirmationMealCard extends StatefulWidget {
  final String token;
  final int id;
  final String title;
  final Map<CircleAvatar, String> menuItems;
  final String dailyItems;
  final DateTime mealStartDateTime;

  const SwitchConfirmationMealCard({
    Key key,
    this.token,
    this.id,
    this.title,
    this.menuItems,
    this.dailyItems,
    this.mealStartDateTime,
  }) : super(key: key);

  @override
  _SwitchConfirmationMealCardState createState() =>
      _SwitchConfirmationMealCardState();
}

class _SwitchConfirmationMealCardState
    extends State<SwitchConfirmationMealCard> {
  List<Widget> _itemWidgetList() {
    List<Widget> list = [];
    widget.menuItems.forEach((icon, string) {
      list.add(_menuListItem(string, icon));
    });
    return list;
  }

  Widget _menuListItem(String itemName, CircleAvatar foodIcon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 4.0),
          child: Column(
            children: <Widget>[
              foodIcon,
              SizedBox(
                height: 8.0,
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemName,
                ),
                Divider(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getDayAndDateForCard() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String mealDateTimeString =
        widget.mealStartDateTime.toString().substring(0, 10) + ' 00:00:00';
    DateTime mealDateTime = dateFormat.parse(mealDateTimeString);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Column(
        children: <Widget>[
          Text(
            weekDayIntToWeekDayFullName(mealDateTime.weekday),
          ),
          Text(
            monthIntToMonthString(mealDateTime.month) +
                " " +
                mealDateTime.day.toString() +
                "," +
                mealDateTime.year.toString(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  widget.title,
                                  style: new TextStyle(
                                      color: appiYellow, fontSize: 24),
                                ),
                                getDayAndDateForCard(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: _itemWidgetList(),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        color: Color(0xffF4F4F4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Daily Items: ${widget.dailyItems}',
                            style:
                                TextStyle(color: Color.fromRGBO(0, 0, 0, .54)),
                          ),
                        )),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
