import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/services/multimessing/switch_meals.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/multimessing/qr_generator_widget.dart';
import 'package:appetizer/ui/multimessing/switchable_meals_screen.dart';
import 'package:appetizer/ui/user_feedback/new_feedback.dart';
import 'package:appetizer/utils/get_day_and_date_for_meal_card.dart';
import 'package:appetizer/utils/get_leave_color_from_leave_status.dart';
import 'package:appetizer/utils/menu_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../colors.dart';
import '../../globals.dart';

//TODO: Solve bug in othermenu
class YourMealsMenuCardNew extends StatefulWidget {
  final Meal meal;
  final DailyItems dailyItems;

  YourMealsMenuCardNew(this.meal, this.dailyItems);

  @override
  _YourMealsMenuCardNewState createState() => _YourMealsMenuCardNewState();
}

class _YourMealsMenuCardNewState extends State<YourMealsMenuCardNew> {
  bool _mealLeaveStatus;
  bool _mealSwitchStatus;
  String _secretCode;
  InheritedData inheritedData;

  @override
  void initState() {
    super.initState();
    print("MEAL ${widget.meal}");
    if (widget.meal != null) {
      _mealLeaveStatus =
          widget.meal.leaveStatus.status == LeaveStatusEnum.N ? true : false;
      _mealSwitchStatus =
          widget.meal.switchStatus.status == SwitchStatusEnum.N ? true : false;
    } else {
      _mealLeaveStatus = false;
      _mealSwitchStatus = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.meal == null) {
      return Container();
    } else {
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
                                      MenuCardUtils.titleAndBhawanNameComponent(
                                          widget.meal),
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
                            children: MenuCardUtils.itemWidgetList(widget.meal),
                          ),
                        ],
                      ),
                    ),
                    MenuCardUtils.dailyItemsComponent(
                        widget.meal, widget.dailyItems),
                  ],
                ),
              )
            : _getQRCard(_secretCode),
      );
    }
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
                                    widget.meal.title,
                                    style: new TextStyle(
                                      color: appiYellow,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    widget.meal.hostelName,
                                    style: TextStyle(
                                      color: appiBrown,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          getDayAndDateForCard(widget.meal.startTimeObject),
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

  Widget _feedbackOrToggleComponent(BuildContext context) {
    return widget.meal.isOutdated
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
        : !isCheckedOut
            ? Switch(
                activeColor: appiYellow,
                value: _mealLeaveStatus,
                onChanged: (value) async {
                  onChangedCallback(value, context);
                })
            : Container();
  }

  void onChangedCallback(bool value, BuildContext context) {
    if (_mealSwitchStatus) {
      if (value) {
        if (!widget.meal.isLeaveToggleOutdated) {
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
                        cancelLeave(
                                widget.meal.id, inheritedData.userDetails.token)
                            .then((leaveBool) {
                          if (leaveBool) {
                            Navigator.pop(context);
                            setState(() {
                              _mealLeaveStatus = true;
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
        if (!widget.meal.isLeaveToggleOutdated) {
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
                        leave(widget.meal.id.toString(),
                                inheritedData.userDetails.token)
                            .then((leaveResult) {
                          if (leaveResult.meal == widget.meal.id) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: "Meal Skipped",
                            );
                            setState(() {
                              _mealLeaveStatus = false;
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

  Widget _getSwitchIcon() {
    print(
        "IS SWITCHABLE: ${widget.meal.isSwitchable} STATUS ${_mealSwitchStatus} LEAVE_TOGGLE_OUTDATED: ${widget.meal.isLeaveToggleOutdated}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: widget.meal.isSwitchable
          ? GestureDetector(
              child: Image.asset(
                widget.meal.isLeaveToggleOutdated
                    ? "assets/icons/switch_inactive.png"
                    : _mealSwitchStatus
                        ? "assets/icons/switch_active.png"
                        : "assets/icons/switch_crossed_active.png",
                width: 30,
                scale: 2,
              ),
              onTap: widget.meal.isLeaveToggleOutdated
                  ? null
                  : _mealSwitchStatus
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SwitchableMealsScreen(
                                id: widget.meal.id,
                                token: inheritedData.userDetails.token,
                              ),
                            ),
                          );
                        }
                      : widget.meal.switchStatus.status == SwitchStatusEnum.T ||
                              widget.meal.switchStatus.status ==
                                  SwitchStatusEnum.F
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
                                          cancelSwitch(
                                                  widget.meal.switchStatus.id,
                                                  inheritedData
                                                      .userDetails.token)
                                              .then((switchCancelResponse) {
                                            Navigator.pop(context);
                                            if (switchCancelResponse) {
                                              Navigator.of(context).popUntil(
                                                  (route) => route.isFirst);
                                              setState(() {
                                                _mealSwitchStatus = true;
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

  Widget _skippedFlagComponent() {
    return (!(getLeaveColorFromLeaveStatus(widget.meal.leaveStatus?.status) ==
                Colors.white) &&
            widget.meal.isOutdated)
        ? Container(
            decoration: BoxDecoration(
              color:
                  getLeaveColorFromLeaveStatus(widget.meal.leaveStatus?.status),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "S",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          )
        : Container();
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
          child: widget.meal.switchStatus.status == SwitchStatusEnum.N
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

  Color _getQRBackgroundColor() {
    switch (widget.meal.switchStatus.status) {
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
    switch (widget.meal.switchStatus.status) {
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
          if (widget.meal.endDateTime
              .add(Duration(hours: 1))
              .isBefore(DateTime.now())) {
            Fluttertoast.showToast(msg: "Time for this meal has passed!");
          } else if (widget.meal.startTimeObject
              .subtract(outdatedTime)
              .isAfter(DateTime.now())) {
            Fluttertoast.showToast(
                msg: "QR CODE will be available 8 hours before the meal");
          } else {
            setState(() {
              print("INSIDE SET STATE ${widget.meal.secretCode}");
              _secretCode = widget.meal.secretCode;
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
}

class OtherMealsMenuCardNew extends StatefulWidget {
  final Meal meal;
  final DailyItems dailyItems;

  OtherMealsMenuCardNew(this.meal, this.dailyItems);

  @override
  _OtherMealsMenuCardNewState createState() => _OtherMealsMenuCardNewState();
}

class _OtherMealsMenuCardNewState extends State<OtherMealsMenuCardNew> {
  bool _mealSwitchStatus;
  InheritedData inheritedData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _mealSwitchStatus =
        widget.meal != null ? widget.meal.mealSwitchStatusBool : false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.meal == null) {
      return Container();
    } else {
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
                                MenuCardUtils.titleAndBhawanNameComponent(
                                    widget.meal),
                              ],
                            ),
                          ),
                        ),
                        _getSwitchIcon(),
                      ],
                    ),
                    Column(
                      children: MenuCardUtils.itemWidgetList(widget.meal),
                    ),
                  ],
                ),
              ),
              MenuCardUtils.dailyItemsComponent(widget.meal, widget.dailyItems),
            ],
          ),
        ),
      );
    }
  }

  Widget _getSwitchIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: widget.meal.isSwitchable
          ? GestureDetector(
              child: Image.asset(
                widget.meal.isLeaveToggleOutdated
                    ? "assets/icons/switch_inactive.png"
                    : _mealSwitchStatus
                        ? "assets/icons/switch_active.png"
                        : "assets/icons/switch_crossed_active.png",
                width: 30,
                scale: 2,
              ),
              onTap: widget.meal.isLeaveToggleOutdated
                  ? null
                  : _mealSwitchStatus
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SwitchableMealsScreen(
                                id: widget.meal.id,
                                token: inheritedData.userDetails.token,
                              ),
                            ),
                          );
                        }
                      : widget.meal.switchStatus.status == SwitchStatusEnum.T ||
                              widget.meal.switchStatus.status ==
                                  SwitchStatusEnum.F
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
                                          cancelSwitch(
                                                  widget.meal.switchStatus.id,
                                                  inheritedData
                                                      .userDetails.token)
                                              .then((switchCancelResponse) {
                                            Navigator.pop(context);
                                            if (switchCancelResponse) {
                                              Navigator.of(context).popUntil(
                                                  (route) => route.isFirst);
                                              setState(() {
                                                _mealSwitchStatus = true;
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
}

class MenuCardUtils {
  static Widget _menuListItem(
      Meal meal, String itemName, CircleAvatar foodIcon) {
    print("itemName $itemName");
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
                  "$itemName",
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

  static Widget titleAndBhawanNameComponent(Meal meal) {
    print("OTHER MEAL JSON : ${meal.toJson()}");
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${meal.title}",
            style: new TextStyle(
              color: appiYellow,
              fontSize: 24,
            ),
          ),
          Text(
            "${meal.hostelName}",
            style: new TextStyle(
              color: appiBrown,
            ),
          ),
        ],
      ),
    );
  }

  static Widget dailyItemsComponent(Meal meal, DailyItems dailyItems) {
    final dailyItemsMap = getDailyItemsMap(dailyItems);
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Color(0xffF4F4F4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${dailyItemsMap[meal.type]}",
                style: TextStyle(color: Color.fromRGBO(0, 0, 0, .54)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static List<Widget> itemWidgetList(Meal meal) {
    List<Widget> list = [];
    int i = 0;
    meal.items.forEach((mealItem) {
      list.add(_menuListItem(
          meal,
          mealItem.name,
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              "assets/icons/meal_icon" + (i + 1).toString() + ".jpg",
              scale: 2.5,
            ),
          )));
      i++;
    });
    return list;
  }
}
