import 'package:flutter/material.dart';
import 'package:fluttery/home/home_page.dart';

class Routes {
  static const home = "home";
}

class RouteManager {
  static Route<Object> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
          fullscreenDialog: true,
          maintainState: true,
        );
      default:
        final settingsName = settings.name;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Scaffold(
            body: Center(
              child: Text('No route defined for $settingsName'),
            ),
          ),
          fullscreenDialog: true,
          maintainState: false,
        );
    }
  }
}
