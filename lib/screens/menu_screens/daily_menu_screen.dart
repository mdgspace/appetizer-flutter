import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
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

  final _testDailyItems = "milk, tea, coffee, milk, tea, coffee";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuCard('Breakfast', _testMap, _testDailyItems),
        MenuCard('Lunch', _testMap, _testDailyItems),
        MenuCard('Dinner', _testMap, _testDailyItems),
      ],
    );
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
  bool enabled = true;
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
                              value: enabled,
                              onChanged: (value) {
                                setState(() {
                                  value = enabled;
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
