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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: ShapeDecoration(
          color: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 7,
              offset: Offset(2, 2),
              spreadRadius: 1,
            )
          ]),
      child: SingleChildScrollView(
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          backgroundColor: AppTheme.white,
          title: SizedBox.shrink(),
          leading: Text("Leave History",
              style: AppTheme.headline3.copyWith(
                  fontSize: 16, color: AppTheme.grey2f, height: 11 / 8)),
          trailing: const Icon(Icons.expand_more, color: AppTheme.grey2f),
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paginatedLeaves.results[0].startDatetime.year.toString(),
                      style: AppTheme.headline2
                          .copyWith(fontSize: 14, color: AppTheme.primary),
                    ),
                    SizedBox(height: 10),
                    ...paginatedLeaves.results
                        .map((leave) => Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: DateFormat('dd MMM')
                                          .format(leave.startDatetime),
                                      style: AppTheme.bodyText1
                                          .copyWith(height: 1),
                                    ),
                                  ),
                                  Text("-"),
                                  RichText(
                                    text: TextSpan(
                                      text: leave.startMealType,
                                      style: AppTheme.bodyText1.copyWith(
                                          height: 1, color: AppTheme.primary),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
