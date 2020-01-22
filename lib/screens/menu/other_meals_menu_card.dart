import 'package:appetizer/colors.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/screens/multimessing/confirm_switch_popup_screen.dart';
import 'package:appetizer/services/multimessing/switch_meals.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtherMealsMenuCard extends StatefulWidget {
  final String token;
  final int id;
  final String title;
  final Map<CircleAvatar, String> menuItems;
  final String dailyItems;
  final bool isSwitched;
  final bool isOutdated;
  final LeaveStatus leaveStatus;
  final bool isCheckedOut;
  final bool isToggleOutdated;
  final bool isSwitchable;
  final DateTime selectedDateTime;
  final DateTime mealStartDateTime;
  final String selectedHostelCode;
  final SwitchStatus switchStatus;
  final String hostelName;

  OtherMealsMenuCard({
    Key key,
    this.title,
    this.menuItems,
    this.dailyItems,
    this.id,
    this.token,
    this.isSwitched,
    this.isOutdated,
    this.leaveStatus,
    this.isCheckedOut,
    this.isToggleOutdated,
    this.isSwitchable,
    this.selectedDateTime,
    this.mealStartDateTime,
    this.selectedHostelCode,
    this.switchStatus,
    this.hostelName,
  }) : super(key: key);

  @override
  _OtherMealsMenuCardState createState() => _OtherMealsMenuCardState();
}

class _OtherMealsMenuCardState extends State<OtherMealsMenuCard> {
  bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.isSwitched;
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

  List<Widget> _itemWidgetList() {
    List<Widget> list = [];
    widget.menuItems.forEach((icon, string) {
      list.add(_menuListItem(string, icon));
    });
    return list;
  }

  Widget _titleAndBhawanNameComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.title,
          style: new TextStyle(
            color: appiYellow,
            fontSize: 24,
          ),
        ),
        Text(
          widget.hostelName,
          style: new TextStyle(
            color: appiBrown,
          ),
        ),
      ],
    );
  }

  Widget _getSwitchIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: widget.isSwitchable
          ? GestureDetector(
              child: Image.asset(
                widget.isToggleOutdated
                    ? "assets/icons/switch_inactive.png"
                    : widget.switchStatus == SwitchStatus.N
                        ? "assets/icons/switch_active.png"
                        : "assets/icons/switch_crossed_active.png",
                width: 30,
                scale: 2,
              ),
              onTap: widget.isToggleOutdated
                  ? null
                  : widget.switchStatus == SwitchStatus.N
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmSwitchPopupScreen(
                                token: widget.token,
                                id: widget.id,
                                mealStartDateTime: widget.mealStartDateTime,
                                title: widget.title,
                                menuToWhichToBeSwitched: widget.menuItems,
                                dailyItemsToWhichToBeSwitched:
                                    widget.dailyItems,
                                selectedDateTime: widget.selectedDateTime,
                                selectedHostelCode: widget.selectedHostelCode,
                              ),
                            ),
                          );
                        }
                      : widget.switchStatus == SwitchStatus.A
                          ? () {
                              cancelSwitch(widget.id, widget.token)
                                  .then((switchCancelResponse) {
                                if (switchCancelResponse) {
                                  setState(() {});
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Unable to cancel the switch");
                                }
                              });
                            }
                          : null,
            )
          : Container(),
    );
  }

  Widget _dailyItemsComponent() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Color(0xffF4F4F4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Daily Items: ${widget.dailyItems}',
                style: TextStyle(color: Color.fromRGBO(0, 0, 0, .54)),
              ),
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
        margin: EdgeInsets.fromLTRB(12, 4, 12, 4),
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
                            children: <Widget>[
                              _titleAndBhawanNameComponent(),
                            ],
                          ),
                        ),
                      ),
                      _getSwitchIcon(),
                    ],
                  ),
                  Column(
                    children: _itemWidgetList(),
                  ),
                ],
              ),
            ),
            _dailyItemsComponent(),
          ],
        ),
      ),
    );
  }
}
