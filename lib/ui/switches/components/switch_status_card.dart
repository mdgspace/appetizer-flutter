import 'package:appetizer/app_theme.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/switches/switch_status_card_viewmodel.dart';
import 'package:flutter/material.dart';

class SwitchStatusCard extends StatefulWidget {
  final int? remainingSwitches;

  SwitchStatusCard(this.remainingSwitches);

  @override
  _SwitchStatusCardState createState() => _SwitchStatusCardState();
}

class _SwitchStatusCardState extends State<SwitchStatusCard> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SwitchStatusCardViewModel>(
      builder: (context, model, child) => Card(
        elevation: 5.0,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
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
                        'Remaining Switches : ',
                        style: AppTheme.bodyText1,
                      ),
                      Text(
                        '${widget.remainingSwitches ?? '-'}',
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
                          color: isCheckedOut ? AppTheme.red : AppTheme.green,
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
      ),
    );
  }
}
