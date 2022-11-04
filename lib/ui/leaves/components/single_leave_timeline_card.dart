import 'package:appetizer/app_theme.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SingleLeaveTimelineCard extends StatelessWidget {
  final String meal;
  final String day;
  final DateTime leaveDate;

  SingleLeaveTimelineCard({Key? key, required this.meal, day, required this.leaveDate})
      : day = DateTimeUtils.getWeekDayName(leaveDate)
            .substring(0, 3)
            .toUpperCase(),
        super(key: key);

  Widget _buildStartChild() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat.LLL().format(leaveDate),
          style: AppTheme.bodyText1,
        ),
        Text(
          leaveDate.year.toString(),
          style: AppTheme.bodyText1,
        ),
      ],
    );
  }

  Widget _buildEndChild() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$meal',
            style: AppTheme.subtitle1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$day',
                style: AppTheme.bodyText2,
              ),
              Text(
                '${leaveDate.toLocal().day}',
                style: AppTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTimelineIcon() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      indicatorStyle: IndicatorStyle(
        width: 8,
        height: 8,
        drawGap: true,
        indicator: _buildTimelineIcon(),
      ),
      afterLineStyle: LineStyle(
        color: AppTheme.lightGrey,
        thickness: 1,
      ),
      beforeLineStyle: LineStyle(
        color: AppTheme.lightGrey,
        thickness: 1,
      ),
      startChild: _buildStartChild(),
      endChild: _buildEndChild(),
    );
  }
}
