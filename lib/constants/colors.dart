import 'package:flutter/material.dart';

class EBColor {
  EBColor._();

  static const Color primary = Color(0xFF2E3192);
  static const Color warning = Color(0xFFFF9314);
  static const Color danger = Color(0xFFF64040);
  static const Color light = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF000000);

  static MaterialColor materialPrimary = const MaterialColor(
    0xFF2E3192,
    <int, Color>{
      50: Color(0xFFF2F3FC), // Shade 50
      100: Color(0xFFD5D7F8), // Shade 100
      200: Color(0xFFB8BAF5), // Shade 200
      300: Color(0xFF9A9DF2), // Shade 300
      400: Color(0xFF7D7FF0), // Shade 400
      500: Color(0xFF2E3192), // Shade 500
      600: Color(0xFF292E8C), // Shade 600
      700: Color(0xFF232789), // Shade 700
      800: Color(0xFF1D2276), // Shade 800
      900: Color(0xFF171D63), // Shade 900
    },
  );
}
