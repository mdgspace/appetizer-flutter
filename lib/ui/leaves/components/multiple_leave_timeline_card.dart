import 'package:appetizer/app_theme.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
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
    required this.mealFrom,
    required this.mealTo,
    dayFrom,
    dayTo,
    required this.dateFrom,
    required this.dateTo,
    required this.consecutiveLeaves,
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
      height: 160,
      padding: const EdgeInsets.symmetric(vertical: 16).add(
        EdgeInsets.only(right: 24, left: 8),
      ),
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
            height: 40,
            width: 40,
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
              width: 2,
            ),
          ),
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primary),
            ),
          ),
          SizedBox(
            height: 28,
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
        width: 40,
        height: 160,
        drawGap: true,
        indicator: _buildTimelineIcon(),
      ),
      startChild: _buildStartChild(),
      endChild: _buildEndChild(),
    );
  }
}
