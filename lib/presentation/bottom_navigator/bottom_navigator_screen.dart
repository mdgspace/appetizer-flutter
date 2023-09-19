import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
import 'package:appetizer/domain/repositories/leave/leave_repository.dart';
import 'package:appetizer/domain/repositories/menu_repository.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/domain/repositories/transaction_repositroy.dart';
import 'package:appetizer/presentation/components/round_edge_container.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:appetizer/presentation/leaves_and_rebate/bloc/leaves_and_rebate_bloc.dart';
import 'package:appetizer/presentation/profile/bloc/profile_page_bloc.dart';
import 'package:appetizer/presentation/week_menu/bloc/week_menu_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage()
class BottomNavigatorScreen extends StatelessWidget {
  const BottomNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LeavesAndRebateBloc(
            leaveRepository: context.read<LeaveRepository>(),
            transactionRepository: context.read<TransactionRepository>(),
          )..add(const FetchLeavesAndRebates()),
        ),
        BlocProvider<WeekMenuBlocBloc>(
          create: (context) => WeekMenuBlocBloc(
            menuRepository: context.read<MenuRepository>(),
            leaveRepository: context.read<LeaveRepository>(),
          )..add(const FetchWeekMenuData()),
        ),
        BlocProvider(
          create: (context) =>
              ProfilePageBloc(repo: context.read<UserRepository>())
                ..add(const FetchProfile()),
        ),
      ],
      child: AutoTabsRouter(
        routes: const [
          LeavesAndRebateRoute(),
          WeekMenuRoute(),
          ProfileRoute(),
        ],
        builder: (context, child) {
          final tabRouter = AutoTabsRouter.of(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: child,
            floatingActionButton: Visibility(
              visible: tabRouter.activeIndex == 1,
              child: BlocSelector<AppBloc, AppState, bool>(
                selector: (appState) => appState.user!.isCheckedOut,
                builder: (context, isCheckedOut) {
                  if (isCheckedOut) return const SizedBox();

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
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            bottomNavigationBar: BottomNavigationBar(
              key: UniqueKey(),
              currentIndex: tabRouter.activeIndex,
              onTap: (index) {
                tabRouter.setActiveIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.wallet_outlined),
                  activeIcon: Icon(Icons.wallet),
                  label: 'Rebate',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Menu',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
