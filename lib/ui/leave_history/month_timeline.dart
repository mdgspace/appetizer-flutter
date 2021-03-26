import 'package:flutter/material.dart';
import 'timeline_data.dart';

class MonthTimeline extends StatelessWidget {
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
              child: ListView.builder(
                itemCount: _monthData.leaveDetails.length,
                itemBuilder: (context, index) {
                  return _monthData.leaveDetails[index];
                },
              ))
        ],
      ),
    );
  }
}
