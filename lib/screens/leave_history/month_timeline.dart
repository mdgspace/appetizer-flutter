import 'package:flutter/material.dart';

import 'data_classes.dart';
import 'multiple_leave_timeline_card.dart';
import 'single_leave_timeline_card.dart';

class MonthTimeline extends StatelessWidget{

  final TimelineData _monthData;


  MonthTimeline(this._monthData);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 262.0,
      width: 412.0,
      child: Stack(
        children: <Widget>[
          Container(),
          Positioned(
            left: 11.0,
            top: 0.0,
            child: Container(
              height: 50.0,
              width: 55.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${_monthData.month}',
                    style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.87),
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    '${_monthData.year}',
                    style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.87),
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            top: 0.0,
            child: Column(
              children: <Widget>[
                SingleLeaveTimelineCard('Breakfast', 'WED', 19),
                MultipleLeaveTimelineCard('Breakfast','Dinner', 'FRI', 'WED', 19, 21, 9),
                SingleLeaveTimelineCard('Breakfast', 'WED', 19),
              ],
//            TODO: IMPLEMENT FUNCTION
//                children: _builtLeaveList()
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> _builtLeaveList() {
  return null;
//  (_leaveDetailsData.singleLeave)?
//  SingleLeaveTimelineCard
//    (_leaveDetailsData.meal, _leaveDetailsData.day, _leaveDetailsData.date)
//      :
//  MultipleLeaveTimelineCard(
//      _leaveDetailsData.mealFrom, _leaveDetailsData.mealTo,
//      _leaveDetailsData.dayFrom, _leaveDetailsData.dayTo,
//      _leaveDetailsData.dateFrom, _leaveDetailsData.dateTo,
//      _leaveDetailsData.consecutiveLeaves
//  )
}
