import 'dart:math' as math;

import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/leaves_and_rebate/bloc/leaves_and_rebate_bloc.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/custom_divider.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/leave_history.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:appetizer/presentation/components/round_edge_container.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LeavesAndRebateScreen extends StatelessWidget {
  const LeavesAndRebateScreen({super.key});

  // final bool isCheckedOut;
  // final PaginatedYearlyRebate initialYearlyRebates;
  // final PaginatedLeaves currYearLeaves;
  // final int remainingLeaves, mealsSkipped;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeavesAndRebateBloc, LeavesAndRebateState>(
      builder: (context, state) {
        return Column(
          children: [
            AppBanner(
              height: 85.toAutoScaledHeight,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.toAutoScaledWidth,
                  top: math.max(32.toAutoScaledHeight,
                      MediaQuery.of(context).padding.top),
                ),
                child: Text(
                  "Leaves & Rebates",
                  style: AppTheme.headline1,
                ),
              ),
            ),
            ...[
              if (state.isCheckedOut)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 14.toAutoScaledHeight,
                  ),
                  child: Text(
                    "You are currently checked-out",
                    style: AppTheme.bodyText1.copyWith(
                        fontFamily: 'Noto Sans',
                        fontSize: 14.toAutoScaledFont,
                        color: AppTheme.customRed),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(bottom: 14.toAutoScaledHeight),
                child: GestureDetector(
                  onTap: () {
                    //TODO: add check in functionality
                  },
                  child: const RoundEdgeTextOnlyContainer(text: "CHECK IN"),
                ),
              )
            ],
            40.toVerticalSizedBox,
            // MonthlyRebates(
            //     paginatedYearlyRebate: initialYearlyRebates,
            //     currMonthIndex: DateTime.now().month - 1),
            24.toVerticalSizedBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.toAutoScaledWidth),
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
                  12.toVerticalSizedBox,
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
                  20.toVerticalSizedBox,
                  const CustomDivider(),
                ],
              ),
            ),
            24.toVerticalSizedBox,
            if (state.paginatedLeaves != null)
              LeaveHistory(paginatedLeaves: state.paginatedLeaves!),
            32.toVerticalSizedBox,
            if (!state.isCheckedOut)
              GestureDetector(
                child: const RoundEdgeTextOnlyContainer(text: "CHECK OUT"),
              )
          ],
        );
      },
    );
  }
}
