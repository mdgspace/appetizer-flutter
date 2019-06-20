import 'package:flutter/material.dart';

import 'single_leave_details.dart';
import 'single_leave_timeline_icon.dart';

class SingleLeaveTimelineCard extends StatelessWidget{

  final String _meal;
  final String _day;
  final int _date;

  SingleLeaveTimelineCard(this._meal, this._day, this._date);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.0,
      width: 412.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 80.0,
            child: SingleLeaveDetails(_meal, _day, _date),
          ),
          Positioned(
            top:18.0,
            left: 73.0,
            child: SingleLeaveTimelineIcon(),
          ),
        ],
      ),
    );
  }
}
