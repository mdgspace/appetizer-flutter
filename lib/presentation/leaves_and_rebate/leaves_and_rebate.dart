import 'package:appetizer/app_theme.dart';
import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/domain/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/presentation/leaves_and_rebate/bloc/leaves_and_rebate_bloc.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/custom_divider.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/leave_history.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/monthly_rebates.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:appetizer/presentation/components/round_edge_container.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LeavesAndRebateScreen extends StatelessWidget {
  const LeavesAndRebateScreen({
    required this.isCheckedOut,
    required this.initialYearlyRebates,
    required this.currYearLeaves,
    required this.mealsSkipped,
    required this.remainingLeaves,
    super.key,
  });

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
                      padding: const EdgeInsets.fromLTRB(24, 32, 0, 0),
                      child: Text(
                        "Leaves & Rebates",
                        style: AppTheme.headline1,
                      ),
                    )),
                ...[
                  if (state.isCheckedOut)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
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
                      child: const RoundEdgeTextOnlyContainer(text: "CHECK IN"),
                    ),
                  )
                ],
                const SizedBox(height: 40),
                MonthlyRebates(
                    paginatedYearlyRebate: initialYearlyRebates,
                    currMonthIndex: DateTime.now().month - 1),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
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
                      const SizedBox(height: 12),
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
                      const SizedBox(height: 20),
                      const CustomDivider(),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                LeaveHistory(paginatedLeaves: state.paginatedLeaves),
                const SizedBox(height: 32),
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
