import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/leaves/components/multiple_leave_timeline_card.dart';
import 'package:appetizer/ui/leaves/components/single_leave_timeline_card.dart';
import 'package:appetizer/utils/string_utils.dart';
import 'package:appetizer/viewmodels/leaves/leave_timeline_viewmodel.dart';
import 'package:flutter/material.dart';

class LeaveTimeline extends StatelessWidget {
  final String month;
  final int year;

  const LeaveTimeline({Key key, this.month, this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LeaveTimelineViewModel>(
      onModelReady: (model) =>
          model.fetchLeaves(year, StringUtils.monthStringToInt(month)),
      onDidUpdateWidget: (_, model) =>
          model.fetchLeaves(year, StringUtils.monthStringToInt(month)),
      builder: (context, model, child) => () {
        switch (model.state) {
          case ViewState.Idle:
            var _leaves = model.paginatedLeaves.results.map((leave) {
              if (leave.mealCount > 1) {
                return MultipleLeaveTimelineCard(
                  mealFrom: leave.startMealType,
                  mealTo: leave.endMealType,
                  dateFrom: leave.startDatetime,
                  dateTo: leave.endDatetime,
                  consecutiveLeaves: leave.mealCount,
                );
              } else {
                return SingleLeaveTimelineCard(
                  meal: leave.startMealType,
                  leaveDate: leave.startDatetime,
                );
              }
            }).toList();
            return ListView.separated(
              itemCount: _leaves.length,
              itemBuilder: (context, index) => _leaves[index],
              separatorBuilder: (context, index) => Divider(height: 0),
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
