import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/date_picker_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppetizerDatePicker extends StatefulWidget {
  final Function(DateTime) onDateChanged;

  const AppetizerDatePicker({this.onDateChanged});

  @override
  _AppetizerDatePickerState createState() => _AppetizerDatePickerState();
}

class _AppetizerDatePickerState extends State<AppetizerDatePicker> {
  DatePickerViewModel _model;
  int indexState;

  @override
  void initState() {
    super.initState();
    indexState = 11;
  }

  List<DateTime> _currentRowDates(anchor) {
    var _dateList = List<DateTime>.filled(7, DateTime.now());
    for (int i = anchor.weekday - 1; i >= 1; i--) {
      _dateList[i - 1] = anchor.subtract(Duration(days: (anchor.weekday - i)));
    }
    _dateList[anchor.weekday - 1] = anchor;
    for (int i = anchor.weekday + 1; i <= 7; i++) {
      _dateList[i - 1] = anchor.add(Duration(days: (i - anchor.weekday)));
    }
    return _dateList;
  }

  List<Widget> _currentRowWidgets(DateTime anchor) {
    final list = _currentRowDates(anchor).map((dateTime) {
      return _buildDateCell(dateTime);
    }).toList(growable: false);
    return list;
  }

  Widget _buildDateCell(DateTime cellDate) {
    final _scrW = MediaQuery.of(context).size.width;
    final _padding = 8.0;
    final _width = (_scrW - (14 * _padding)) / 7;

    bool _isCellDateCurrentDate() {
      return cellDate.day == DateTime.now().day &&
          cellDate.weekday == DateTime.now().weekday;
    }

    bool _isCellDateSelectedDate() {
      return cellDate == _model.dateTime;
    }

    return Container(
      padding: EdgeInsets.all(_padding),
      color: AppTheme.secondary,
      height: 90,
      child: GestureDetector(
        onTap: () {
          _model.setDateTime(cellDate);
          widget.onDateChanged(cellDate);
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
                      ? AppTheme.primary
                      : _isCellDateCurrentDate()
                          ? AppTheme.yellow
                          : AppTheme.white,
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              width: _width,
              height: _width,
              decoration: BoxDecoration(
                color: _isCellDateSelectedDate()
                    ? AppTheme.primary
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isCellDateSelectedDate()
                      ? AppTheme.secondary
                      : _isCellDateCurrentDate()
                          ? AppTheme.primary
                          : AppTheme.white,
                ),
              ),
              child: Center(
                child: Text(
                  cellDate.day.toString(),
                  style: AppTheme.subtitle1.copyWith(
                    color: _isCellDateSelectedDate()
                        ? AppTheme.secondary
                        : _isCellDateCurrentDate()
                            ? AppTheme.primary
                            : AppTheme.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow(List<Widget> _dateWidgets) {
    return Container(
      color: AppTheme.secondary,
      width: MediaQuery.of(context).size.width,
      child: Row(children: _dateWidgets),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(initialPage: 11);
    return BaseView<DatePickerViewModel>(
      onModelReady: (model) {
        _model = model;
        _model.dateTime = DateTime.now();
        _model.weekId = DateTimeUtils.getWeekNumber(_model.dateTime);
        _model.weekDidChange = false;
      },
      builder: (context, model, child) => PageView.builder(
        pageSnapping: true,
        controller: _pageController,
        itemBuilder: (context, index) {
          return _buildDateRow(
            _currentRowWidgets(_model.dateTime),
          );
        },
        onPageChanged: (index) {
          print('PAGE: $index');
          var _newDate;
          if (index < indexState) {
            _newDate = _model.dateTime.subtract(Duration(days: 7));
            _model.setDateTime(_newDate);
          } else {
            _newDate = _model.dateTime.add(Duration(days: 7));
            _model.setDateTime(_newDate);
          }
          widget.onDateChanged(_newDate);
          indexState = index;
        },
      ),
    );
  }
}
