import 'package:appetizer/app_theme.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/leaves/leave_status_card_viewmodel.dart';
import 'package:flutter/material.dart';

class LeaveStatusCard extends StatefulWidget {
  final int remainingLeaves;

  LeaveStatusCard(this.remainingLeaves);

  @override
  _LeaveStatusCardState createState() => _LeaveStatusCardState();
}

class _LeaveStatusCardState extends State<LeaveStatusCard> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LeaveStatusCardViewModel>(
      builder: (context, model, child) => Card(
        elevation: 5.0,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Your Status',
                        style: AppTheme.headline3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Remaining Leaves : ',
                            style: AppTheme.bodyText1,
                          ),
                          Text(
                            '${widget.remainingLeaves ?? '-'}',
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
                              color:
                                  isCheckedOut ? AppTheme.red : AppTheme.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.account_circle,
                    color: AppTheme.secondary,
                    size: 80,
                  ),
                ],
              ),
            ),
            Divider(color: AppTheme.grey, height: 0),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: isCheckedOut ? AppTheme.green : AppTheme.red,
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: model.onCheckTapped,
                child: Text(
                  (isCheckedOut) ? 'CHECK IN' : 'CHECK OUT',
                  style: AppTheme.headline4.copyWith(
                    color: AppTheme.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
