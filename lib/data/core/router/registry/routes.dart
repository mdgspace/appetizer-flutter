part of '../router.dart';

class AppRoutesRegistry {
  AppRoutesRegistry._();

  static List<AutoRoute> routes = <AutoRoute>[
    CustomRoute(
      path: AppPathsRegistry.loginWrapper,
      page: LoginWrapper.page,
      children: [
        CustomRoute(
          path: AppPathsRegistry.oAuth,
          page: OAuthWebRoute.page,
        ),
        CustomRoute(
          initial: true,
          path: AppPathsRegistry.login,
          page: LoginRoute.page,
        ),
      ],
    ),
    CustomRoute(
      path: AppPathsRegistry.homeWrapper,
      page: HomeWrapper.page,
      children: [
        CustomRoute(
          initial: true,
          path: AppPathsRegistry.bottomNav,
          page: BottomNavigatorRoute.page,
          children: [
            CustomRoute(
              path: AppPathsRegistry.leavesAndRebate,
              page: LeavesAndRebateRoute.page,
            ),
            CustomRoute(
              path: AppPathsRegistry.profile,
              page: ProfileRoute.page,
            ),
            CustomRoute(
              initial: true,
              path: AppPathsRegistry.weekMenu,
              page: WeekMenuRoute.page,
            ),
          ],
        ),
        CustomRoute(
          path: AppPathsRegistry.home,
          page: HomeRoute.page,
        ),
        CustomRoute(
          path: AppPathsRegistry.coupon,
          page: CouponsRoute.page,
        ),
        CustomRoute(
          path: AppPathsRegistry.notification,
          page: NotificationRoute.page,
        ),
      ],
    ),
  ];
}
