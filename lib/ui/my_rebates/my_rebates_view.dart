import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/my_rebates/components/monthly_balance_card.dart';
import 'package:appetizer/ui/rebate_history/rebate_history_screen.dart';
import 'package:appetizer/viewmodels/rebates/my_rebates_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRebatesView extends StatelessWidget {
  static const String id = 'my_rebates_view';

  Widget _buildRebatesHistoryComponent() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: AppTheme.grey),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Get.toNamed(RebateHistoryScreen.id),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'See Rebates History',
                  style: AppTheme.subtitle1,
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MyRebatesViewModel>(
      onModelReady: (model) => model.getMonthlyRebate(),
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'My Rebates'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MonthlyBalanceCard(
              balanceConsumed: 0,
              rebate: model.monthlyRebate,
              additionalMeal: 0,
            ),
            _buildRebatesHistoryComponent(),
          ],
        ),
      ),
    );
  }
}
