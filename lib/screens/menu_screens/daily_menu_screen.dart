import 'package:flutter/material.dart';
import 'package:appetizer/services/menu.dart';
import '../../colors.dart';

class Menu extends StatefulWidget {
  final String token;

  const Menu({Key key, this.token}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static final double _radius = 16;

  final _testMap = {
    CircleAvatar(
            radius: _radius,
            backgroundImage: AssetImage("assets/images/Group.png")):
        "Aloo Parantha",
    CircleAvatar(
      radius: _radius,
      backgroundImage: AssetImage("assets/images/yogurt-dahi.png"),
    ): "Dahi",
    CircleAvatar(
      radius: _radius,
      backgroundImage: AssetImage("assets/images/alumatar.png"),
    ): "Aloo Mater Curry",
    CircleAvatar(
      radius: _radius,
      backgroundImage: AssetImage("assets/images/daliya-upma.png"),
    ): "Dalia Upma",
  };

  Widget getCurrentWeekMenu(String token) {
    return FutureBuilder(
        future: menuWeek(token),
        builder: (context, snapshot) {
          var data = snapshot.data;
          String breakfastDailyItems = "";
          String lunchDailyItems = "";
          String dinnerDailyItems = "";
          if (snapshot.data == null) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
              )),
            );
          } else {
            List<String> breakfastDailyItemsList = [];
            for (var i = 0; i < data.dailyItems.breakfast.length; i++) {
              var name = data.dailyItems.breakfast[i].name;
              breakfastDailyItemsList.add(name);
              breakfastDailyItems = breakfastDailyItemsList.join(" , ");
            }

            List<String> lunchDailyItemsList = [];
            for (var i = 0; i < data.dailyItems.lunch.length; i++) {
              var name = data.dailyItems.lunch[i].name;
              lunchDailyItemsList.add(name);
              lunchDailyItems = lunchDailyItemsList.join(" , ");
            }

            List<String> dinnerDailyItemsList = [];
            for (var i = 0; i < data.dailyItems.dinner.length; i++) {
              var name = data.dailyItems.dinner[i].name;
              dinnerDailyItemsList.add(name);
              dinnerDailyItems = dinnerDailyItemsList.join(" , ");
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MenuCard('Breakfast', _testMap, breakfastDailyItems),
              MenuCard('Lunch', _testMap, lunchDailyItems),
              MenuCard('Dinner', _testMap, dinnerDailyItems),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return getCurrentWeekMenu(widget.token);
  }
}

class MenuCard extends StatefulWidget {
  final String title;
  final Map<CircleAvatar, String> menuItems;
  final String dailyItems;

  MenuCard(this.title, this.menuItems, this.dailyItems);

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool isSwitched = true;
  bool outdated = false;

  List<Widget> _itemWidgetList() {
    List<Widget> list = [];
    widget.menuItems.forEach((icon, string) {
      list.add(_menuListItem(string, icon));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(12, 4, 12, 4),
        elevation: 1,
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
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color: Colors.yellow[700], fontSize: 24),
                        ),
                      ),
                      outdated
                          ? Icon(Icons.comment)
                          : Switch(
                              activeColor: appiYellow,
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              }),
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
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, .54),
                              fontFamily: "Roboto"),
                        ),
                      )),
                ),
              ],
            )
          ],
        ));
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
                  style: TextStyle(fontFamily: "Roboto"),
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
}
