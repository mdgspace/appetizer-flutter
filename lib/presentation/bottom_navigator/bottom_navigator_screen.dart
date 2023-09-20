import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
import 'package:appetizer/domain/repositories/leave/leave_repository.dart';
import 'package:appetizer/domain/repositories/menu_repository.dart';
import 'package:appetizer/domain/repositories/transaction_repositroy.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/presentation/components/round_edge_container.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:appetizer/presentation/leaves_and_rebate/bloc/leaves_and_rebate_bloc.dart';
import 'package:appetizer/presentation/profile/bloc/profile_page_bloc.dart';
import 'package:appetizer/presentation/week_menu/bloc/week_menu_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          ),
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
            floatingActionButton: (tabRouter.activeIndex == 1 &&
                    !context.read<AppBloc>().state.user!.isCheckedOut)
                ? GestureDetector(
                    onTap: () {
                      context
                          .read<AppBloc>()
                          .add(const ToggleCheckOutStatusEvent());
                    },
                    child: const RoundEdgeTextOnlyContainer(text: "CHECK IN"),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            bottomNavigationBar: BottomNavigationBar(
              key: UniqueKey(),
              currentIndex: tabRouter.activeIndex,
              onTap: (index) {
                tabRouter.setActiveIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      'assets/icons/bottom_navigator/rebate.svg'),
                  activeIcon: SvgPicture.asset(
                      'assets/icons/bottom_navigator/selected_rebate.svg'),
                  label: 'Rebate',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      'assets/icons/bottom_navigator/menu.svg'),
                  activeIcon: SvgPicture.asset(
                      'assets/icons/bottom_navigator/selected_menu.svg'),
                  label: 'Menu',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      'assets/icons/bottom_navigator/profile.svg'),
                  activeIcon: SvgPicture.asset(
                      'assets/icons/bottom_navigator/selected_profile.svg'),
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
