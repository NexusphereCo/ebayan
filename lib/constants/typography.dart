import 'package:ebayan/constants/colors.dart';
import 'package:flutter/widgets.dart';

class EBTypography {
  static Widget _textStyle(String str, double fontSize, Color? color, bool muted, FontWeight fontWeight) {
    return Text(
      str,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? EBColor.dark.withOpacity(muted ? 0.5 : 1),
      ),
    );
  }

  // Typography headings and default text with default color dark
  static Widget h1({required String text, Color? color, bool muted = false}) => _textStyle(text, 32.0, color, muted, FontWeight.w700);
  static Widget h2({required String text, Color? color, bool muted = false}) => _textStyle(text, 24.0, color, muted, FontWeight.w700);
  static Widget h3({required String text, Color? color, bool muted = false}) => _textStyle(text, 20.0, color, muted, FontWeight.w700);
  static Widget h4({required String text, Color? color, bool muted = false}) => _textStyle(text, 18.0, color, muted, FontWeight.w700);
  static Widget p({required String text, Color? color, bool muted = false}) => _textStyle(text, 15.0, color, muted, FontWeight.w400);
  static Widget b({required String text, Color? color, bool muted = false}) => _textStyle(text, 15.0, color, muted, FontWeight.w600);
  static Widget label({required String text, Color? color, bool muted = false}) => _textStyle(text, 15.0, color, muted, FontWeight.w700);
  static Widget small({required String text, Color? color, bool muted = false}) => _textStyle(text, 13.0, color, muted, FontWeight.w400);
}
