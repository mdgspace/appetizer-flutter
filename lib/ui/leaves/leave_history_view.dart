import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:flutter/material.dart';
import 'components/leave_dropdown_filter.dart';
import 'components/leave_timeline.dart';

class LeavesHistoryView extends StatefulWidget {
  static const String id = 'leaves_history_view';

  @override
  _LeavesHistoryViewState createState() => _LeavesHistoryViewState();
}

class _LeavesHistoryViewState extends State<LeavesHistoryView> {
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
    return Scaffold(
      appBar: AppetizerAppBar(title: 'Leave History'),
      body: Column(
        children: <Widget>[
          Container(
            height: 150.0,
            child: LeaveDropdownFilter(
              onMonthSelected: (month) => setState(
                () => _selectedMonth = month,
              ),
              onYearSelected: (year) => setState(
                () => _selectedYear = year,
              ),
            ),
          ),
          Expanded(
            child: LeaveTimeline(
              month: _selectedMonth,
              year: _selectedYear,
            ),
          ),
        ],
      ),
    );
  }
}
