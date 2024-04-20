import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/presentation/components/no_data_found_container.dart';
import 'package:appetizer/presentation/week_menu/bloc/week_menu_bloc.dart';
import 'package:appetizer/presentation/week_menu/components/DayDateBar/day_date_bar.dart';
import 'package:appetizer/presentation/week_menu/components/DayMenu/day_menu.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:appetizer/presentation/components/loading_indicator.dart';
import 'package:appetizer/presentation/components/round_edge_container.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WeekMenuScreen extends StatelessWidget {
  const WeekMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeekMenuBlocBloc, WeekMenuBlocState>(
      builder: (context, state) {
        return Column(
          children: [
            AppBanner(
              height: 178.toAutoScaledHeight,
              child: SafeArea(child: DayDateBar()),
            ),
            if (state is WeekMenuErrorState)
              NoDataFoundContainer(
                title: state.message,
              ),
            if (state is WeekMenuBlocLoadingState)
              const Expanded(
                child: Center(
                  child: LoadingIndicator(),
                ),
              ),
            if (state is WeekMenuBlocDisplayState) ...[
              BlocSelector<AppBloc, AppState, bool>(
                selector: (appState) => appState.user!.isCheckedOut,
                builder: (context, isCheckedOut) {
                  if (!isCheckedOut) return const SizedBox();

                  return Column(
                    children: [
                      Text(
                        "You are currently checked-out",
                        style: AppTheme.bodyText1.copyWith(
                          fontFamily: 'Noto Sans',
                          fontSize: 14.toAutoScaledFont,
                          color: AppTheme.customRed,
                        ),
                      ),
                      14.toVerticalSizedBox,
                      GestureDetector(
                        onTap: () {
                          context
                              .read<AppBloc>()
                              .add(const ToggleCheckOutStatusEvent());
                          final bool isCheckout =
                              context.read<AppBloc>().state.user!.isCheckedOut;
                          // Triggers when clicked on check-in button to avoid false triggers on failed checkouts
                          if (isCheckout) {
                            context
                                .read<WeekMenuBlocBloc>()
                                .add(const CheckoutEvent());
                          }
                        },
                        child:
                            const RoundEdgeTextOnlyContainer(text: "CHECK IN"),
                      ),
                      14.toVerticalSizedBox,
                    ],
                  );
                },
              ),
              Expanded(
                child: (state.dayNumber != -1)
                    ? DayMenuWidget(parentState: state)
                    : const NoDataFoundContainer(title: 'Menu not available'),
              ),
            ]
          ],
        );
      },
      listener: (BuildContext context, WeekMenuBlocState state) {
        if (state is WeekMenuBlocDisplayState && state.error.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: AppTheme.customRed,
            ),
          );
        }
      },
    );
  }
}
