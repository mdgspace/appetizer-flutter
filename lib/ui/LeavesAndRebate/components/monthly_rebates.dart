import 'package:appetizer/app_theme.dart';
import 'package:appetizer/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/ui/LeavesAndRebate/components/custom_divider.dart';
import 'package:flutter/material.dart';

class MonthlyRebates extends StatefulWidget {
  const MonthlyRebates(
      {super.key,
      required this.paginatedYearlyRebate,
      required this.currMonthIndex});
  final PaginatedYearlyRebate paginatedYearlyRebate;
  final int currMonthIndex; //1-indexed
  @override
  State<MonthlyRebates> createState() => _MonthlyRebatesState();
}

//TODO: confirm if the monthId in YearlyRebate model is 0 indexed or 1 indexed?
class _MonthlyRebatesState extends State<MonthlyRebates> {
  late int _currMonthIndex;
  late Map<String, num> _monthlyRebateMap;
  late String _currMonthName;
  num _totalRebate = 0;

  @override
  void initState() {
    _currMonthIndex = widget.currMonthIndex;
    _currMonthName = _monthList[_currMonthIndex];
    for (YearlyRebate yr in widget.paginatedYearlyRebate.results) {
      _monthlyRebateMap[_monthList[yr.monthId]] = yr.rebate;
      _totalRebate += yr.rebate;
    }
    _monthlyRebateMap["All"] = _totalRebate;
    super.initState();
  }

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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      width: 312,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Monthly Rebates",
                style: AppTheme.headline3.copyWith(
                  color: AppTheme.black1e,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              DropdownButton(
                style: AppTheme.bodyText1.copyWith(height: 1),
                value: _currMonthName,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppTheme.black1e,
                ),
                selectedItemBuilder: ((BuildContext context) {
                  return _monthList.map((String monthName) {
                    return Text(monthName,
                        style: AppTheme.bodyText1.copyWith(height: 1));
                  }).toList();
                }),
                items: _monthList.map(
                  (String monthName) {
                    return DropdownMenuItem(
                      value: monthName,
                      child: Container(
                        width: 87,
                        height: 24,
                        padding: EdgeInsets.only(left: 7),
                        decoration: ShapeDecoration(
                          color: AppTheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          monthName,
                          style: AppTheme.bodyText1.copyWith(height: 1),
                        ),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (String? newMonthName) {
                  setState(
                    () {
                      _currMonthName = newMonthName!;
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rebates",
                  style: AppTheme.headline2
                      .copyWith(color: AppTheme.primary, fontSize: 14)),
              Text("- Rs. ${_monthlyRebateMap[_currMonthName]}",
                  style: AppTheme.headline2
                      .copyWith(color: AppTheme.primary, fontSize: 14))
            ],
          ),
          SizedBox(height: 16),
          CustomDivider(),
          SizedBox(height: 8),
          Row(
            children: [
              Text("Total rebates till now",
                  style: AppTheme.bodyText1
                      .copyWith(height: 1, color: AppTheme.grey2e)),
              Text("- Rs ${_totalRebate}",
                  style: AppTheme.bodyText1
                      .copyWith(height: 1, color: AppTheme.grey2e))
            ],
          )
        ],
      ),
    );
  }
}
