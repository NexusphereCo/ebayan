import 'package:flutter/material.dart';

/// defines the application colors.
///
/// each variable returns a [String]
/// sample invocation: EBColor.primary, EBColor.primary[200], ...
class EBColor {
  EBColor._();

  static MaterialColor primary = const MaterialColor(
    // default = shade[500]
    0xFF3336AB,
    <int, Color>{
      50: Color(0xFFF2F3FC),
      100: Color(0xFFD5D7F8),
      200: Color(0xFFB8BAF5),
      300: Color(0xFF9A9DF2),
      400: Color(0xFF7D7FF0),
      500: Color(0xFF3336AB),
      600: Color(0xFF292E8C),
      700: Color(0xFF232789),
      800: Color(0xFF1D2276),
      900: Color(0xFF171D63),
    },
  );

  static MaterialColor light = const MaterialColor(
    // default = shade[50]
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFA0A5D1),
      200: Color(0xFF7E84C1),
      300: Color(0xFF7E84C1),
    },
  );

  static MaterialColor dark = const MaterialColor(
    // default = shade[900]
    0xFF050A35,
    <int, Color>{
      50: Color(0xFFD1D4EA),
      100: Color(0xFFA0A5D1),
      200: Color(0xFF7E84C1),
      300: Color(0xFF5960A5),
      400: Color(0xFF3B417D),
      500: Color(0xFF303671),
      600: Color(0xFF232960),
      700: Color(0xFF181E58),
      800: Color(0xFF121746),
      900: Color(0xFF050A35),
    },
  );

  static MaterialColor dullGreen = const MaterialColor(
    // default = shade[600]
    0xFF447282,
    <int, Color>{
      50: Color(0xFFA3D2CB),
      100: Color(0xFF8AC9BF),
      200: Color(0xFF74C0BC),
      300: Color(0xFF74ACC0),
      400: Color(0xFF719BA9),
      500: Color(0xFF5A828F),
      600: Color(0xFF447282),
    },
  );

  static MaterialColor green = const MaterialColor(
    // default = shade[400]
    0xFF3E8F72,
    <int, Color>{
      50: Color(0xFFC3EBDF),
      100: Color(0xFF9FE2CE),
      200: Color(0xFF6ADFB5),
      300: Color(0xFF4CBF96),
      400: Color(0xFF3E8F72),
    },
  );

  static MaterialColor red = const MaterialColor(
    // default = shade[400]
    0xFFF64040,
    <int, Color>{
      50: Color(0xFFFFD7D7),
      100: Color(0xFFFFB9B9),
      200: Color(0xFFF99696),
      300: Color(0xFFF57070),
      400: Color(0xFFF64040),
    },
  );

  static MaterialColor yellow = const MaterialColor(
    // default = shade[400]
    0xFFFF9314,
    <int, Color>{
      50: Color(0xFFFFE2C0),
      100: Color(0xFFFFD29D),
      200: Color(0xFFFFBE73),
      300: Color(0xFFFFAE4F),
      400: Color(0xFFFF9314),
    },
  );
}
