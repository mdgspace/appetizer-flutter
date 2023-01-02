import 'package:appetizer/app_theme.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/rebates/components/monthly_rebate_card.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/rebates/rebates_history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RebatesHistoryView extends StatefulWidget {
  static const String id = 'rebates_history_view';

  @override
  _RebatesHistoryViewState createState() => _RebatesHistoryViewState();
}

class _RebatesHistoryViewState extends State<RebatesHistoryView> {
  final _yearList = [
    DateTime.now().year,
    DateTime.now().year - 1,
    DateTime.now().year - 2,
    DateTime.now().year - 3,
    DateTime.now().year - 4,
  ];
  late RebatesHistoryViewModel _model;

  int _currentItemSelected = DateTime.now().year;

  Widget _buildDropdownFilter() {
    return Container(
      padding: EdgeInsets.all(8.r),
      color: AppTheme.secondary,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Filter by',
                style: AppTheme.subtitle1,
              ),
              SizedBox(height: 4.r),
              Text(
                'Year',
                style: AppTheme.subtitle2,
              ),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppTheme.grey),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _currentItemSelected,
                    items: _yearList.map((int year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text(
                          '$year',
                          style: AppTheme.headline4.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (int? newValueSelected) {
                      setState(() => _currentItemSelected = newValueSelected!);
                      _model.getYearlyRebate(_currentItemSelected);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<RebatesHistoryViewModel>(
      onModelReady: (model) {
        _model = model;
        model.getYearlyRebate(_currentItemSelected);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'Rebates History'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 135.r,
              child: _buildDropdownFilter(),
            ),
            Expanded(
              child: () {
                switch (model.state) {
                  case ViewState.Idle:
                    return ListView.builder(
                      itemCount: model.yearlyRebate.count,
                      itemBuilder: (BuildContext context, int index) {
                        var _yearlyRebate = model.yearlyRebate.results[index];
                        return MonthlyRebateCard(
                          balanceConsumed: 0,
                          rebate: _yearlyRebate.rebate,
                          additionalMeal: _yearlyRebate.expenses,
                          month: DateTimeUtils.getMonthName(
                            DateTime(
                              DateTime.now().year,
                              _yearlyRebate.monthId,
                            ),
                          ),
                          year: _yearlyRebate.year,
                        );
                      },
                    );

                  case ViewState.Busy:
                    return AppetizerProgressWidget();

                  case ViewState.Error:
                    return AppetizerErrorWidget(
                      errorMessage: model.errorMessage,
                      onRetryPressed: () =>
                          model.getYearlyRebate(_currentItemSelected),
                    );

                  default:
                    return Container();
                }
              }(),
            ),
          ],
        ),
      ),
    );
  }
}
