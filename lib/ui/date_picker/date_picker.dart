import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Weekday -> mon = 1, sun = 7

void main() async {
  //await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(appBar: AppBar(), body: DatePicker()),
  ));
}

class DatePicker extends StatefulWidget{
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  DateTime activeDate;

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(
      initialPage: 1,
    );
    return PageView(
      controller: _pageController,
      children: <Widget>[
        DateRow(),
        DateRow(),
        DateRow()
      ],
    );
  }
}

class DateRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _padding = 20.0;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(_padding),
      child: Row(children: _currentRowWidgets(_padding)),
    );
  }

  List<Widget> _currentRowWidgets(double _padding) {
    final list = _currentRowDates().map((dateTime) {
      return DateCell(dateTime, _padding);
    }).toList(growable: false);
    return list;
  }

  List<DateTime> _currentRowDates() {
    List<DateTime> _dateList = List(7);
    final _now = DateTime.now();
    for (int i = _now.weekday - 1; i >= 1; i--) {
      _dateList[i - 1] =
          _now.subtract(Duration(hours: 24 * (_now.weekday - i)));
    }
    _dateList[_now.weekday - 1] = _now;
    for (int i = _now.weekday + 1; i <= 7; i++) {
      _dateList[i - 1] = _now.add(Duration(hours: 24 * (i - _now.weekday)));
    }
    print(_dateList);
    return _dateList;
  }
}

class DateCell extends StatelessWidget {
  final DateTime cellDate;
  final double _parentPadding;
  DateCell(this.cellDate, this._parentPadding);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final _scrW = MediaQuery.of(context).size.width - (2*_parentPadding);
    print("ScrW $_scrW");
    final _padding = 4.0;
    final _width = (_scrW - (14 * _padding)) / 7;
    print("W $_width");

    return Container(
      padding: EdgeInsets.all(_padding),
      child: Column(
        children: <Widget>[
          Container(
            width: _width,
            height: _width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Center(child: Text(cellDate.day.toString())),
          ),
          SizedBox(height: 4,),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: Text(DateTimeUtils.getWeekDayName(cellDate)[0]),
          ),
        ],
      ),
    );
  }
}
