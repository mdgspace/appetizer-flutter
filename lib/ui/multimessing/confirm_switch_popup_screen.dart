import 'package:appetizer/colors.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/components/error_widget.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/components/progress_bar.dart';
import 'package:appetizer/ui/components/switch_confirmation_meal_card.dart';
import 'package:appetizer/ui/multimessing/confirmed_switch_screen.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:appetizer/utils/menu_utils.dart';
import 'package:appetizer/viewmodels/switch_models/confirm_switch_popup_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmSwitchPopupScreen extends StatefulWidget {
  final Meal meal;

  const ConfirmSwitchPopupScreen({
    Key key,
    this.meal,
  }) : super(key: key);

  @override
  _ConfirmSwitchPopupScreenState createState() =>
      _ConfirmSwitchPopupScreenState();
}

class _ConfirmSwitchPopupScreenState extends State<ConfirmSwitchPopupScreen> {
  int currentHostelMealId;
  InheritedData inheritedData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
  }

  List<CircleAvatar> mealFromWhichToBeSwitchedLeadingImageList = [];
  List<String> mealFromWhichToBeSwitchedItemsList = [];
  Map<CircleAvatar, String> mealFromWhichToBeSwitchedMap = {};

  void setMealFromWhichToBeSwitchedComponents(Meal mealFromWhichToBeSwitched) {
    mealFromWhichToBeSwitchedItemsList = [];
    mealFromWhichToBeSwitchedLeadingImageList = [];
    for (var j = 0; j < mealFromWhichToBeSwitched.items.length; j++) {
      var mealItem = mealFromWhichToBeSwitched.items[j].name;
      mealFromWhichToBeSwitchedItemsList.add(mealItem);
      MenuCardUtils.setLeadingMealImage(
        mealFromWhichToBeSwitchedLeadingImageList,
      );
    }
  }

  Map<String, MealType> titleToMealTypeMap = {
    "Breakfast": MealType.B,
    "Lunch": MealType.L,
    "Snacks": MealType.S,
    "Dinner": MealType.D,
  };

  TextStyle getSwitchToOrFromStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Text(
        "Confirm Meal Switch",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      leading: Container(),
      backgroundColor: appiBrown,
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback _onConfirmSwitchPressed(ConfirmSwitchPopupModel model) {
      return () async {
        showCustomDialog(context, "Switching Meals");
        await model.switchMeals(
          currentHostelMealId,
          hostelCodeMap[widget.meal.hostelName],
        );
        // Provider.of<OtherMenuModel>(context, listen: false).getOtherMenu(
        //   DateTimeUtils.getWeekNumber(widget.meal.startDateTime),
        // );
        // Provider.of<YourMenuModel>(context, listen: false)
        //     .selectedWeekMenuYourMeals(
        //   DateTimeUtils.getWeekNumber(widget.meal.startDateTime),
        // );
        if (model.isMealSwitched) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmedSwitchScreen(),
            ),
          );
        }
        if (model.state == ViewState.Error) {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: model.errorMessage,
          );
        }
      };
    }

    return BaseView<ConfirmSwitchPopupModel>(
      onModelReady: (model) => model.getMenuWeekMultimessing(
        DateTimeUtils.getWeekNumber(widget.meal.startDateTime),
        hostelCodeMap[inheritedData.userDetails.hostelName],
      ),
      builder: (context, model, child) => Scaffold(
        appBar: _getAppBar(),
        body: model.state == ViewState.Busy
            ? ProgressBar()
            : model.state == ViewState.Error
                ? AppiErrorWidget(message: model.errorMessage)
                : Builder(
                    builder: (context) {
                      model.menuWeekMultimessing.days.forEach((dayMenu) {
                        String mealDateString =
                            dayMenu.date.toString().substring(0, 10);
                        dayMenu.meals.forEach((mealMenu) {
                          if (mealDateString ==
                                  widget.meal.startDateTime
                                      .toString()
                                      .substring(0, 10) &&
                              titleToMealTypeMap[widget.meal.title] ==
                                  mealMenu.type) {
                            currentHostelMealId = mealMenu.id;
                            setMealFromWhichToBeSwitchedComponents(mealMenu);
                            mealFromWhichToBeSwitchedMap = Map.fromIterables(
                              mealFromWhichToBeSwitchedLeadingImageList,
                              mealFromWhichToBeSwitchedItemsList,
                            );
                          }
                        });
                      });

                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    "Switch From",
                                    style: getSwitchToOrFromStyle(),
                                  ),
                                ),
                                SwitchConfirmationMealCard(
                                  meal: widget.meal,
                                  menuItems: mealFromWhichToBeSwitchedMap,
                                ),
                                GestureDetector(
                                  onTap: _onConfirmSwitchPressed(model),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/icons/switch_active.png",
                                        scale: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    "Switch To",
                                    style: getSwitchToOrFromStyle(),
                                  ),
                                ),
                                SwitchConfirmationMealCard(
                                  meal: widget.meal,
                                  menuItems: MenuCardUtils.getMapMenuItems(
                                      widget.meal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
