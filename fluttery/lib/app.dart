import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttery/routes/routes.dart';
import 'package:fluttery/themes/motorfy_themes.dart';

class App extends StatefulWidget {
  const App({super.key, this.navigatorKey});

  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  State<App> createState() => _AppState();
}


class _AppState extends State<App> {
  late final List<Locale> supportedLocales;

  @override
  void initState() {
    super.initState();

    // Convert en-NZ to en-AU, for some reason Flutter shows MM/dd/yyyy for
    // en-NZ as opposed to dd/MM/yyyy, this is likely Flutter's intl library
    // doesn't have a locale for en-NZ and falls back to en-US:
    // https://andreygordeev.com/flutter-dateformat-cheat-sheet/
    final locales = PlatformDispatcher.instance.locales;
    supportedLocales = locales
        .map((locale) =>
    locale.countryCode == 'NZ' ? const Locale('en', 'AU') : locale)
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: MaterialApp(
      navigatorKey: widget.navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: supportedLocales,
      debugShowCheckedModeBanner: true,
      theme: MotofyTheme.theme(),
      initialRoute: Routes.home,
      onGenerateRoute: RouteManager.generateRoutes,
      navigatorObservers: const [],
    ),
  );
}
