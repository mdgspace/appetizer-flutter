import 'package:appetizer/colors.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/utils/get_day_and_date_for_meal_card.dart';
import 'package:flutter/material.dart';

class SwitchConfirmationMealCard extends StatefulWidget {
  final Meal meal;
  final Map<CircleAvatar, String> menuItems;

  const SwitchConfirmationMealCard({
    Key key,
    this.meal,
    this.menuItems,
  }) : super(key: key);

  @override
  _SwitchConfirmationMealCardState createState() =>
      _SwitchConfirmationMealCardState();
}

class _SwitchConfirmationMealCardState
    extends State<SwitchConfirmationMealCard> {
  List<Widget> _itemWidgetList() {
    var list = <Widget>[];
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
                                  widget.meal.title,
                                  style: TextStyle(
                                      color: appiYellow, fontSize: 24),
                                ),
                                getDayAndDateForCard(widget.meal.startDateTime),
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
                        padding: const EdgeInsets.all(12.0),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
