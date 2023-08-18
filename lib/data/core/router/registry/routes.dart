part of '../router.dart';

class AppRoutesRegistry {
  AppRoutesRegistry._();

  static List<AutoRoute> routes = <AutoRoute>[
    CustomRoute(
      path: AppPathsRegistry.home,
      page: HomeRoute.page,
    ),
  ];
}
