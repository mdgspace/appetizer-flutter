import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveHistory extends StatelessWidget {
  const LeaveHistory({super.key, required this.paginatedLeaves});
  final PaginatedLeaves paginatedLeaves;

  @override
  Widget build(BuildContext context) {
    //TODO: wrap with Shadow Container
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: ShapeDecoration(
          color: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 7.toAutoScaledWidth,
              offset: Offset(2, 2),
              spreadRadius: 1,
            )
          ]),
      child: SingleChildScrollView(
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          backgroundColor: AppTheme.white,
          title: const SizedBox.shrink(),
          leading: Text("Leave History",
              style: AppTheme.headline3.copyWith(
                  fontSize: 16.toAutoScaledFont,
                  color: AppTheme.grey2f,
                  height: (11.0 / 8.0).toAutoScaledHeight)),
          trailing: const Icon(Icons.expand_more, color: AppTheme.grey2f),
          children: [
            Container(
              margin: EdgeInsets.only(left: 24.toAutoScaledWidth),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paginatedLeaves.results[0].startDatetime.year.toString(),
                      style: AppTheme.headline2.copyWith(
                          fontSize: 14.toAutoScaledFont,
                          color: AppTheme.primary),
                    ),
                    const SizedBox(height: 10),
                    ...paginatedLeaves.results
                        .map((leave) => Padding(
                              padding: EdgeInsets.only(
                                  bottom: 10.toAutoScaledHeight),
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: DateFormat('dd MMM -')
                                            .format(leave.startDatetime),
                                        style: AppTheme.bodyText1.copyWith(
                                            height: 1.toAutoScaledHeight),
                                        children: [
                                          TextSpan(
                                            text: leave.startMealType,
                                            style: const TextStyle(
                                                color: AppTheme.primary),
                                          )
                                        ]),
                                  ),
                                  // const Text("-"),
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
