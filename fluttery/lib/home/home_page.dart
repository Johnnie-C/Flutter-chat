import 'package:common/utils/color_utils.dart';
import 'package:common/utils/text_theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttery/features/feature_list_page.dart';
import 'package:fluttery/widget_demos/widget_demo_list_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.colorScheme.primary,
      body: _buildTabPage(context),
      bottomNavigationBar: _buildBottomTabBar(context),
    );
  }

  Widget _buildBottomTabBar(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) => states.contains(MaterialState.selected)
              ? context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.primary,
                )
              : context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.secondary
                ),
        ),
      ),
      child: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.hive_outlined,
              color: context.colorScheme.secondary,
              size: 24,
            ),
            selectedIcon:  Icon(
              Icons.hive_rounded,
              color: context.colorScheme.primary,
              size: 24,
            ),
            label: "features",
          ),
          NavigationDestination(
            icon:  Icon(
              Icons.now_widgets_outlined,
              color: context.colorScheme.secondary,
              size: 24,
            ),
            selectedIcon: Icon(
              Icons.now_widgets_rounded,
              color: context.colorScheme.primary,
              size: 24,
            ),
            label: "Widget Demos",
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        indicatorColor: Colors.transparent,
        backgroundColor: context.colorScheme.surfaceContainer,
        surfaceTintColor: context.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildTabPage(BuildContext context) {
    return switch (currentPageIndex) {
      0 => const FeatureListPage(),
      1 => const WidgetDemoListPage(),
      _ => throw Exception("Invalid tab index"),
    };
  }

}
