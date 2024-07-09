
import 'package:common/utils/color_utils.dart';
import 'package:flutter/material.dart';

class MotofyTheme {

  static ThemeData theme() {
    M3Colors.surfaceContainerConfig = const Color(0xFF2B2930);

    return ThemeData(
      scaffoldBackgroundColor: _colors.surface,
      colorScheme: _colors,
      textTheme: _textTheme,
      useMaterial3: true,
    );
  }

  static final ColorScheme _colors = ColorScheme.fromSeed(
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

  static const TextTheme _textTheme = TextTheme(
      headlineSmall: MotorfyTextStyles.headlineSmallStyle,
      labelLarge: MotorfyTextStyles.labelLargeStyle,
      bodySmall: MotorfyTextStyles.bodySmallStyle,
      bodyMedium: MotorfyTextStyles.bodyMediumStyle,
      bodyLarge: MotorfyTextStyles.bodyLargeStyle,
      displaySmall: MotorfyTextStyles.displaySmallStyle,
    );

}

class MotorfyTextStyles {

  static const largeHeaderTitleStyle = TextStyle(
    fontSize: 63,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static const labelLargeStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w600,
    letterSpacing: 0.10,
  );

  static const headlineSmallStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Mona Sans Expanded',
    fontWeight: FontWeight.w600,
  );

  static const bodySmallStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w400,
  );

  static const bodyMediumStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const displaySmallStyle = TextStyle(
    color: Colors.white,
    fontSize: 36,
    fontFamily: 'Mona Sans Expanded',
    fontWeight: FontWeight.w700,
  );

  static const bodyLargeStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.50,
  );

  static const plateNumberStyle = TextStyle(
    fontSize: 85,
    fontFamily: 'License Plate',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.35,
  );

  static const defaultTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );

  static const defaultBoldTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static const textFieldFloatingLabelStyle = TextStyle();

  static const textFieldLabelStyle = TextStyle(
    fontSize: 12.0,
  );

  static const textFieldStyle = TextStyle(
    fontSize: 12.0,
  );

  static const confirmationScreenTitleStyle = TextStyle(
    fontSize: 12.0,
  );

  static const primaryButtonTitleTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w600,
    letterSpacing: 0.10,
  );

  static const secondaryButtonTitleTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w600,
    letterSpacing: 0.10,
  );

  static const pageTitleTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Mona Sans Expanded',
    fontWeight: FontWeight.w600,
  );

  static const inputLabelTextStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w400,
  );

  static const inputFieldTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.50,
  );

  static const smallTextLabelStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w400,
  );

  static const appBarTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'Mona Sans',
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

}