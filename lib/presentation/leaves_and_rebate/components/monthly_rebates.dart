import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/custom_divider.dart';
import 'package:appetizer/presentation/components/shadow_container.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthlyRebates extends StatefulWidget {
  const MonthlyRebates({
    required this.paginatedYearlyRebate,
    required this.currMonthIndex,
    super.key,
  });
  final PaginatedYearlyRebate paginatedYearlyRebate;
  final int currMonthIndex; //1-indexed

  @override
  State<MonthlyRebates> createState() => _MonthlyRebatesState();
}

class _MonthlyRebatesState extends State<MonthlyRebates> {
  int? _currMonthIndex;
  PaginatedYearlyRebate? paginatedYearlyRebate;
  final Map<String, num> _monthlyRebateMap = {};
  String? _currMonthName;
  num _totalRebate = 0;
  late int year;
  // final TransactionApi _transactionApi = locator<TransactionApi>();

  // @override
  // void initState() {
  //   _currMonthIndex = widget.currMonthIndex;
  //   _currMonthName = _monthList[_currMonthIndex];
  //   for (YearlyRebate yr in widget.paginatedYearlyRebate.results) {
  //     _monthlyRebateMap[_monthList[yr.monthId]] = yr.rebate;
  //     _totalRebate += yr.rebate;
  //   }
  //   _monthlyRebateMap["All"] = _totalRebate;
  //   super.initState();
  // }

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
    _currMonthIndex ??= widget.currMonthIndex;
    _currMonthName = _monthList[_currMonthIndex!];
    paginatedYearlyRebate ??= widget.paginatedYearlyRebate;
    for (YearlyRebate yr in paginatedYearlyRebate!.results) {
      _monthlyRebateMap[_monthList[yr.monthId]] = yr.rebate;
      _totalRebate += yr.rebate;
    }
    _monthlyRebateMap["All"] = _totalRebate;
    year = DateTime.now().year;
    return ShadowContainer(
      height: 134.toAutoScaledHeight,
      width: 312.toAutoScaledWidth,
      offset: 2,
      child: Padding(
        padding: EdgeInsets.all(16.toAutoScaledWidth),
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
                    fontSize: 20.toAutoScaledFont,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: 87.toAutoScaledWidth,
                  height: 24.toAutoScaledHeight,
                  decoration: ShapeDecoration(
                    color: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? newDateTime = await showMonthPicker(
                        context: context,
                        headerColor: AppTheme.primary,
                        selectedMonthBackgroundColor: AppTheme.primary,
                        unselectedMonthTextColor: AppTheme.primary,
                        confirmWidget: const Text(
                          'OK',
                          style: TextStyle(color: AppTheme.primary),
                        ),
                        cancelWidget: const Text(
                          'Cancel',
                          style: TextStyle(color: AppTheme.primary),
                        ),
                        initialDate: DateTime(year, _currMonthIndex!),
                        lastDate: DateTime.now(),
                      );
                      if (newDateTime != null &&
                          newDateTime.year == year &&
                          newDateTime.month != _currMonthIndex) {
                        setState(() {
                          _currMonthIndex = newDateTime.month;
                        });
                      }
                      // if (newDateTime != null && newDateTime.year != year) {
                      //   setState(() async {
                      //     year = newDateTime.year;
                      //     _currMonthIndex = newDateTime.month;
                      //     PaginatedYearlyRebate paginatedYearlyRebate =
                      //         await _transactionApi.getYearlyRebate(year);
                      //     _totalRebate = 0;
                      //     for (YearlyRebate yr
                      //         in paginatedYearlyRebate.results) {
                      //       _monthlyRebateMap[_monthList[yr.monthId]] = yr.rebate;
                      //       _totalRebate += yr.rebate;
                      //     }
                      //     _monthlyRebateMap["All"] = _totalRebate;
                      //   });
                      // }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_monthList[_currMonthIndex!].substring(0, 3),
                            style: AppTheme.bodyText1.copyWith(height: 1)),
                        const Icon(Icons.keyboard_arrow_down,
                            color: AppTheme.blackPrimary)
                      ],
                    ),
                  ),
                )
              ],
            ),
            16.toVerticalSizedBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.toAutoScaledWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rebates",
                      style: AppTheme.headline2.copyWith(
                          color: AppTheme.primary,
                          fontSize: 14.toAutoScaledFont)),
                  Text("- Rs. ${_monthlyRebateMap[_currMonthName] ?? 0}",
                      style: AppTheme.headline2.copyWith(
                          color: AppTheme.primary,
                          fontSize: 14.toAutoScaledFont))
                ],
              ),
            ),
            16.toVerticalSizedBox,
            const CustomDivider(),
            8.toVerticalSizedBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.toAutoScaledWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total rebates till now",
                      style: AppTheme.bodyText1
                          .copyWith(height: 1, color: AppTheme.grey2e)),
                  Text("- Rs $_totalRebate",
                      style: AppTheme.bodyText1
                          .copyWith(height: 1, color: AppTheme.grey2e))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
