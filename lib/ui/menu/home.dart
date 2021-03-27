import 'package:appetizer/colors.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/FAQ/faq_view.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/date_picker/date_picker.dart';
import 'package:appetizer/ui/menu/other_menu.dart';
import 'package:appetizer/ui/menu/your_menu.dart';
import 'package:appetizer/ui/my_leaves/my_leaves_screen.dart';
import 'package:appetizer/ui/my_rebates/my_rebates_screen.dart';
import 'package:appetizer/ui/my_switches/my_switches_screen.dart';
import 'package:appetizer/ui/notification_history/noti_history_screen.dart';
import 'package:appetizer/ui/settings/settings_screen.dart';
import 'package:appetizer/ui/user_feedback/user_feedback.dart';
import 'package:appetizer/viewmodels/current_date_model.dart';
import 'package:appetizer/viewmodels/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String id = 'home_view';
  final String token;

  const Home({Key key, this.token}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedHostelName;
  CurrentDateModel currentDateModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentDateModel = CurrentDateModel();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) async => model.onModelReady(),
      builder: (context, model, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => currentDateModel),
        ],
        child: Scaffold(
          floatingActionButton:
              !Globals.isCheckedOut ? _fab(context, model) : null,
          appBar: _appBar(context, model),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  child: DatePicker(
                    padding: 0,
                  ),
                ),
                Globals.isCheckedOut == true
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        color: appiRed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'You are currently Checked-Out',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyLeaves(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                child: Text(
                                  'CHECK-IN',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
                Flexible(
                  child: GestureDetector(
                    onHorizontalDragEnd: (d) {
                      if (d.velocity.pixelsPerSecond.dx < -500) {
                        currentDateModel.setDateTime(
                            currentDateModel.dateTime.add(Duration(days: 1)),
                            context);
                      } else if (d.velocity.pixelsPerSecond.dx > 500) {
                        currentDateModel.setDateTime(
                            currentDateModel.dateTime
                                .subtract(Duration(days: 1)),
                            context);
                      }
                    },
                    child: model.selectedHostel == 'Your Meals'
                        ? YourMenu()
                        : OtherMenu(hostelName: model.selectedHostel),
                  ),
                ),
              ],
            ),
          ),
          drawer: _drawer(context, model),
        ),
      ),
    );
  }

  Widget _appBar(context, HomeModel model) {
    return AppBar(
      centerTitle: true,
      title: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black.withOpacity(0.25))),
        child: Theme(
          data: ThemeData(canvasColor: appiBrown),
          child: Center(
            child: DropdownButton<String>(
              underline: Container(),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              value: selectedHostelName,
              hint: Text(
                '       Your Meals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'Lobster_Two',
                ),
              ),
              items: model.switchableHostelsList.map((String hostelName) {
                return DropdownMenuItem<String>(
                  value: hostelName,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.47,
                      child: Text(
                        hostelName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'Lobster_Two',
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String _selectedHostelName) {
                setState(() {
                  selectedHostelName = _selectedHostelName;
                });
                model.selectedHostel = _selectedHostelName;
              },
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ChangeNotifierProvider.value(
              //             value: menuModel, child: WeekMenu())));
            },
            child: Container(
              height: 23,
              width: 23,
              child: Image.asset('assets/icons/week_menu.png'),
            ),
          ),
        )
      ],
      backgroundColor: appiBrown,
      iconTheme: IconThemeData(color: appiYellow),
    );
  }

  Widget _drawer(context, HomeModel model) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: appiBrown,
              image: DecorationImage(
                alignment: Alignment.topRight,
                image: AssetImage('assets/images/iitr.png'),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 14.0),
                  child: Icon(
                    Icons.account_circle,
                    size: 80,
                    color: appiYellow,
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 16, left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            model.currentUser?.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).accentTextTheme.headline3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: Text(
                            model.currentUser?.enrNo.toString() ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).accentTextTheme.headline2,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserFeedback(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('assets/icons/feedback.png'),
                        width: 24,
                        height: 24,
                      ),
                      title: Text('FeedBack'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyLeaves(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('assets/icons/leaves.png'),
                        width: 24,
                        height: 24,
                      ),
                      title: Text('Leaves'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MySwitches(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('assets/icons/leaves.png'),
                        width: 24,
                        height: 24,
                      ),
                      title: Text('Switches'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyRebates(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.attach_money,
                        color: appiYellow,
                        size: 24,
                      ),
                      title: Text('Rebates'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationHistory(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('assets/icons/notification.png'),
                        width: 24,
                        height: 24,
                      ),
                      title: Text('Notification History'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Settings(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('assets/icons/setting.png'),
                        width: 24,
                        height: 24,
                      ),
                      title: Text('Settings'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FaqView(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.help_outline,
                        color: appiYellow,
                        size: 24,
                      ),
                      title: Text('FAQ'),
                    ),
                  ),
                  GestureDetector(
                    child: ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: appiYellow,
                          size: 24,
                        ),
                        title: Text('Log Out'),
                        onTap: () {
                          Navigator.pop(context);
                          model.onLogoutTap();
                        }),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.appetizerVersion,
                  style: TextStyle(
                    fontSize: 12,
                    color: appiGreyIcon,
                  ),
                  textAlign: TextAlign.left,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Made with ',
                      style: TextStyle(
                        fontSize: 12,
                        color: appiGreyIcon,
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      color: appiRed,
                      size: 12,
                    ),
                    Text(
                      ' by MDG',
                      style: TextStyle(
                        fontSize: 12,
                        color: appiGreyIcon,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fab(context, HomeModel model) {
    return FloatingActionButton(
      onPressed: model.onCheckoutTap,
      backgroundColor: appiYellowLogo,
      child: Image.asset(
        'assets/images/check_out.png',
        height: 25,
        width: 25,
      ),
    );
  }
}
