import 'package:flutter/material.dart';

import 'package:subterranean_descent/game/game.dart';
import 'package:subterranean_descent/main_menu.dart';
import 'package:subterranean_descent/splash_screen_widget.dart';

enum RouteKey { initial, mainMenu, game }

const initialPath = '/';

final _routeMap = {
  RouteKey.initial: initialPath,
  RouteKey.mainMenu: '/main-menu',
  RouteKey.game: '/game',
};

extension RouteKeyExtension on RouteKey {
  String get path => _routeMap[this] ?? initialPath;
}

final routes = {
  RouteKey.initial.path: (context) => SplashScreenWidget(),
  RouteKey.mainMenu.path: (context) => MainMenuWidget(),
  RouteKey.game.path: (context) => MyGameWidget(),
};

mixin Navigation {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(RouteKey routeKey) =>
      navigatorKey.currentState!.pushNamed(routeKey.path);

  static Future<dynamic> nonReturningNavigateTo(RouteKey routeKey) =>
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeKey.path,
        (Route<dynamic> route) => false,
      );
}
