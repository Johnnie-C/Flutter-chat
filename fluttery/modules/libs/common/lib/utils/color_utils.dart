
import 'package:flutter/material.dart';

extension ColorUtils on BuildContext {

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

}

extension M3Colors on ColorScheme {

  static Color surfaceContainerConfig = const Color(0xFF2B2930);
  Color get surfaceContainer => surfaceContainerConfig;

}