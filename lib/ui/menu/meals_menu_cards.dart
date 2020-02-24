import 'package:appetizer/change_notifiers/menu_model.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/models/user/user_details_shared_pref.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/services/multimessing/switch_meals.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/multimessing/confirm_switch_popup_screen.dart';
import 'package:appetizer/ui/multimessing/qr_generator_widget.dart';
import 'package:appetizer/ui/multimessing/switchable_meals_screen.dart';
import 'package:appetizer/ui/user_feedback/new_feedback.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/utils/get_day_and_date_for_meal_card.dart';
import 'package:appetizer/utils/get_leave_color_from_leave_status.dart';
import 'package:appetizer/utils/menu_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:appetizer/colors.dart';

class YourMealsMenuCard extends StatefulWidget {
  final Meal meal;
  final DailyItems dailyItems;

  YourMealsMenuCard(this.meal, this.dailyItems);

  @override
  _YourMealsMenuCardState createState() => _YourMealsMenuCardState();
}

class _YourMealsMenuCardState extends State<YourMealsMenuCard> {
  bool _mealLeaveStatus;
  bool _mealSwitchStatus;
  String _secretCode;
  InheritedData inheritedData;
  YourMenuModel yourMenuModel;

  @override
  void initState() {
    super.initState();

    if (widget.meal != null) {
      _mealLeaveStatus =
          widget.meal.leaveStatus.status == LeaveStatusEnum.N ? true : false;
      _mealSwitchStatus =
          widget.meal.switchStatus.status == SwitchStatusEnum.N ? true : false;
    } else {
      // Toggle ON when _mealLeaveStatus = true
      _mealLeaveStatus = true;
      _mealSwitchStatus = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }

    final yourMenuModel = Provider.of<YourMenuModel>(context);
    if (this.yourMenuModel != yourMenuModel) {
      this.yourMenuModel = yourMenuModel;
    }
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.meal != null) {
      _mealLeaveStatus =
          widget.meal.leaveStatus.status == LeaveStatusEnum.N ? true : false;
      _mealSwitchStatus =
          widget.meal.switchStatus.status == SwitchStatusEnum.N ? true : false;
    } else {
      // Toggle ON when _mealLeaveStatus = true
      _mealLeaveStatus = true;
      _mealSwitchStatus = false;
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
                                    widget.meal.items.isNotEmpty
                                        ? _getSwitchIcon()
                                        : Container(),
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
            : _getQRCard(),
      );
    }
  }

  Widget _getQRCard() {
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
                          getDayAndDateForCard(widget.meal.startDateTime),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QRWidget(
            token: inheritedData.getUserDetails.token,
            switchId: widget.meal.switchStatus.id,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    color: Color(0xffF4F4F4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Scan this QR code at the mess reception and get delicious meal',
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

  onChangedCallback(bool value) {
    setState(() {
      _mealLeaveStatus = value;
    });
    if (_mealSwitchStatus) {
      if (value) {
        if (!widget.meal.isLeaveToggleOutdated) {
          showDialog(
              barrierDismissible: false,
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
                        setState(() {
                          _mealLeaveStatus = !_mealLeaveStatus;
                        });
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
                            Provider.of<YourMenuModel>(context, listen: false)
                                .selectedWeekMenuYourMeals(
                                    DateTimeUtils.getWeekNumber(
                                        widget.meal.startDateTime));
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: "Leave Cancelled",
                            );
                          }
                        }).catchError((e) {
                          Navigator.pop(context);
                          setState(() {
                            _mealLeaveStatus = !_mealLeaveStatus;
                          });
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
                "Leave status cannot be changed less than ${outdatedTime.inHours} hours before the meal time",
          );
        }
      } else {
        if (!widget.meal.isLeaveToggleOutdated) {
          showDialog(
              barrierDismissible: false,
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
                        setState(() {
                          _mealLeaveStatus = !_mealLeaveStatus;
                        });
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
                          Provider.of<YourMenuModel>(context, listen: false)
                              .selectedWeekMenuYourMeals(
                                  DateTimeUtils.getWeekNumber(
                                      widget.meal.startDateTime));
                          if (leaveResult.meal == widget.meal.id) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: "Meal Skipped",
                            );
                          }
                        }).catchError((e) {
                          Navigator.pop(context);
                          setState(() {
                            _mealLeaveStatus = !_mealLeaveStatus;
                          });
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
        }
      }
    }
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
            ? GestureDetector(
                onHorizontalDragStart: (d) => {
                  if (widget.meal.isLeaveToggleOutdated)
                    {
                      Fluttertoast.showToast(
                        msg:
                            "Leave status cannot be changed less than ${outdatedTime.inHours} hours before the meal time",
                      )
                    }
                  else if (!_mealSwitchStatus)
                    {
                      Fluttertoast.showToast(
                          msg:
                              "Leave Status cannot be changed when Switch is active !!")
                    }
                },
                child: Switch(
                  activeColor: appiYellow,
                  value: _mealLeaveStatus,
                  onChanged:
                      (widget.meal.isLeaveToggleOutdated || !_mealSwitchStatus)
                          ? null
                          : onChangedCallback,
                ),
              )
            : Container();
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
                              builder: (context) =>
                                  ChangeNotifierProvider.value(
                                value: yourMenuModel,
                                child: SwitchableMealsScreen(
                                  id: widget.meal.id,
                                  token: inheritedData.userDetails.token,
                                  weekId: DateTimeUtils.getWeekNumber(
                                      widget.meal.startDateTime),
                                  model: 0,
                                ),
                              ),
                            ),
                          );
                        }
                      : widget.meal.switchStatus.status == SwitchStatusEnum.T ||
                              widget.meal.switchStatus.status ==
                                  SwitchStatusEnum.F
                          ? () {
                              showDialog(
                                barrierDismissible: false,
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
                                            Provider.of<YourMenuModel>(context,
                                                    listen: false)
                                                .selectedWeekMenuYourMeals(
                                                    DateTimeUtils.getWeekNumber(
                                                        widget.meal
                                                            .startDateTime));
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
              _secretCode = "1";
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

class OtherMealsMenuCard extends StatefulWidget {
  final Meal meal;
  final DailyItems dailyItems;

  OtherMealsMenuCard(this.meal, this.dailyItems);

  @override
  _OtherMealsMenuCardState createState() => _OtherMealsMenuCardState();
}

class _OtherMealsMenuCardState extends State<OtherMealsMenuCard> {
  bool _mealSwitchStatus;
  UserDetailsSharedPref inheritedUserDetails;
  OtherMenuModel otherMenuModel;
  YourMenuModel yourMenuModel;

  @override
  void initState() {
    super.initState();
    if (widget.meal != null) {
      _mealSwitchStatus =
          widget.meal.switchStatus.status == SwitchStatusEnum.N ? true : false;
    } else {
      // menu else hence inactive
      _mealSwitchStatus = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedUserDetails == null) {
      inheritedUserDetails = InheritedData.of(context).userDetails;
    }
    final otherMenuModel = Provider.of<OtherMenuModel>(context);
    if (this.otherMenuModel != otherMenuModel) {
      this.otherMenuModel = otherMenuModel;
    }

    final yourMenuModel = Provider.of<YourMenuModel>(context);
    if (this.yourMenuModel != yourMenuModel) {
      this.yourMenuModel = yourMenuModel;
    }
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.meal != null) {
      _mealSwitchStatus =
          widget.meal.switchStatus.status == SwitchStatusEnum.N ? true : false;
    } else {
      // menu else hence inactive
      _mealSwitchStatus = false;
    }
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
                    : widget.meal.switchStatus.status == SwitchStatusEnum.N
                        ? "assets/icons/switch_active.png"
                        : "assets/icons/switch_crossed_active.png",
                width: 30,
                scale: 2,
              ),
              onTap: widget.meal.isLeaveToggleOutdated
                  ? null
                  : widget.meal.switchStatus.status == SwitchStatusEnum.N
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider.value(
                                      value: otherMenuModel),
                                  ChangeNotifierProvider.value(
                                      value: yourMenuModel),
                                ],
                                child: InheritedData(
                                  userDetails: inheritedUserDetails,
                                  child: ConfirmSwitchPopupScreen(
                                    meal: widget.meal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      : widget.meal.switchStatus.status == SwitchStatusEnum.T ||
                              widget.meal.switchStatus.status ==
                                  SwitchStatusEnum.F
                          ? () {
                              showDialog(
                                barrierDismissible: false,
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
                                                  inheritedUserDetails.token)
                                              .then((switchCancelResponse) {
                                            Provider.of<OtherMenuModel>(context,
                                                    listen: false)
                                                .getOtherMenu(
                                                    DateTimeUtils.getWeekNumber(
                                                        widget.meal
                                                            .startDateTime));
                                            Provider.of<YourMenuModel>(context,
                                                    listen: false)
                                                .selectedWeekMenuYourMeals(
                                                    DateTimeUtils.getWeekNumber(
                                                        widget.meal
                                                            .startDateTime));

                                            Navigator.pop(context);
                                            if (switchCancelResponse) {
                                              setState(() {});
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
