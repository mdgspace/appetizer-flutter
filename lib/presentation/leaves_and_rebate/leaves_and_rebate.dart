import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/domain/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/presentation/leaves_and_rebate/bloc/leaves_and_rebate_bloc.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/custom_divider.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/leave_history.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/monthly_rebates.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:appetizer/presentation/components/round_edge_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:math' as math;

class LeavesAndRebate extends StatelessWidget {
  const LeavesAndRebate(
      {super.key,
      required this.isCheckedOut,
      required this.initialYearlyRebates,
      required this.currYearLeaves,
      required this.mealsSkipped,
      required this.remainingLeaves});
  final bool isCheckedOut;
  final PaginatedYearlyRebate initialYearlyRebates;
  final PaginatedLeaves currYearLeaves;
  final int remainingLeaves, mealsSkipped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LeavesAndRebateBloc(
            isCheckedOut: isCheckedOut,
            currYearLeaves: currYearLeaves,
            mealsSkipped: mealsSkipped,
            remainingLeaves: remainingLeaves),
        child: BlocBuilder<LeavesAndRebateBloc, LeavesAndRebateState>(
          builder: (context, state) {
            return Column(
              children: [
                AppBanner(
                    height: 85.toAutoScaledHeight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          24.toAutoScaledWidth,
                          math.max(32.toAutoScaledHeight,
                              MediaQuery.of(context).padding.top),
                          0,
                          0),
                      child: Text(
                        "Leaves & Rebates",
                        style: AppTheme.headline1,
                      ),
                    )),
                ...[
                  if (state.isCheckedOut)
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 14.toAutoScaledHeight, 0, 14.toAutoScaledHeight),
                      child: Text(
                        "You are currently checked-out",
                        style: AppTheme.bodyText1.copyWith(
                            fontFamily: 'Noto Sans',
                            fontSize: 14.toAutoScaledFont,
                            color: AppTheme.customRed),
                      ),
                    ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, 0, 0, 14.toAutoScaledHeight),
                    child: GestureDetector(
                      onTap: () {
                        //TODO: add check in functionality
                      },
                      child: const RoundEdgeTextOnlyContainer(text: "CHECK IN"),
                    ),
                  )
                ],
                SizedBox(height: 40.toAutoScaledHeight),
                MonthlyRebates(
                    paginatedYearlyRebate: initialYearlyRebates,
                    currMonthIndex: DateTime.now().month - 1),
                SizedBox(height: 24.toAutoScaledHeight),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      40.toAutoScaledWidth, 0, 40.toAutoScaledWidth, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Remaining Leaves : ",
                              style: AppTheme.subtitle1.copyWith(
                                  fontSize: 14.toAutoScaledFont,
                                  color: AppTheme.black2e)),
                          Text(state.remainingLeaves.toString(),
                              style: AppTheme.headline2.copyWith(
                                  fontSize: 14.toAutoScaledFont,
                                  color: AppTheme.primary))
                        ],
                      ),
                      SizedBox(height: 12.toAutoScaledHeight),
                      Row(
                        children: [
                          Text("Meals Skipped : ",
                              style: AppTheme.subtitle1.copyWith(
                                  fontSize: 14.toAutoScaledFont,
                                  color: AppTheme.black2e)),
                          Text(state.mealsSkipped.toString(),
                              style: AppTheme.headline2.copyWith(
                                  fontSize: 14.toAutoScaledFont,
                                  color: AppTheme.primary))
                        ],
                      ),
                      SizedBox(height: 20.toAutoScaledHeight),
                      const CustomDivider(),
                    ],
                  ),
                ),
                SizedBox(height: 24.toAutoScaledHeight),
                LeaveHistory(paginatedLeaves: state.paginatedLeaves),
                SizedBox(height: 32.toAutoScaledHeight),
                if (!state.isCheckedOut)
                  GestureDetector(
                      child:
                          const RoundEdgeTextOnlyContainer(text: "CHECK OUT"))
              ],
            );
          },
        ));
  }
}
