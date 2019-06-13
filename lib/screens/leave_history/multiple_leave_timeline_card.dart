import 'package:flutter/material.dart';

import 'multiple_leave_details.dart';
import 'multiple_leave_timeline_icon.dart';

class MultipleLeaveTimelineCard extends StatelessWidget{

  final String _mealFrom;
  final String _mealTo;
  final String _dayFrom;
  final String _dayTo;
  final int _dateFrom;
  final int _dateTo;
  final int _consecutiveLeaves;

  MultipleLeaveTimelineCard(
      this._mealFrom, this._mealTo,
      this._dayFrom, this._dayTo,
      this._dateFrom, this._dateTo,
      this._consecutiveLeaves
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156.0,
      width: 412.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 80.0,
            child: MultipleLeaveDetails(
                _mealFrom, _mealTo,
                _dayFrom, _dayTo,
                _dateFrom, _dateTo
            ),
          ),
          Positioned(
            top: 23.0,
            left: 59.0,
            child: MultipleLeaveTimelineIcon(_consecutiveLeaves),
          ),
        ],
      ),
    );
  }
}
