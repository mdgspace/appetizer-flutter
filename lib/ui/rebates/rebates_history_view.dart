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

  int _currentItemSelected = DateTime.now().year;

  Widget _buildDropdownFilter() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: AppTheme.secondary,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Filter by',
                style: AppTheme.subtitle1,
              ),
              SizedBox(height: 4),
              Text(
                'Year',
                style: AppTheme.subtitle1,
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
                          style: AppTheme.headline3.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (int newValueSelected) {
                      setState(() => _currentItemSelected = newValueSelected);
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
      onModelReady: (model) => model.getYearlyRebate(_currentItemSelected),
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'Rebates History'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 150.0,
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
                          additionalMeal:
                              model.yearlyRebate.results[index].expenses,
                          month: DateTimeUtils.getMonthName(
                            DateTime(
                              DateTime.now().year,
                              model.yearlyRebate.results[index].monthId,
                            ),
                          ),
                          year: model.yearlyRebate.results[index].year,
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
