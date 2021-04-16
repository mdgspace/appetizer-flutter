import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/leaves/components/multiple_leave_timeline_card.dart';
import 'package:appetizer/ui/leaves/components/single_leave_timeline_card.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/leaves/leave_timeline_viewmodel.dart';
import 'package:flutter/material.dart';

class LeaveTimeline extends StatelessWidget {
  final String month;
  final int year;

  const LeaveTimeline({Key key, this.month, this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LeaveTimelineViewModel>(
      onModelReady: (model) => model.fetchLeaves(year, 1),
      builder: (context, model, child) => () {
        switch (model.state) {
          case ViewState.Idle:
            var _leaves = model.paginatedLeaves.results.map((leave) {
              if (leave.mealCount != 1) {
                return MultipleLeaveTimelineCard(
                  leave.startMealType,
                  leave.endMealType,
                  DateTimeUtils.getWeekDayName(
                    DateTime.fromMillisecondsSinceEpoch(
                      leave.startDatetime,
                    ),
                  ).substring(0, 3).toUpperCase(),
                  DateTimeUtils.getWeekDayName(
                    DateTime.fromMillisecondsSinceEpoch(
                      leave.endDatetime,
                    ),
                  ).substring(0, 3).toUpperCase(),
                  DateTime.fromMillisecondsSinceEpoch(
                    leave.startDatetime,
                  ).toLocal().day,
                  DateTime.fromMillisecondsSinceEpoch(
                    leave.endDatetime,
                  ).toLocal().day,
                  leave.mealCount,
                );
              } else {
                return SingleLeaveTimelineCard(
                  leave.startMealType,
                  DateTimeUtils.getWeekDayName(
                    DateTime.fromMillisecondsSinceEpoch(
                      leave.startDatetime,
                    ),
                  ).substring(0, 3).toUpperCase(),
                  DateTime.fromMillisecondsSinceEpoch(
                    leave.startDatetime,
                  ).toLocal().day,
                );
              }
            }).toList();
            return ListView.builder(
              itemCount: _leaves.length,
              itemBuilder: (context, index) => _leaves[index],
            );
            break;
          case ViewState.Busy:
            return AppetizerProgressWidget();
            break;
          case ViewState.Error:
            return AppetizerErrorWidget(
              errorMessage: model.errorMessage,
              onRetryPressed: () => model.fetchLeaves(year, 1),
            );
            break;
          default:
            return Container();
        }
      }(),
    );
  }
}
