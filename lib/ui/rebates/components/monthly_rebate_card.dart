import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthlyRebateCard extends StatelessWidget {
  final num balanceConsumed;
  final num rebate;
  final num additionalMeal;
  final num totalBalance;
  final String month;
  final int year;

  MonthlyRebateCard({
    this.balanceConsumed = 0,
    this.rebate = 0,
    this.additionalMeal = 0,
    required this.month,
    required this.year,
  }) : totalBalance = balanceConsumed + additionalMeal - rebate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(6.r),
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Monthly Balance',
                    style: AppTheme.headline3,
                  ),
                  Text(
                    '$month $year',
                    style: AppTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0),
          Container(
            padding: EdgeInsets.all(12.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Balance Consumed',
                      style: AppTheme.bodyText2,
                    ),
                    Text(
                      '- Rs. $balanceConsumed',
                      style: AppTheme.bodyText2.copyWith(
                        color: AppTheme.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Rebate',
                      style: AppTheme.bodyText2,
                    ),
                    Text(
                      '- Rs. $rebate',
                      style: AppTheme.bodyText2.copyWith(
                        color: AppTheme.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Additional Meal Taken',
                      style: AppTheme.bodyText2,
                    ),
                    Text(
                      '- Rs. $additionalMeal',
                      style: AppTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Rs. ${totalBalance.abs()}',
                  style: AppTheme.headline4.copyWith(
                    color: totalBalance <= 0 ? AppTheme.green : AppTheme.red,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
