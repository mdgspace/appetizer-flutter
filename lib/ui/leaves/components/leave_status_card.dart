import 'package:appetizer/app_theme.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/leaves/leave_status_card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveStatusCard extends StatelessWidget {
  final int? remainingLeaves;
  const LeaveStatusCard(this.remainingLeaves);

  @override
  Widget build(BuildContext context) {
    return BaseView<LeaveStatusCardViewModel>(
      builder: (context, model, child) => Column(
        children: [
          Card(
            elevation: 5.0,
            margin: EdgeInsets.all(6.r),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Your Status',
                            style: AppTheme.headline4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Remaining Leaves : ',
                                style: AppTheme.bodyText1,
                              ),
                              Text(
                                '${remainingLeaves ?? '-'}',
                                style: AppTheme.subtitle1,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Currently : ',
                                style: AppTheme.bodyText1,
                              ),
                              Text(
                                (isCheckedOut) ? 'CHECKED-OUT' : 'CHECKED-IN',
                                style: AppTheme.subtitle1.copyWith(
                                  color: isCheckedOut
                                      ? AppTheme.red
                                      : AppTheme.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.account_circle,
                        color: AppTheme.secondary,
                        size: 70.r,
                      ),
                    ],
                  ),
                ),
                Divider(color: AppTheme.grey, height: 0),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.all(4.r),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isCheckedOut ? AppTheme.green : AppTheme.red,
                      padding: EdgeInsets.all(8.r),
                    ),
                    onPressed: () {
                      model.onCheckTapped();
                    },
                    child: Text(
                      (isCheckedOut) ? 'CHECK IN' : 'CHECK OUT',
                      style: AppTheme.headline5.copyWith(
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          (isCheckedOut)
              ? _buildInfoComponent('Check-in to start taking meals again')
              : _buildInfoComponent(
                  'Check-out to leave upcoming meals in sequence'),
        ],
      ),
    );
  }

  Widget _buildInfoComponent(String info) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: AppTheme.lightGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.info,
            size: 16.r,
            color: AppTheme.blackSecondary,
          ),
          SizedBox(width: 8.r),
          Text(
            info,
            style: AppTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
