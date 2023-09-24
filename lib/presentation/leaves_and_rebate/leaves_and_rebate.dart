import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/presentation/components/loading_indicator.dart';
import 'package:appetizer/presentation/leaves_and_rebate/bloc/leaves_and_rebate_bloc.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/custom_divider.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/leave_history.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:appetizer/presentation/components/round_edge_container.dart';
import 'package:appetizer/presentation/leaves_and_rebate/components/monthly_rebates.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LeavesAndRebateScreen extends StatelessWidget {
  const LeavesAndRebateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeavesAndRebateBloc, LeavesAndRebateState>(
      builder: (context, state) {
        return Column(
          children: [
            AppBanner(
              height: 140.toAutoScaledHeight,
              child: Row(
                children: [
                  SizedBox(
                    width: 12.toAutoScaledWidth,
                  ),
                  Text(
                    'Leaves & Rebates',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.toAutoScaledWidth,
                      fontFamily: 'Noto Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            if (state.loading) ...[
              const Expanded(
                child: Center(
                  child: LoadingIndicator(),
                ),
              ),
            ],
            if (!state.loading) ...[
              BlocSelector<AppBloc, AppState, bool>(
                selector: (appState) => appState.user!.isCheckedOut,
                builder: (context, value) {
                  if (!value) return const SizedBox();

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.toAutoScaledHeight,
                        ),
                        child: Text(
                          "You are currently checked-out",
                          style: AppTheme.bodyText1.copyWith(
                            fontFamily: 'Noto Sans',
                            fontSize: 14.toAutoScaledFont,
                            color: AppTheme.customRed,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<AppBloc>()
                              .add(const ToggleCheckOutStatusEvent());
                        },
                        child: const RoundEdgeTextOnlyContainer(
                          text: "CHECK IN",
                        ),
                      ),
                      10.toVerticalSizedBox,
                    ],
                  );
                },
              ),
              20.toVerticalSizedBox,
              MonthlyRebates(
                paginatedYearlyRebate: state.initialPaginatedYearlyRebate!,
                currMonthIndex: DateTime.now().month - 1,
              ),
              24.toVerticalSizedBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.toAutoScaledWidth),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Remaining Leaves : ",
                          style: AppTheme.subtitle1.copyWith(
                            fontSize: 14.toAutoScaledFont,
                            color: AppTheme.black2e,
                          ),
                        ),
                        Text(
                          state.remainingLeaves.toString(),
                          style: AppTheme.headline2.copyWith(
                            fontSize: 14.toAutoScaledFont,
                            color: AppTheme.primary,
                          ),
                        )
                      ],
                    ),
                    12.toVerticalSizedBox,
                    Row(
                      children: [
                        Text(
                          "Meals Skipped : ",
                          style: AppTheme.subtitle1.copyWith(
                            fontSize: 14.toAutoScaledFont,
                            color: AppTheme.black2e,
                          ),
                        ),
                        Text(
                          state.mealsSkipped.toString(),
                          style: AppTheme.headline2.copyWith(
                            fontSize: 14.toAutoScaledFont,
                            color: AppTheme.primary,
                          ),
                        )
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
              BlocSelector<AppBloc, AppState, bool>(
                selector: (appState) => appState.user!.isCheckedOut,
                builder: (context, value) {
                  if (value) return const SizedBox();

                  return GestureDetector(
                    onTap: () {
                      context
                          .read<AppBloc>()
                          .add(const ToggleCheckOutStatusEvent());
                    },
                    child: const RoundEdgeTextOnlyContainer(text: "CHECK OUT"),
                  );
                },
              ),
            ]
          ],
        );
      },
    );
  }
}
