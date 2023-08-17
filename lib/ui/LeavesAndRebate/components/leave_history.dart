import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/models/leaves/paginated_leaves.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveHistory extends StatelessWidget {
  const LeaveHistory({super.key, required this.paginatedLeaves});
  final PaginatedLeaves paginatedLeaves;

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
      children: [
        Text(paginatedLeaves.results[0].startDatetime.year as String),
        ...paginatedLeaves.results
            .map((leave) => Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: DateFormat('dd MMM').format(leave.startDatetime),
                        style: AppTheme.bodyText1.copyWith(height: 1),
                      ),
                    ),
                    Text("-"),
                    RichText(
                      text: TextSpan(
                        text: leave.startMealType,
                        style: AppTheme.bodyText1
                            .copyWith(height: 1, color: AppTheme.primary),
                      ),
                    ),
                  ],
                ))
            .toList(),
      ],
    );
  }
}
