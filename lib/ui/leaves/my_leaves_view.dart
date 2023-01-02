import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/leaves/leave_history_view.dart';
import 'package:appetizer/ui/leaves/components/leave_status_card.dart';
import 'package:appetizer/viewmodels/leaves/my_leaves_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyLeavesView extends StatelessWidget {
  static const String id = 'my_leaves_view';

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
            padding: EdgeInsets.all(12.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'See Leave History',
                  style: AppTheme.subtitle2,
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
            LeaveStatusCard(model.leaveCount),
            _buildLeaveHistoryComponent()
          ],
        ),
      ),
    );
  }
}
