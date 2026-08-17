import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/domain/repositories/transaction_repositroy.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/custom_divider.dart';
import 'package:appetizer/presentation/components/shadow_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late num _totalRebate;
  late int year;

  @override
  void initState() {
    super.initState();
    year = DateTime.now().year;
    _currMonthIndex = widget.currMonthIndex;
    paginatedYearlyRebate = widget.paginatedYearlyRebate;
  }

  void _rebuildMonthlyMap() {
    _totalRebate = 0;
    _monthlyRebateMap.clear();
    if (paginatedYearlyRebate != null) {
      for (YearlyRebate yr in paginatedYearlyRebate!.results) {
        _monthlyRebateMap[_monthList[yr.monthId]] = yr.rebate;
        _totalRebate += yr.rebate;
      }
    }
    _monthlyRebateMap["All"] = _totalRebate;
  }

  @override
  void initState() {
    super.initState();
    year = DateTime.now().year;
    _currMonthIndex = widget.currMonthIndex;
    paginatedYearlyRebate = widget.paginatedYearlyRebate;
  }

  void _rebuildMonthlyMap() {
    _totalRebate = 0;
    _monthlyRebateMap.clear();
    if (paginatedYearlyRebate != null) {
      for (YearlyRebate yr in paginatedYearlyRebate!.results) {
        _monthlyRebateMap[_monthList[yr.monthId]] = yr.rebate;
        _totalRebate += yr.rebate;
      }
    }
    _monthlyRebateMap["All"] = _totalRebate;
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
    _currMonthIndex ??= widget.currMonthIndex;
    _currMonthName = _monthList[_currMonthIndex!];
    paginatedYearlyRebate ??= widget.paginatedYearlyRebate;
    _rebuildMonthlyMap();
    return ShadowContainer(
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
                      final selectedMonthIndex =
                          (_currMonthIndex == null || _currMonthIndex! < 1)
                              ? DateTime.now().month
                              : _currMonthIndex!;
                      DateTime? newDateTime = await showMonthPicker(
                        context: context,
                        confirmWidget: const Text(
                          'OK',
                          style: TextStyle(color: AppTheme.primary),
                        ),
                        cancelWidget: const Text(
                          'Cancel',
                          style: TextStyle(color: AppTheme.primary),
                        ),
                        initialDate: DateTime(year, selectedMonthIndex),
                        lastDate: DateTime.now(),
                      );
                      if (newDateTime == null) return;
                      if (!context.mounted) return;
                      if (newDateTime.year != year) {
                        try {
                          final repo = context.read<TransactionRepository>();
                          final data =
                              await repo.getYearlyRebates(newDateTime.year);
                          if (!context.mounted) return;
                          setState(() {
                            year = newDateTime.year;
                            paginatedYearlyRebate = data;
                            _currMonthIndex = newDateTime.month;
                            _rebuildMonthlyMap();
                          });
                        } catch (_) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Unable to load rebates for selected year',
                              ),
                            ),
                          );
                        }
                      } else if (newDateTime.month != _currMonthIndex) {
                        setState(() {
                          _currMonthIndex = newDateTime.month;
                        });
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _monthList[_currMonthIndex!].substring(0, 3),
                          style: AppTheme.bodyText1.copyWith(height: 1),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppTheme.blackPrimary,
                        )
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
                  Text(
                    "Rebates",
                    style: AppTheme.headline2.copyWith(
                      color: AppTheme.primary,
                      fontSize: 14.toAutoScaledFont,
                    ),
                  ),
                  Text(
                    "- Rs. ${_monthlyRebateMap[_currMonthName] ?? 0}",
                    style: AppTheme.headline2.copyWith(
                      color: AppTheme.primary,
                      fontSize: 14.toAutoScaledFont,
                    ),
                  )
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
                  Text(
                    "Total rebates till now",
                    style: AppTheme.bodyText1.copyWith(
                      height: 1,
                      color: AppTheme.grey2e,
                    ),
                  ),
                  Text(
                    "- Rs $_totalRebate",
                    style: AppTheme.bodyText1.copyWith(
                      height: 1,
                      color: AppTheme.grey2e,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
