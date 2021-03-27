import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/leave_history/multiple_leave_timeline_card.dart';
import 'package:appetizer/ui/leave_history/single_leave_timeline_card.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/utils/month_string_to_month_int.dart';
import 'package:appetizer/viewmodels/leaves/leave_timeline_viewmodel.dart';
import 'package:appetizer/viewmodels/year_and_month_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentMonthAndYear = Provider.of<YearAndMonthModel>(context);
    var year = currentMonthAndYear.currentYearSelected;
    var month = monthStringToMonthInt(currentMonthAndYear.currentMonthSelected);

    return BaseView<LeaveTimelineViewModel>(
      onModelReady: (model) => model.fetchLeaves(year, month),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? AppetizerProgressWidget()
          : model.state == ViewState.Error
              ? AppetizerErrorWidget(
                  errorMessage: model.errorMessage,
                )
              : Builder(
                  builder: (context) {
                    var leavesArray = [];
                    for (var leaves in model.paginatedLeaves.results) {
                      if (leaves.mealCount != 1) {
                        leavesArray.add(
                          MultipleLeaveTimelineCard(
                              leaves.startMealType,
                              leaves.endMealType,
                              DateTimeUtils.getWeekDayName(
                                      DateTime.fromMillisecondsSinceEpoch(
                                              leaves.startDatetime)
                                          .toLocal())
                                  .substring(0, 3)
                                  .toUpperCase(),
                              DateTimeUtils.getWeekDayName(
                                      DateTime.fromMillisecondsSinceEpoch(
                                              leaves.endDatetime)
                                          .toLocal())
                                  .substring(0, 3)
                                  .toUpperCase(),
                              DateTime.fromMillisecondsSinceEpoch(
                                      leaves.startDatetime)
                                  .toLocal()
                                  .day,
                              DateTime.fromMillisecondsSinceEpoch(
                                      leaves.endDatetime)
                                  .toLocal()
                                  .day,
                              leaves.mealCount),
                        );
                      } else {
                        leavesArray.add(
                          SingleLeaveTimelineCard(
                            leaves.startMealType,
                            DateTimeUtils.getWeekDayName(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            leaves.startDatetime)
                                        .toLocal())
                                .substring(0, 3)
                                .toUpperCase(),
                            DateTime.fromMillisecondsSinceEpoch(
                                    leaves.startDatetime)
                                .toLocal()
                                .day,
                          ),
                        );
                      }
                    }
                    return ListView.builder(
                      itemCount: leavesArray.length,
                      itemBuilder: (context, index) {
                        return leavesArray[index];
                      },
                    );
                  },
                ),
    );
  }
}
