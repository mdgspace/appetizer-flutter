part of '../router.dart';

class AppRoutesRegistry {
  AppRoutesRegistry._();

  static List<AutoRoute> routes = <AutoRoute>[
    CustomRoute(
      path: AppPathsRegistry.login,
      page: LoginRoute.page,
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
    CustomRoute(
      path: AppPathsRegistry.leavesAndRebate,
      page: LeavesAndRebateRoute.page,
    ),
    CustomRoute(
      path: AppPathsRegistry.profile,
      page: ProfileRoute.page,
    ),
    CustomRoute(
      path: AppPathsRegistry.weekMenu,
      page: YourWeekMenuRoute.page,
    ),
    // TODO: add route for OAuth
    // CustomRoute(
    //   path: AppPathsRegistry.oAuth,
    //   page: OAuthWebRoute.page,
    // )
  ];
}
