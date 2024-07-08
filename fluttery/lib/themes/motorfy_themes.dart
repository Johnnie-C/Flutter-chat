
import 'package:common/utils/color_utils.dart';
import 'package:flutter/material.dart';

extension MotofyTheme on ThemeData {

  static ThemeData theme() {
    M3Colors.surfaceContainerConfig = const Color(0xFF2B2930);

    return ThemeData(
      scaffoldBackgroundColor: MotorfyColors.colors.surface,
      colorScheme: MotorfyColors.colors,
      useMaterial3: true,
    );
  }

}

class MotorfyColors {

  static ColorScheme colors = ColorScheme.fromSeed(
    primary: const Color(0XFFD0BCFF),
    onPrimary: const Color(0XFF381E72),
    primaryContainer: const Color(0XFF4F378B),
    onPrimaryContainer: const Color(0XFFEADDFF),
    surface: const Color(0XFF141218),
    onSurface: const Color(0XFFE6E0E9),
    onSurfaceVariant: const Color(0XFFCAC4D0),
    secondary: const Color(0XFFCCC2DC),
    onSecondary: const Color(0XFF332D41),
    secondaryContainer: const Color(0XFF4A4458),
    onSecondaryContainer: const Color(0XFFE8DEF8),
    tertiary: const Color(0XFFEFB8C8),
    onTertiary: const Color(0XFF492532),
    tertiaryContainer: const Color(0XFF633B48),
    onTertiaryContainer: const Color(0XFFFFD8E4),
    error: const Color(0XFFF2B8B5),
    onError: const Color(0XFF601410),
    errorContainer: const Color(0XFF8C1D18),
    onErrorContainer: const Color(0XFFF9DEDC),
    outline: const Color(0XFF938F99),
    seedColor: const Color(0XFF6750A4),
    outlineVariant: const Color(0XFF49454F),
    brightness: Brightness.light,
  );

}