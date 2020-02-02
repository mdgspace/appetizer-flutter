import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Weekday -> mon = 1, sun = 7

void main() async {
  //await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(appBar: AppBar(), body: DateRow()),
  ));
}

class DateRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: _currentRowWidgets());
  }

  List<Widget> _currentRowWidgets() {
    final list =  _currentRowDates().map((dateTime) {
      return DateCell(dateTime);
    }).toList(growable: false);return list;
  }

  List<DateTime> _currentRowDates() {
    List<DateTime> _dateList = List(7);
    final _now = DateTime.now();
    for (int i = _now.weekday-1; i >= 1; i--) {
      _dateList[i - 1] = _now.subtract(Duration(hours: 24*(_now.weekday-i)));
    }
    _dateList[_now.weekday - 1] = _now;
    for (int i = _now.weekday+1; i <= 7; i++) {
      _dateList[i - 1] = _now.add(Duration(hours: 24*(i-_now.weekday)));
    }
    print(_dateList);
    return _dateList;
  }
}

class DateCell extends StatelessWidget {
  final DateTime cellDate;

  DateCell(this.cellDate);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(),
          ),
          child: Center(child: Text(cellDate.day.toString())),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Text(DateTimeUtils.getWeekDayName(cellDate)[0]),
        ),
      ],
    );
  }
}
