import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/multimessing/qr_generator_widget.dart';
import 'package:appetizer/ui/user_feedback/new_feedback.dart';
import 'package:appetizer/utils/get_day_and_date_for_meal_card.dart';
import 'package:appetizer/utils/get_leave_color_from_leave_status.dart';
import 'package:appetizer/utils/menu_utils.dart';
import 'package:appetizer/viewmodels/menu_models/your_menu_card_model.dart';
import 'package:appetizer/viewmodels/menu_models/your_menu_model.dart';
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
  YourMenuModel yourMenuModel;

  void onModelReady(YourMenuCardModel model) {
    model.meal = widget.meal;
    model.dailyItems = widget.dailyItems;

    if (widget.meal != null) {
      model.isLeaveToggleOutdated = widget.meal.isLeaveToggleOutdated;
      model.mealLeaveStatus =
          widget.meal.leaveStatus.status == LeaveStatusEnum.N ? true : false;
      model.mealSwitchStatus =
          widget.meal.switchStatus.status == SwitchStatusEnum.N ? true : false;
    } else {
      // Toggle ON when _mealLeaveStatus = true
      model.mealLeaveStatus = true;
      model.mealSwitchStatus = false;
    }
  }

  void onDidChangeDependencies(YourMenuCardModel model) {
    final yourMenuModel = Provider.of<YourMenuModel>(context);
    if (this.yourMenuModel != yourMenuModel) {
      this.yourMenuModel = yourMenuModel;
    }
  }

  void onDidUpdateWidget(Widget oldWidget, YourMenuCardModel model) {
    if (widget.meal != null) {
      model.mealLeaveStatus =
          widget.meal.leaveStatus.status == LeaveStatusEnum.N ? true : false;
      model.mealSwitchStatus =
          widget.meal.switchStatus.status == SwitchStatusEnum.N ? true : false;
    } else {
      // Toggle ON when _mealLeaveStatus = true
      model.mealLeaveStatus = true;
      model.mealSwitchStatus = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<YourMenuCardModel>(
      onModelReady: (model) => onModelReady(model),
      onDidChangeDependencies: (model) => onDidChangeDependencies(model),
      onDidUpdateWidget: (oldWidget, model) =>
          onDidUpdateWidget(oldWidget, model),
      builder: (context, model, child) => widget.meal == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
              child: model.secretCode == null
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
                                            MenuCardUtils
                                                .titleAndBhawanNameComponent(
                                                    widget.meal),
                                            _skippedFlagComponent(),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          _showQRButton(model),
                                          widget.meal.items.isNotEmpty
                                              ? _getSwitchIcon(model)
                                              : Container(),
                                          _feedbackOrToggleComponent(model),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children:
                                      MenuCardUtils.itemWidgetList(widget.meal),
                                ),
                              ],
                            ),
                          ),
                          MenuCardUtils.dailyItemsComponent(
                              widget.meal, widget.dailyItems),
                          MenuCardUtils.specialMealBanner(widget.meal.costType),
                        ],
                      ),
                    )
                  : _getQRCard(model),
            ),
    );
  }

  Widget _getQRCard(YourMenuCardModel model) {
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
                                  model.secretCode = null;
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

  Widget _feedbackOrToggleComponent(YourMenuCardModel model) {
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
                  if (model.isLeaveToggleOutdated)
                    {
                      Fluttertoast.showToast(
                        msg:
                            "Leave status cannot be changed less than ${outdatedTime.inHours} hours before the meal time",
                      )
                    }
                  else if (!model.mealSwitchStatus)
                    {
                      Fluttertoast.showToast(
                          msg:
                              "Leave Status cannot be changed when Switch is active !!")
                    }
                },
                child: Switch(
                  activeColor: appiYellow,
                  value: model.mealLeaveStatus,
                  onChanged:
                      (model.isLeaveToggleOutdated || !model.mealSwitchStatus)
                          ? null
                          : model.onLeaveChanged,
                ),
              )
            : Container();
  }

  Widget _getSwitchIcon(YourMenuCardModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: widget.meal.isSwitchable
          ? GestureDetector(
              child: Image.asset(
                widget.meal.isLeaveToggleOutdated
                    ? "assets/icons/switch_inactive.png"
                    : model.mealSwitchStatus
                        ? "assets/icons/switch_active.png"
                        : "assets/icons/switch_crossed_active.png",
                width: 30,
              ),
              onTap: model.onSwitchChanged,
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

  VoidCallback onQRTap(YourMenuCardModel model) {
    switch (model.meal.switchStatus.status) {
      case SwitchStatusEnum.N:
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
          if (model.meal.endDateTime
              .add(Duration(hours: 1))
              .isBefore(DateTime.now())) {
            Fluttertoast.showToast(msg: "Time for this meal has passed!");
          } else if (model.meal.startTimeObject
              .subtract(outdatedTime)
              .isAfter(DateTime.now())) {
            Fluttertoast.showToast(
                msg: "QR CODE will be available 8 hours before the meal");
          } else {
            model.secretCode = "1";
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

  Widget _showQRButton(YourMenuCardModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: GestureDetector(
        onTap: onQRTap(model),
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
}
