import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/error_widget.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/components/progress_bar.dart';
import 'package:appetizer/ui/menu/day_menu.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:appetizer/viewmodels/current_date_model.dart';
import 'package:appetizer/viewmodels/menu_models/other_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherMenu extends StatefulWidget {
  final String hostelName;

  const OtherMenu({Key key, this.hostelName}) : super(key: key);
  @override
  _OtherMenuState createState() => _OtherMenuState();
}

class _OtherMenuState extends State<OtherMenu> {
  InheritedData inheritedData;
  var dailyItemsMap;
  int weekId;
  var selectedDateTime;

  @override
  void initState() {
    super.initState();

    UserApi().userMeGet().then((me) {
      setState(() {
        isCheckedOut = me.isCheckedOut;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
    weekId = Provider.of<CurrentDateModel>(context).weekId;
    selectedDateTime = Provider.of<CurrentDateModel>(context).dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OtherMenuModel>(
      onModelReady: (model) =>
          model.getOtherMenu(weekId, hostelCodeMap[widget.hostelName]),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? ProgressBar()
          : model.state == ViewState.Error
              ? AppiErrorWidget()
              : Builder(
                  builder: (context) {
                    Day currentDayMeal;

                    model.hostelWeekMenu.days.forEach((day) {
                      if (day.date.weekday == selectedDateTime.weekday) {
                        currentDayMeal = day;
                      }
                    });
                    if (currentDayMeal == null) {
                      return _menuUnavailableForSingleDay(context);
                    }
                    final dailyItems = model.hostelWeekMenu.dailyItems;
                    return DayMenu(
                      currentDayMeal,
                      dailyItems,
                      1,
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
                "The menu for this day has not been uploaded yet!",
              ),
            ),
          ),
        ],
      );
}
