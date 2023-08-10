import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class LeaveHistory extends StatelessWidget {
  const LeaveHistory({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: wrap with Shadow Container
    return ExpansionTile(
      backgroundColor: AppTheme.white,
      title: Text("Leave History",
          style: AppTheme.headline3.copyWith(
            fontSize: 16,
            color: AppTheme.grey2f,
          )),
      trailing: const Icon(Icons.expand_more, color: AppTheme.grey2f),
      children: [],
    );
  }
}
