import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveDropdownFilter extends StatefulWidget {
  final Function(String) onMonthSelected;
  final Function(int) onYearSelected;

  const LeaveDropdownFilter(
      {Key? key, required this.onMonthSelected, required this.onYearSelected})
      : super(key: key);

  @override
  _LeaveDropdownFilterState createState() => _LeaveDropdownFilterState();
}

class _LeaveDropdownFilterState extends State<LeaveDropdownFilter> {
  final _yearList = [
    DateTime.now().year,
    DateTime.now().year - 1,
    DateTime.now().year - 2,
    DateTime.now().year - 3,
    DateTime.now().year - 4,
  ];

  final _monthList = [
    'All',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  late String _selectedMonth;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedMonth = 'All';
    _selectedYear = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      color: AppTheme.secondary,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 6.r,
            horizontal: 12.r,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Filter by',
                style: AppTheme.subtitle1,
              ),
              SizedBox(height: 4.r),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Month',
                        style: AppTheme.subtitle2,
                      ),
                      Container(
                        width: 140.w,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppTheme.grey),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedMonth,
                            items: _monthList.map((String dropDownMonthItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownMonthItem,
                                child: Text(
                                  '$dropDownMonthItem',
                                  style: AppTheme.headline5.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newMonthSelected) {
                              setState(() => _selectedMonth = newMonthSelected!);
                              widget.onMonthSelected(newMonthSelected!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12.r),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Year',
                        style: AppTheme.subtitle1,
                      ),
                      Container(
                        width: 140.w,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppTheme.grey),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: _selectedYear,
                            items: _yearList.map((int dropDownYearItem) {
                              return DropdownMenuItem<int>(
                                value: dropDownYearItem,
                                child: Text(
                                  '$dropDownYearItem',
                                  style: AppTheme.headline5.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (int? newYearSelected) {
                              setState(() => _selectedYear = newYearSelected!);
                              widget.onYearSelected(newYearSelected!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
