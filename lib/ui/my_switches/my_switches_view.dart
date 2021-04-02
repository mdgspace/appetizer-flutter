import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/my_switches/components/switch_status_card.dart';
import 'package:appetizer/viewmodels/switches/my_switches_viewmodel.dart';
import 'package:flutter/material.dart';

class MySwitches extends StatelessWidget {
  static const String id = 'my_switches_view';

  Widget _buildSwitchHistoryComponent() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: AppTheme.grey),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'See Switch History',
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
    return BaseView<MySwitchesViewModel>(
      onModelReady: (model) => model.getRemainingSwitches(),
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'My Switches'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SwitchStatusCard(model.switchCount),
            _buildSwitchHistoryComponent()
          ],
        ),
      ),
    );
  }
}
