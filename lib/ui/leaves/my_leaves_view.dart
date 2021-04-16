import 'package:appetizer/app_theme.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/leaves/leave_history_view.dart';
import 'package:appetizer/ui/leaves/components/leave_status_card.dart';
import 'package:appetizer/viewmodels/leaves/my_leaves_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLeavesView extends StatelessWidget {
  static const String id = 'my_leaves_view';

  Widget _buildInfoComponent(String info) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: AppTheme.lightGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.info,
            size: 20,
            color: AppTheme.blackSecondary,
          ),
          SizedBox(width: 8),
          Text(
            info,
            style: AppTheme.bodyText2,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveHistoryComponent() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: AppTheme.grey),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Get.toNamed(LeavesHistoryView.id),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'See Leave History',
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
    return BaseView<MyLeavesViewModel>(
      onModelReady: (model) => model.getRemainingLeaves(),
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'My Leaves'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                LeaveStatusCard(model.leaveCount),
                (Globals.isCheckedOut)
                    ? _buildInfoComponent(
                        'Check-in to start taking meals again')
                    : _buildInfoComponent(
                        'Check-out to leave upcoming meals in sequence'),
              ],
            ),
            _buildLeaveHistoryComponent()
          ],
        ),
      ),
    );
  }
}
