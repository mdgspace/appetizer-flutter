import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/menu/day_menu.dart';
import 'package:appetizer/viewmodels/date_picker_viewmodel.dart';
import 'package:appetizer/viewmodels/menu/your_menu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourMenu extends StatefulWidget {
  @override
  _YourMenuState createState() => _YourMenuState();
}

class _YourMenuState extends State<YourMenu> {
  var dailyItemsMap;
  int weekId;
  var selectedDateTime;

  @override
  void initState() {
    super.initState();

    UserApi().getCurrentUser().then((me) {
      setState(() {
        Globals.isCheckedOut = me.isCheckedOut;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    weekId = Provider.of<DatePickerViewModel>(context).weekId;
    selectedDateTime = Provider.of<DatePickerViewModel>(context).dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<YourMenuViewModel>(
      onModelReady: (model) => model.selectedWeekMenuYourMeals(weekId),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? AppetizerProgressWidget()
          : model.state == ViewState.Error
              ? AppetizerErrorWidget()
              : Builder(
                  builder: (context) {
                    Day currentDayMeal;

                    model.selectedWeekYourMeals.days.forEach((day) {
                      if (day.date.weekday == selectedDateTime.weekday) {
                        currentDayMeal = day;
                      }
                    });
                    if (currentDayMeal == null) {
                      return _menuUnavailableForSingleDay(context);
                    }
                    final dailyItems = model.selectedWeekYourMeals.dailyItems;
                    return DayMenu(
                      currentDayMeal,
                      dailyItems,
                      0,
                    );
                  },
                ),
    );
  }

  Widget _menuUnavailableForSingleDay(context) => Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Center(
              child: Text(
                'The menu for this day has not been uploaded yet!',
              ),
            ),
          ),
        ],
      );
}
