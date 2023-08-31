import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
import 'package:appetizer/domain/repositories/leave_repository.dart';
import 'package:appetizer/domain/repositories/menu_repository.dart';
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
          create: (context) => LeavesAndRebateBloc(),
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
