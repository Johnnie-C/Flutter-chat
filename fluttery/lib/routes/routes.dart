import 'package:flutter/material.dart';
import 'package:fluttery/features/chatting/chat_demo_page.dart';
import 'package:fluttery/features/feature_list_page.dart';
import 'package:fluttery/home/home_page.dart';

class Routes {
  static const home = "Home";
  static const featureList = "FeatureList";
  static const chatting = "Chatting";
}

class RouteManager {
  static Route<Object> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
          fullscreenDialog: true,
        );
      case Routes.chatting:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ChatDemoPage(),
          fullscreenDialog: false,
        );
      case Routes.featureList:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const FeatureListPage(),
          fullscreenDialog: true,
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
