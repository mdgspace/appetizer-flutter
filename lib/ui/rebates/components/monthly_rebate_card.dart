import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyRebateCard extends StatelessWidget {
  final int? balanceConsumed;
  final int? rebate;
  final int? additionalMeal;
  final String? month;
  final int? year;

  MonthlyRebateCard({
    this.balanceConsumed,
    this.rebate,
    this.additionalMeal,
    this.month,
    this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Monthly Balance',
                    style: AppTheme.headline3,
                  ),
                  Text(
                    '${DateFormat.MMMM().format(DateTime.now())} ${DateTime.now().year}',
                    style: AppTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0),
          Container(
            padding: const EdgeInsets.all(16),
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
                      '- Rs. ${balanceConsumed ?? 0}',
                      style: AppTheme.bodyText2.copyWith(
                        color: AppTheme.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Rebate',
                      style: AppTheme.bodyText2,
                    ),
                    Text(
                      '- Rs. ${rebate ?? 0}',
                      style: AppTheme.bodyText2.copyWith(
                        color: AppTheme.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Additional Meal Taken',
                      style: AppTheme.bodyText2,
                    ),
                    Text(
                      '- Rs. ${additionalMeal ?? 0}',
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
                  'Rs. ' +
                      (balanceConsumed ?? 0 + (additionalMeal ?? 0) - (rebate ?? 0))
                          .toString(),
                  style: AppTheme.headline4,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
