import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/menu/your_day_menu_view.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/menu/your_menu_viewmodel.dart';
import 'package:flutter/material.dart';

class YourMenuView extends StatefulWidget {
  final DateTime selectedDateTime;

  const YourMenuView({Key key, this.selectedDateTime}) : super(key: key);

  @override
  _YourMenuViewState createState() => _YourMenuViewState();
}

class _YourMenuViewState extends State<YourMenuView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<YourMenuViewModel>(
      onModelReady: (model) {
        model.fetchInitialCheckedStatus();
        model.selectedWeekMenuYourMeals(
          DateTimeUtils.getWeekNumber(widget.selectedDateTime),
        );
      },
      builder: (context, model, child) => Expanded(
        child: () {
          switch (model.state) {
            case ViewState.Idle:
              DayMenu selectedDayMenu;
              model.selectedWeekYourMeals.dayMenus.forEach((dayMenu) {
                if (dayMenu.date.weekday == widget.selectedDateTime.weekday) {
                  selectedDayMenu = dayMenu;
                }
              });
              if (selectedDayMenu == null) {
                return _menuUnavailableForSingleDay();
              }
              final dailyItems = model.selectedWeekYourMeals.dailyItems;
              return YourDayMenuView(
                dayMenu: selectedDayMenu,
                dailyItems: dailyItems,
              );
              break;
            case ViewState.Busy:
              return AppetizerProgressWidget();
              break;
            case ViewState.Error:
              return AppetizerErrorWidget(
                errorMessage: model.errorMessage,
                onRetryPressed: () => model.selectedWeekMenuYourMeals(
                  DateTimeUtils.getWeekNumber(widget.selectedDateTime),
                ),
              );
              break;
            default:
              return Container();
          }
        }(),
      ),
    );
  }

  Widget _menuUnavailableForSingleDay() {
    return Container(
      child: Center(
        child: Text(
          'The menu for this day has not been uploaded yet!',
        ),
      ),
    );
  }
}
