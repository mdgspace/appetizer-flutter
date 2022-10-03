import 'package:appetizer/app_theme.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MultipleLeaveTimelineCard extends StatelessWidget {
  final String mealFrom;
  final String mealTo;
  final String dayFrom;
  final String dayTo;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int consecutiveLeaves;

  MultipleLeaveTimelineCard({
    this.mealFrom,
    this.mealTo,
    dayFrom,
    dayTo,
    this.dateFrom,
    this.dateTo,
    this.consecutiveLeaves,
  })  : dayFrom = DateTimeUtils.getWeekDayName(dateFrom)
            .substring(0, 3)
            .toUpperCase(),
        dayTo =
            DateTimeUtils.getWeekDayName(dateTo).substring(0, 3).toUpperCase();

  Widget _buildStartChild() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat.LLL().format(dateTo),
          style: AppTheme.bodyText1,
        ),
        Text(
          dateTo.year.toString(),
          style: AppTheme.bodyText1,
        ),
      ],
    );
  }

  Widget _buildEndChild() {
    return Container(
      height: 140.r,
      padding: EdgeInsets.fromLTRB(6.r, 12.r, 18.r, 12.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '$mealTo',
                style: AppTheme.subtitle1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$dayTo',
                    style: AppTheme.bodyText2,
                  ),
                  Text(
                    '${dateTo.toLocal().day}',
                    style: AppTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '$mealFrom',
                style: AppTheme.subtitle1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$dayFrom',
                    style: AppTheme.bodyText2,
                  ),
                  Text(
                    '${dateFrom.toLocal().day}',
                    style: AppTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineIcon() {
    return Container(
      height: 160,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 28,
            child: VerticalDivider(),
          ),
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primary),
            ),
          ),
          Expanded(
            child: VerticalDivider(
              color: AppTheme.primary,
              width: 2,
            ),
          ),
          Container(
            height: 30.r,
            width: 30.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primary),
            ),
            child: Center(
              child: Text(
                '$consecutiveLeaves',
                style: AppTheme.headline1.copyWith(
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
          Expanded(
            child: VerticalDivider(
              color: AppTheme.primary,
              width: 2.r,
            ),
          ),
          Container(
            height: 6.r,
            width: 6.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primary),
            ),
          ),
          SizedBox(
            height: 20.r,
            child: VerticalDivider(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      indicatorStyle: IndicatorStyle(
        width: 30.r,
        height: 140.r,
        drawGap: true,
        indicator: _buildTimelineIcon(),
      ),
      startChild: _buildStartChild(),
      endChild: _buildEndChild(),
    );
  }
}
