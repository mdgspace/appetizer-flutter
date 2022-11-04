import 'package:appetizer/constants.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/menu/other_day_menu_view.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/utils/string_utils.dart';
import 'package:appetizer/viewmodels/menu/other_menu_viewmodel.dart';
import 'package:flutter/material.dart';

class OtherMenuView extends StatefulWidget {
  final String hostelName;
  final DateTime selectedDateTime;

  const OtherMenuView({Key? key, required this.hostelName, required this.selectedDateTime})
      : super(key: key);
  @override
  _OtherMenuViewState createState() => _OtherMenuViewState();
}

class _OtherMenuViewState extends State<OtherMenuView> {
  late OtherMenuViewModel _model;

  @override
  void didUpdateWidget(covariant OtherMenuView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (DateTimeUtils.getWeekNumber(oldWidget.selectedDateTime) !=
        DateTimeUtils.getWeekNumber(widget.selectedDateTime)) {
      _model.fetchHostelWeekMenu(
        DateTimeUtils.getWeekNumber(widget.selectedDateTime),
        StringUtils.hostelNameToCode(widget.hostelName),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OtherMenuViewModel>(
      onModelReady: (model) {
        _model = model;
        _model.fetchInitialCheckedStatus();
        _model.fetchHostelWeekMenu(
          DateTimeUtils.getWeekNumber(widget.selectedDateTime),
          StringUtils.hostelNameToCode(widget.hostelName),
        );
      },
      builder: (context, model, child) => Expanded(
        child: () {
          switch (model.state) {
            case ViewState.Idle:
              DayMenu? selectedDayMenu;
              model.hostelWeekMenu.dayMenus.forEach((dayMenu) {
                if (dayMenu.date.weekday == widget.selectedDateTime.weekday) {
                  selectedDayMenu = dayMenu;
                }
              });
              if (selectedDayMenu == null) {
                return AppetizerErrorWidget(
                  errorMessage:
                      'The menu for this day has not been uploaded yet!',
                );
              }
              final dailyItems = model.hostelWeekMenu.dailyItems;
              return OtherDayMenuView(
                dayMenu: selectedDayMenu!,
                dailyItems: dailyItems,
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
                onRetryPressed: () => model.fetchHostelWeekMenu(
                  DateTimeUtils.getWeekNumber(widget.selectedDateTime),
                  StringUtils.hostelNameToCode(widget.hostelName),
                ),
              );

            default:
              return Container();
          }
        }(),
      ),
    );
  }
}
