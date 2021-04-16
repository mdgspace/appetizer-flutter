import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class SingleLeaveTimelineCard extends StatelessWidget {
  final String meal;
  final String day;
  final int date;

  SingleLeaveTimelineCard(this.meal, this.day, this.date);

  Widget _buildLeaveDetails() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.lightGrey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  '$date',
                  style: AppTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineIcon() {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
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
      ),
    );
  }
}
