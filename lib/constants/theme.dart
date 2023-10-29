import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';

class EBTheme {
  EBTheme._();

  static const baseTextStyle = TextStyle(fontFamily: 'Outfit');

  static TextTheme buildTextTheme() {
    return const TextTheme(
      bodyLarge: baseTextStyle,
      bodyMedium: baseTextStyle,
      bodySmall: baseTextStyle,
      displayLarge: baseTextStyle,
      displayMedium: baseTextStyle,
      displaySmall: baseTextStyle,
      headlineLarge: baseTextStyle,
      headlineMedium: baseTextStyle,
      headlineSmall: baseTextStyle,
      labelLarge: baseTextStyle,
      labelMedium: baseTextStyle,
      labelSmall: baseTextStyle,
      titleLarge: baseTextStyle,
      titleMedium: baseTextStyle,
      titleSmall: baseTextStyle,
    );
  }

  static ThemeData data() {
    return ThemeData(
      primarySwatch: EBColor.primary,
      textTheme: buildTextTheme(),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: TextStyle(
          fontFamily: EBTypography.fontFamily,
          fontSize: EBFontSize.label,
          fontWeight: EBFontWeight.regular,
          color: EBColor.primary,
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: EBColor.primary, width: 1.0),
        ),
      ),
    );
  }
}
