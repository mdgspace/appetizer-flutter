import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/models/leaves/paginated_leaves.dart';
import 'package:appetizer_revamp_parts/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer_revamp_parts/ui/LeavesAndRebate/bloc/leaves_and_rebate_bloc.dart';
import 'package:appetizer_revamp_parts/ui/LeavesAndRebate/components/custom_divider.dart';
import 'package:appetizer_revamp_parts/ui/LeavesAndRebate/components/leave_history.dart';
import 'package:appetizer_revamp_parts/ui/LeavesAndRebate/components/monthly_rebates.dart';
import 'package:appetizer_revamp_parts/ui/components/app_banner.dart';
import 'package:appetizer_revamp_parts/ui/components/round_edge_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
                    height: 85,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24, 32, 0, 0),
                      child: Text(
                        "Leaves & Rebates",
                        style: AppTheme.headline1,
                      ),
                    )),
                ...[
                  if (state.isCheckedOut)
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                      child: Text(
                        "You are currently checked-out",
                        style: AppTheme.bodyText1.copyWith(
                            fontFamily: 'Noto Sans',
                            fontSize: 14,
                            color: AppTheme.customRed),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                    child: GestureDetector(
                      onTap: () {
                        //TODO: add check in functionality
                      },
                      child: RoundEdgeTextOnlyContainer(text: "CHECK IN"),
                    ),
                  )
                ],
                SizedBox(height: 40),
                MonthlyRebates(
                    paginatedYearlyRebate: initialYearlyRebates,
                    currMonthIndex: DateTime.now().month - 1),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Remaining Leaves : ",
                              style: AppTheme.subtitle1.copyWith(
                                  fontSize: 14, color: AppTheme.black2e)),
                          Text(state.remainingLeaves.toString(),
                              style: AppTheme.headline2.copyWith(
                                  fontSize: 14, color: AppTheme.primary))
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Text("Meals Skipped : ",
                              style: AppTheme.subtitle1.copyWith(
                                  fontSize: 14, color: AppTheme.black2e)),
                          Text(state.mealsSkipped.toString(),
                              style: AppTheme.headline2.copyWith(
                                  fontSize: 14, color: AppTheme.primary))
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomDivider(),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                LeaveHistory(paginatedLeaves: state.paginatedLeaves),
                SizedBox(height: 32),
                if (!state.isCheckedOut)
                  GestureDetector(
                      child: RoundEdgeTextOnlyContainer(text: "CHECK OUT"))
              ],
            );
          },
        ));
  }
}
