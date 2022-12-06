import 'dart:math' as math;

import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/date_picker_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppetizerDatePicker extends StatefulWidget {
  final Function(DateTime) onDateChanged;

  const AppetizerDatePicker({required this.onDateChanged});

  @override
  _AppetizerDatePickerState createState() => _AppetizerDatePickerState();
}

class _AppetizerDatePickerState extends State<AppetizerDatePicker> {
  late DatePickerViewModel _model;
  late int indexState;

  @override
  void initState() {
    super.initState();
    indexState = 11;
  }

  List<DateTime> _currentRowDates(DateTime anchor) {
    var _dateList = List<DateTime>.filled(7, DateTime.now());
    for (var i = anchor.weekday - 1; i >= 1; i--) {
      _dateList[i - 1] = anchor.subtract(Duration(days: (anchor.weekday - i)));
    }
    _dateList[anchor.weekday - 1] = anchor;
    for (var i = anchor.weekday + 1; i <= 7; i++) {
      _dateList[i - 1] = anchor.add(Duration(days: (i - anchor.weekday)));
    }
    return _dateList;
  }

  List<Widget> _currentRowWidgets(DateTime anchor, BoxConstraints constraints) {
    final list = _currentRowDates(anchor).map((dateTime) {
      return _buildDateCell(dateTime, constraints);
    }).toList(growable: false);
    return list;
  }

  Widget _buildDateCell(DateTime cellDate, BoxConstraints constraints) {
    final _scrW = MediaQuery.of(context).size.width;
    final _padding = 10.r;
    final _minWidth = (_scrW - (14 * _padding)) / 7;
    final _minHeight = (constraints.maxHeight - _padding / 2) / 2;

    final _width = math.min(_minWidth, _minHeight);

    bool _isCellDateCurrentDate() {
      return cellDate.day == DateTime.now().day &&
          cellDate.weekday == DateTime.now().weekday;
    }

    bool _isCellDateSelectedDate() {
      return cellDate == _model.dateTime;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _padding,
        vertical: _padding / 4,
      ),
      color: AppTheme.secondary,
      height: 80.r,
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
                  fontSize: 10.sp,
                  color: _isCellDateSelectedDate()
                      ? AppTheme.primary
                      : _isCellDateCurrentDate()
                          ? AppTheme.yellow
                          : AppTheme.white,
                ),
              ),
            ),
            SizedBox(height: 4.r),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _dateWidgets,
      ),
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
          return LayoutBuilder(builder: (context, constraints) {
            return _buildDateRow(
              _currentRowWidgets(_model.dateTime, constraints),
            );
          });
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
