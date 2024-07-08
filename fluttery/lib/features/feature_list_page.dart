import 'package:common/utils/color_utils.dart';
import 'package:common/widgets/custom_app_bar.dart';
import 'package:common/style_guide/spacing.dart';
import 'package:flutter/material.dart';
import 'package:fluttery/routes/routes.dart';

class FeatureListPage extends StatefulWidget {
  const FeatureListPage({super.key});
  @override
  State<FeatureListPage> createState() => _FeatureListState();
}

class _FeatureListState extends State<FeatureListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Features"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: ListView(
            children: [
              Spacing.small,
              Card.filled(
                color: context.colorScheme.surfaceContainer,
                child: ListTile(
                  title: const Text("Chat Demo"),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.chatting);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
