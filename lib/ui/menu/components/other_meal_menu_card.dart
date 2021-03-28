import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/multimessing/confirm_switch_popup_screen.dart';
import 'package:appetizer/utils/menu_utils.dart';
import 'package:appetizer/viewmodels/menu/other_menu_viewmodel.dart';
import 'package:appetizer/viewmodels/menu/your_menu_viewmodel.dart';
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
  OtherMenuViewModel otherMenuModel;
  YourMenuViewModel yourMenuModel;

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
                        widget.meal.items.isNotEmpty
                            ? _getSwitchIcon()
                            : Container(),
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
                                child: ConfirmSwitchPopupScreen(),
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
                                    title: Text(
                                      'Cancel Switch',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      'Are you sure you want to cancel this switch?',
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(alertContext);
                                        },
                                        child: Text(
                                          'NO',
                                          style: TextStyle(
                                              color: appiYellow,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () async {
                                          Navigator.pop(alertContext);
                                          DialogService()
                                              .showCustomProgressDialog(
                                                  title: 'Cancelling Switch');
                                          await MultimessingApi()
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
                                                      'Unable to cancel the switch');
                                            }
                                          });
                                        },
                                        child: Text(
                                          'YES',
                                          style: TextStyle(
                                              color: appiYellow,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          : null,
              child: Image.asset(
                widget.meal.isLeaveToggleOutdated
                    ? 'assets/icons/switch_inactive.png'
                    : widget.meal.switchStatus.status == SwitchStatusEnum.N
                        ? 'assets/icons/switch_active.png'
                        : 'assets/icons/switch_crossed_active.png',
                width: 30,
                scale: 2,
              ),
            )
          : Container(),
    );
  }
}
