import 'package:flutter/material.dart';
import "colors.dart";
import 'HorizontalDatePicker.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _username = "Abhishek";
  String _enrollment = "18114003";
  String version = "v1.5.6r";



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(child: Text("Mess Menu")),
        backgroundColor: Colors.brown,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.calendar_today),
          )
        ],
      ),
      body: Column(

        children: <Widget>[
          HorizontalDatePicker(),
          Flexible(
            child: SingleChildScrollView(child: Menu()),
          ),
        ],
      ), // this is to be implemented

      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: appiBrown,
                image: new DecorationImage(
                  alignment: Alignment.topRight,
                  image: AssetImage('assets/images/iit roorkee 1.png'),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 14.0),
                    child: Icon(
                      Icons.account_circle,
                      size: 80,
                      color: appiYellow,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 16, left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _username,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: Text(
                            _enrollment,
                            style: TextStyle(color: appiYellow, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image(
                      image: AssetImage("assets/icons/feedback.png"),
                      width: 24,
                      height: 24,
                    ),
                    title: Text("FeedBack"),
                  ),
                  ListTile(
                    leading: Image(
                      image: AssetImage("assets/icons/leaves@1x.png"),
                      width: 24,
                      height: 24,
                    ),
                    title: Text("Leaves"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.attach_money,
                      color: appiYellow,
                      size: 24,
                    ),
                    title: Text("Rebates"),
                  ),
                  ListTile(
                    leading: Image(
                      image: AssetImage("assets/icons/notification.png"),
                      width: 24,
                      height: 24,
                    ),
                    title: Text("Notification History"),
                  ),
                  ListTile(
                    leading: Image(
                      image: AssetImage("assets/icons/setting.png"),
                      width: 24,
                      height: 24,
                    ),
                    title: Text("Settings"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help_outline,
                      color: appiYellow,
                      size: 24,
                    ),
                    title: Text("FAQ"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: appiYellow,
                      size: 24,
                    ),
                    title: Text("Log Out"),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    version,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Made with ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Icon(
                        Icons.favorite,
                        color: appiRed,
                        size: 12,
                      ),
                      Text(
                        " by MDG",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  final _testMap = {
    Icon(Icons.fastfood) : "item 1",
    Icon(Icons.fastfood) : "item 1",
    Icon(Icons.fastfood) : "item 1",
    Icon(Icons.fastfood) : "item 1",
  };

  final _testDailyItems = "milk, tea, coffee, milk, tea, coffee milk, tea, coffee";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuCard('Breakfast', _testMap,
            _testDailyItems),
        MenuCard('Lunch', _testMap,
            _testDailyItems),
        MenuCard('Dinner', _testMap,
            _testDailyItems),
        MenuCard('Dinner', _testMap,
            _testDailyItems),
      ],
    );
  }
}

class MenuCard extends StatefulWidget {
  final String title;
  final Map<Icon, String> menuItems;
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
    widget.menuItems.forEach((icon, string){
      list.add(_menuListItem(string, icon));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      style: TextStyle(color: Colors.yellow[700], fontSize: 24),
                    ),
                  ),
                  outdated ? Icon(Icons.comment): Switch(value: enabled, onChanged: (value){
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
        Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Daily Items: ${widget.dailyItems}',
              ),
            ))
      ],
    ));
  }

  Widget _menuListItem(String itemName, Icon foodIcon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 4.0),
          child: Column(
            children: <Widget>[
              foodIcon,
              SizedBox(height: 8.0,)
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(itemName),
              Divider(height: 8.0,),
            ],
          ),
        ),
      ],
    );
  }
}
