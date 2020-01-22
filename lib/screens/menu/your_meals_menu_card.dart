import 'package:appetizer/colors.dart';
import 'package:appetizer/components/alert_dialog.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/screens/multimessing/confirm_switch_popup_screen.dart';
import 'package:appetizer/screens/multimessing/qr_generator_widget.dart';
import 'package:appetizer/screens/user_feedback/new_feedback.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/services/multimessing/switch_meals.dart';
import 'package:appetizer/utils/get_day_and_date_for_meal_card.dart';
import 'package:appetizer/utils/get_leave_color_from_leave_status.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class YourMealsMenuCard extends StatefulWidget {
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

  YourMealsMenuCard({
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
  _YourMealsMenuCardState createState() => _YourMealsMenuCardState();
}

class _YourMealsMenuCardState extends State<YourMealsMenuCard> {
  bool isSwitched;
  String _secretCode;

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

  Widget _skippedFlagComponent() {
    return (!(getLeaveColorFromLeaveStatus(widget.leaveStatus) ==
                Colors.white) &&
            widget.isOutdated)
        ? Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Container(
              decoration: BoxDecoration(
                  color: getLeaveColorFromLeaveStatus(widget.leaveStatus),
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 1, 12, 1),
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
        : Container();
  }

  Widget _showQRButton() {
    return widget.switchStatus == SwitchStatus.A
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: GestureDetector(
              onTap: () {
                getQRData(widget.id, widget.token).then((secretCode) {
                  setState(() {
                    _secretCode = secretCode;
                  });
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: appiYellow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.asset(
                  "assets/icons/qr_image.png",
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          )
        : Container();
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

  Widget _feedbackOrToggleComponent(BuildContext context) {
    return widget.isOutdated
        ? Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              child: Image.asset(
                "assets/icons/feedback_button.png",
                height: 25,
                width: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewFeedback()));
              },
            ),
          )
        : !widget.isCheckedOut
            ? Switch(
                activeColor: appiYellow,
                value: isSwitched,
                onChanged: (value) async {
                  onChangedCallback(value, context);
                })
            : Container();
  }

  void onChangedCallback(bool value, BuildContext context) {
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
                            );
                          });
                        }
                      }).catchError((e) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: "Something Wrong Occured",
                        );
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
        );
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
                content:
                    new Text("Are you sure you would like to leave this meal?"),
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
                          );
                          setState(() {
                            isSwitched = false;
                          });
                        }
                      }).catchError((e) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: "Something Wrong Occured",
                        );
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
        );
      }
    }
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

  Widget _getQRCard(String secretCode) {
    return Card(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
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
                                style: TextStyle(
                                  color: appiBrown,
                                ),
                              ),
                            ],
                          ),
                          getDayAndDateForCard(widget.mealStartDateTime),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QRWidget(
            secretCode: secretCode,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    color: Color(0xffF4F4F4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Scan this QR code at the mess reception and get delecious meal',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, .54),
                        ),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
      child: _secretCode == null
          ? Card(
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
                                    _skippedFlagComponent(),
                                  ],
                                ),
                              ),
                            ),
                            _showQRButton(),
                            _getSwitchIcon(),
                            _feedbackOrToggleComponent(context),
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
            )
          : _getQRCard(_secretCode),
    );
  }
}