import 'package:appetizer/components/alert_dialog.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/screens/user_feedback/new_feedback.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/utils/get_leave_color_from_leave_status.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuCard extends StatefulWidget {
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

  MenuCard(
      this.title,
      this.menuItems,
      this.dailyItems,
      this.id,
      this.token,
      this.isSwitched,
      this.isOutdated,
      this.leaveStatus,
      this.isCheckedOut,
      this.isToggleOutdated);

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.isSwitched;
  }

  List<Widget> _itemWidgetList() {
    List<Widget> list = [];
    widget.menuItems.forEach((icon, string) {
      list.add(_menuListItem(string, icon));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    void onChangedCallback(bool value) {
      if (value) {
        if (!widget.isToggleOutdated) {
          showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: new Text(
                    "Cancel Leave",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: new Text(
                      "Are you sure you would like to cancel this leave?"),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      child: new Text(
                        "CANCEL",
                        style: TextStyle(
                            color: appiYellow, fontWeight: FontWeight.bold),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    new FlatButton(
                      child: new Text(
                        "CANCEL LEAVE",
                        style: TextStyle(
                            color: appiYellow, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        showCustomDialog(context, "Cancelling Leave");
                        cancelLeave(widget.id, widget.token).then((leaveBool) {
                          if (leaveBool) {
                            Navigator.pop(context);
                            setState(() {
                              isSwitched = true;
                              Fluttertoast.showToast(
                                  msg: "Leave Cancelled",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1,
                                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                                  textColor: Colors.white,
                                  fontSize: 14.0);
                            });
                          }
                        }).catchError((e) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Something Wrong Occured",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
                              backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                              textColor: Colors.white,
                              fontSize: 14.0);
                        });
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                  ],
                );
              });
        } else {
          Fluttertoast.showToast(
              msg:
                  "Leave status cannot be changed less than 12 hours before the meal time",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
              textColor: Colors.white,
              fontSize: 14.0);
        }
      } else {
        if (!widget.isToggleOutdated) {
          showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: new Text(
                    "Leave Meal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: new Text(
                      "Are you sure you would like to leave this meal?"),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      child: new Text(
                        "CANCEL",
                        style: TextStyle(
                            color: appiYellow, fontWeight: FontWeight.bold),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    new FlatButton(
                      child: new Text(
                        "SKIP MEAL",
                        style: TextStyle(
                            color: appiYellow, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        showCustomDialog(context, "Leaving Meal");
                        leave(widget.id.toString(), widget.token)
                            .then((leaveResult) {
                          if (leaveResult.meal == widget.id) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: "Meal Skipped",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                                textColor: Colors.white,
                                fontSize: 14.0);
                            setState(() {
                              isSwitched = false;
                            });
                          }
                        }).catchError((e) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Something Wrong Occured",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
                              backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                              textColor: Colors.white,
                              fontSize: 14.0);
                        });
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                  ],
                );
              });
        } else {
          Fluttertoast.showToast(
              msg:
                  "Leave status cannot be changed less than 12 hours before the meal time",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
              textColor: Colors.white,
              fontSize: 14.0);
        }
      }
    }

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
                                Text(
                                  widget.title,
                                  style: new TextStyle(
                                      color: appiYellow, fontSize: 24),
                                ),
                                (!(getLeaveColorFromLeaveStatus(
                                                widget.leaveStatus) ==
                                            Colors.white) &&
                                        widget.isOutdated)
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 5, 30, 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  getLeaveColorFromLeaveStatus(
                                                      widget.leaveStatus),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 1, 12, 1),
                                            child: Text(
                                              "Skipped".toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        widget.isOutdated
                            ? Padding(
                                padding: const EdgeInsets.all(8),
                                child: InkWell(
                                  child: Image.asset(
                                    "assets/icons/feedback_button.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewFeedback()));
                                  },
                                ))
                            : !widget.isCheckedOut
                                ? Switch(
                                    activeColor: appiYellow,
                                    value: isSwitched,
                                    onChanged: (value) async {
                                      onChangedCallback(value);
                                    })
                                : Container(),
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
}
