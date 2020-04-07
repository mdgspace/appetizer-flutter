import 'package:appetizer/change_notifiers/current_date_model.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

// Weekday -> mon = 1, sun = 7

// This is to test the DatePicker individually if you make any changes
/*
void main() async {
  //await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: ChangeNotifierProvider(
          create: (context) => CurrentDateModel(),
          child: DatePicker(),
        ),
      ),
    ),
  );
}
*/

class DatePicker extends StatefulWidget {
  final double padding;

  const DatePicker({this.padding = 16});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime activeDate;
  int indexState;
  CurrentDateModel dateModel;

  @override
  void initState() {
    super.initState();
    indexState = 11;
    activeDate = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dateModel = Provider.of<CurrentDateModel>(context);
    if (dateModel != this.dateModel) {
      this.dateModel = dateModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(
      initialPage: 11,
    );
    return PageView.builder(
      pageSnapping: true,
      controller: _pageController,
      itemBuilder: (context, index) {
        return DateRow(_currentRowWidgets(dateModel.dateTime), widget.padding);
      },
      onPageChanged: (index) {
        print("PAGE: $index");
        if (index < indexState) {
          dateModel.setDateTime(
              dateModel.dateTime.subtract(Duration(days: 7)), context);
        } else {
          dateModel.setDateTime(
              dateModel.dateTime.add(Duration(days: 7)), context);
        }
        indexState = index;
      },
    );
  }

  List<Widget> _currentRowWidgets(DateTime anchor) {
    final list = _currentRowDates(anchor).map((dateTime) {
      return DateCell(dateTime, widget.padding);
    }).toList(growable: false);
    return list;
  }

  List<DateTime> _currentRowDates(anchor) {
    List<DateTime> _dateList = List(7);
    for (int i = anchor.weekday - 1; i >= 1; i--) {
      _dateList[i - 1] = anchor.subtract(Duration(days: (anchor.weekday - i)));
    }
    _dateList[anchor.weekday - 1] = anchor;
    for (int i = anchor.weekday + 1; i <= 7; i++) {
      _dateList[i - 1] = anchor.add(Duration(days: (i - anchor.weekday)));
    }
//    print(_dateList);
    return _dateList;
  }
}

class DateRow extends StatelessWidget {
  final List<Widget> _dateWidgets;
  final double padding;

  const DateRow(this._dateWidgets, this.padding);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appiBrown,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(padding),
      child: Row(children: _dateWidgets),
    );
  }
}

class DateCell extends StatelessWidget {
  final DateTime cellDate;
  final double _parentPadding;

  DateCell(this.cellDate, this._parentPadding);

  @override
  Widget build(BuildContext context) {
    final _scrW = MediaQuery.of(context).size.width - (2 * _parentPadding);
    final _padding = 8.0;
    final _width = (_scrW - (14 * _padding)) / 7;

    bool _isCellDateCurrentDate() {
      return cellDate.day == DateTime.now().day &&
          cellDate.weekday == DateTime.now().weekday;
    }

    bool _isCellDateSelectedDate() {
      return cellDate == Provider.of<CurrentDateModel>(context).dateTime;
    }

    return Container(
      padding: EdgeInsets.all(_padding),
      color: appiBrown,
      height: 90,
      child: GestureDetector(
        onTap: () {
          Provider.of<CurrentDateModel>(context, listen: false)
              .setDateTime(cellDate, context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Text(
                DateTimeUtils.getWeekDayName(cellDate)[0],
                style: TextStyle(
                  color: _isCellDateSelectedDate()
                      ? appiYellow
                      : _isCellDateCurrentDate() ? appiYellow : Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              width: _width,
              height: _width,
              decoration: BoxDecoration(
                color:
                    _isCellDateSelectedDate() ? appiYellow : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isCellDateSelectedDate()
                      ? appiBrown
                      : _isCellDateCurrentDate() ? appiYellow : Colors.white,
                ),
              ),
              child: Center(
                  child: Text(
                cellDate.day.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: _isCellDateSelectedDate()
                      ? appiBrown
                      : _isCellDateCurrentDate() ? appiYellow : Colors.white,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
