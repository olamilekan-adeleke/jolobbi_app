import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._internal();
  static final AppRouter instance = AppRouter._internal();
  factory AppRouter() => instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> popAndNavigateTo(String routeName, {Object? arguments}) {
    navigatorKey.currentState!.pop();

    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateToAndReplace(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateToAndReplaceUntil(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => routeName == route.settings.name,
    );
  }

  void goBack([Object? data]) {
    return navigatorKey.currentState!.pop(data);
  }
}
