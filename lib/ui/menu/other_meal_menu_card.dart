import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/models/user/user_details_shared_pref.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/multimessing/confirm_switch_popup_screen.dart';
import 'package:appetizer/utils/menu_utils.dart';
import 'package:appetizer/viewmodels/menu_models/other_menu_model.dart';
import 'package:appetizer/viewmodels/menu_models/your_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:appetizer/colors.dart';

class OtherMealsMenuCard extends StatefulWidget {
  final Meal meal;
  final DailyItems dailyItems;

  OtherMealsMenuCard(this.meal, this.dailyItems);

  @override
  _OtherMealsMenuCardState createState() => _OtherMealsMenuCardState();
}

class _OtherMealsMenuCardState extends State<OtherMealsMenuCard> {
  UserDetailsSharedPref inheritedUserDetails;
  OtherMenuModel otherMenuModel;
  YourMenuModel yourMenuModel;

  @override
  void initState() {
    super.initState();
    // if (widget.meal != null) {
    //   _mealSwitchStatus =
    //       widget.meal.switchStatus.status == SwitchStatusEnum.N ? true : false;
    // } else {
    //   // menu else hence inactive
    //   _mealSwitchStatus = false;
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedUserDetails == null) {
      inheritedUserDetails = InheritedData.of(context).userDetails;
    }
    // final otherMenuModel = Provider.of<OtherMenuModel>(context);
    // if (this.otherMenuModel != otherMenuModel) {
    //   this.otherMenuModel = otherMenuModel;
    // }

    // final yourMenuModel = Provider.of<YourMenuModel>(context);
    // if (this.yourMenuModel != yourMenuModel) {
    //   this.yourMenuModel = yourMenuModel;
    // }
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.meal != null) {
    //   _mealSwitchStatus =
    //       widget.meal.switchStatus.status == SwitchStatusEnum.N ? true : false;
    // } else {
    //   _mealSwitchStatus = false;
    // }
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
              MenuCardUtils.specialMealBanner(widget.meal.costType),
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
                                          MultimessingApi()
                                              .cancelSwitch(
                                                  widget.meal.switchStatus.id)
                                              .then((switchCancelResponse) {
                                            // Provider.of<OtherMenuModel>(context,
                                            //         listen: false)
                                            //     .getOtherMenu(
                                            //         DateTimeUtils.getWeekNumber(
                                            //             widget.meal
                                            //                 .startDateTime));
                                            // Provider.of<YourMenuModel>(context,
                                            //         listen: false)
                                            //     .selectedWeekMenuYourMeals(
                                            //         DateTimeUtils.getWeekNumber(
                                            //             widget.meal
                                            //                 .startDateTime));

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
