import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  void popUntilFirstScreen() {
    return navigatorKey.currentState.popUntil((route) => route.isFirst);
  }

  void pop() {
    return navigatorKey.currentState.pop();
  }
}
