import 'package:appetizer/colors.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/services/multimessing/switch_meals.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/multimessing/qr_generator_widget.dart';
import 'package:appetizer/ui/multimessing/switchable_meals_screen.dart';
import 'package:appetizer/ui/user_feedback/new_feedback.dart';
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
  final DateTime mealEndDateTime;
  final String selectedHostelCode;
  final SwitchStatus switchStatus;
  final String hostelName;
  final String secretCode;

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
    this.mealEndDateTime,
    this.selectedHostelCode,
    this.switchStatus,
    this.hostelName,
    this.secretCode,
  }) : super(key: key);

  @override
  _YourMealsMenuCardState createState() => _YourMealsMenuCardState();
}

class _YourMealsMenuCardState extends State<YourMealsMenuCard> {
  bool _mealLeaveStatusBool;
  bool _mealSwitchStatusbool;
  String _secretCode;

  @override
  void initState() {
    super.initState();
    _mealLeaveStatusBool = widget.isSwitched;
    _mealSwitchStatusbool =
        widget.switchStatus.status == SwitchStatusEnum.N ? true : false;
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
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
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
      ),
    );
  }

  Widget _skippedFlagComponent() {
    return (!(getLeaveColorFromLeaveStatus(widget.leaveStatus.status) ==
                Colors.white) &&
            widget.isOutdated)
        ? Container(
            decoration: BoxDecoration(
                color: getLeaveColorFromLeaveStatus(widget.leaveStatus.status),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
              child: Text(
                "Skipped".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          )
        : Container();
  }

  Color _getQRBackgroundColor() {
    switch (widget.switchStatus.status) {
      case SwitchStatusEnum.N:
        return Colors.transparent;
        break;
      case SwitchStatusEnum.A:
        return Colors.greenAccent;
        break;
      case SwitchStatusEnum.D:
        return Colors.redAccent;
        break;
      case SwitchStatusEnum.T:
      case SwitchStatusEnum.F:
        return appiYellow;
        break;
      case SwitchStatusEnum.U:
        return appiGrey;
        break;
      default:
        return Colors.transparent;
    }
  }

  VoidCallback _getQROnTap() {
    switch (widget.switchStatus.status) {
      case SwitchStatusEnum.N:
        return () {};
        break;
      case SwitchStatusEnum.A:
        return () {};
        break;
      case SwitchStatusEnum.D:
        return () {
          Fluttertoast.showToast(msg: "Your switch has been denied");
        };
        break;
      case SwitchStatusEnum.F:
      case SwitchStatusEnum.T:
        return () {
          if (widget.mealEndDateTime
              .add(Duration(hours: 1))
              .isBefore(DateTime.now())) {
            Fluttertoast.showToast(msg: "Time for this meal has passed!");
          } else if (widget.mealStartDateTime
              .subtract(outdatedTime)
              .isAfter(DateTime.now())) {
            Fluttertoast.showToast(
                msg: "QR CODE will be available 8 hours before the meal");
          } else {
            setState(() {
              _secretCode = widget.secretCode;
            });
          }
        };
        break;
      case SwitchStatusEnum.U:
        return () {
          Fluttertoast.showToast(msg: "Your Switch was not approved!");
        };
        break;
      default:
        return () {};
    }
  }

  Widget _showQRButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: GestureDetector(
        onTap: _getQROnTap(),
        child: Container(
          decoration: BoxDecoration(
            color: _getQRBackgroundColor(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: widget.switchStatus.status == SwitchStatusEnum.N
              ? Container()
              : Image.asset(
                  "assets/icons/qr_image.png",
                  height: 40,
                  width: 40,
                ),
        ),
      ),
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
                    : _mealSwitchStatusbool
                        ? "assets/icons/switch_active.png"
                        : "assets/icons/switch_crossed_active.png",
                width: 30,
                scale: 2,
              ),
              onTap: widget.isToggleOutdated
                  ? null
                  : _mealSwitchStatusbool
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SwitchableMealsScreen(
                                id: widget.id,
                                token: widget.token,
                              ),
                            ),
                          );
                        }
                      : widget.switchStatus.status == SwitchStatusEnum.T ||
                              widget.switchStatus.status == SwitchStatusEnum.F
                          ? () {
                              showDialog(
                                context: context,
                                builder: (BuildContext alertContext) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    title: new Text(
                                      "Cancel Switch",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: new Text(
                                      "Are you sure you want to cancel this switch?",
                                    ),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () {
                                          Navigator.pop(alertContext);
                                        },
                                        child: new Text(
                                          "NO",
                                          style: TextStyle(
                                              color: appiYellow,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      new FlatButton(
                                        child: new Text(
                                          "YES",
                                          style: TextStyle(
                                              color: appiYellow,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(alertContext);
                                          showCustomDialog(
                                              context, "Cancelling Switch");
                                          cancelSwitch(widget.switchStatus.id,
                                                  widget.token)
                                              .then((switchCancelResponse) {
                                            Navigator.pop(context);
                                            if (switchCancelResponse) {
                                              Navigator.of(context).popUntil(
                                                  (route) => route.isFirst);
                                              setState(() {
                                                _mealSwitchStatusbool = true;
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Unable to cancel the switch");
                                            }
                                          });
                                        },
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                      ),
                                    ],
                                  );
                                },
                              );
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
                value: _mealLeaveStatusBool,
                onChanged: (value) async {
                  onChangedCallback(value, context);
                })
            : Container();
  }

  void onChangedCallback(bool value, BuildContext context) {
    if (_mealSwitchStatusbool) {
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
                              _mealLeaveStatusBool = true;
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
                "Leave status cannot be changed less than 8 hours before the meal time",
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
                            );
                            setState(() {
                              _mealLeaveStatusBool = false;
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
                "Leave status cannot be changed less than 8 hours before the meal time",
          );
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Leave Status cannot be changed when Switch is active !!");
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
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  setState(() {
                                    _secretCode = null;
                                  });
                                },
                              ),
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    _titleAndBhawanNameComponent(),
                                    _skippedFlagComponent(),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  _showQRButton(),
                                  _getSwitchIcon(),
                                  _feedbackOrToggleComponent(context),
                                ],
                              ),
                            ],
                          ),
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
