import 'package:appetizer/app_theme.dart';
import 'package:appetizer/constants.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/menu/week_menu_viewmodel.dart';
import 'package:flutter/material.dart';

class WeekMenuView extends StatefulWidget {
  static const String id = 'week_menu_view';

  @override
  _WeekMenuViewState createState() => _WeekMenuViewState();
}

class _WeekMenuViewState extends State<WeekMenuView> {
  Widget _buildWeekMenuHeader() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: AppTheme.secondary),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text(
              'Day'.toUpperCase(),
              style: AppTheme.bodyText1.copyWith(
                color: AppTheme.primary,
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Center(
              child: Text(
                'Breakfast'.toUpperCase(),
                style: AppTheme.bodyText1.copyWith(
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Center(
              child: Text(
                'Lunch'.toUpperCase(),
                style: AppTheme.bodyText1.copyWith(
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Center(
              child: Text(
                'Dinner'.toUpperCase(),
                style: AppTheme.bodyText1.copyWith(
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required DateTime date,
    required List<String> breakfast,
    required List<String> lunch,
    required List<String> dinner,
  }) {
    final height = MediaQuery.of(context).size.height;
    final cellHeight = (height - AppBar().preferredSize.height * 2.12) / 7;

    Widget _buildDateColumn() {
      return Container(
        height: cellHeight,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppTheme.lightGrey,
          border: Border.all(color: AppTheme.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: AppTheme.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.lightGrey),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      DateTimeUtils.getWeekDayName(date)
                          .substring(0, 1)
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: AppTheme.bodyText2,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              date.day.toString(),
              style: AppTheme.overline.copyWith(
                fontSize: height < 600 ? 0.0 : 12.0,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildMealItemsColumn(List<String> items) {
      return Container(
        height: cellHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.grey),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map(
                    (item) => Center(
                      child: Text(
                        item,
                        style: AppTheme.overline,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(flex: 5, child: _buildDateColumn()),
        Expanded(flex: 12, child: _buildMealItemsColumn(breakfast)),
        Expanded(flex: 12, child: _buildMealItemsColumn(lunch)),
        Expanded(flex: 12, child: _buildMealItemsColumn(dinner))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<WeekMenuViewModel>(
      onModelReady: (model) => model.fetchCurrentWeekMenu(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Mess Menu',
            style: AppTheme.headline1.copyWith(
              color: Colors.white,
              fontFamily: 'Lobster_Two',
            ),
          ),
        ),
        body: Column(
          children: [
            _buildWeekMenuHeader(),
            Expanded(
              child: () {
                switch (model.state) {
                  case ViewState.Idle:
                    var _mealCells = <Widget>[];
                    model.currentWeekMenu.dayMenus.forEach((dayMenu) {
                      var breakfast = <String>[];
                      var lunch = <String>[];
                      var dinner = <String>[];

                      dayMenu.meals.forEach(
                        (meal) {
                          meal.items.forEach((item) =>
                              print('item ${item.name} ${meal.type}'));
                          switch (meal.type) {
                            case MealType.B:
                              meal.items
                                  .forEach((item) => breakfast.add(item.name));
                              break;
                            case MealType.L:
                              meal.items
                                  .forEach((item) => lunch.add(item.name));
                              break;
                            case MealType.S:
                              break;
                            case MealType.D:
                              meal.items
                                  .forEach((item) => dinner.add(item.name));
                              break;
                          }
                        },
                      );

                      _mealCells.add(_buildTableRow(
                        date: dayMenu.date,
                        breakfast: breakfast,
                        lunch: lunch,
                        dinner: dinner,
                      ));
                    });

                    return ListView(
                      shrinkWrap: true,
                      children: _mealCells,
                    );

                  case ViewState.Busy:
                    return AppetizerProgressWidget();

                  case ViewState.Error:
                    if (model.errorMessage == Constants.MENU_NOT_FOUND) {
                      return AppetizerErrorWidget(
                        errorMessage: 'Menu not uploaded yet!',
                      );
                    }
                    return AppetizerErrorWidget(
                      errorMessage: model.errorMessage,
                      onRetryPressed: () => model.fetchCurrentWeekMenu(),
                    );

                  default:
                    return Container();
                }
              }(),
            ),
          ],
        ),
      ),
    );
  }
}
