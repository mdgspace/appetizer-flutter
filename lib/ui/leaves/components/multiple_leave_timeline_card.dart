import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class MultipleLeaveTimelineCard extends StatelessWidget {
  final String mealFrom;
  final String mealTo;
  final String dayFrom;
  final String dayTo;
  final int dateFrom;
  final int dateTo;
  final int consecutiveLeaves;

  MultipleLeaveTimelineCard(
    this.mealFrom,
    this.mealTo,
    this.dayFrom,
    this.dayTo,
    this.dateFrom,
    this.dateTo,
    this.consecutiveLeaves,
  );

  Widget _buildLeaveDetails() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.lightGrey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      '$dateTo',
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
                      '$dateFrom',
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
      ),
    );
  }

  Widget _buildTimelineIcon() {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          left: 80,
          child: _buildLeaveDetails(),
        ),
        Positioned.fill(
          left: 80,
          child: _buildTimelineIcon(),
        ),
      ],
    );
  }
}
