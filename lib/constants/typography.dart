import 'package:ebayan/constants/colors.dart';
import 'package:flutter/widgets.dart';

class EBTypography {
  static Widget _textStyle(String str, double fontSize, Color color, {FontWeight fontWeight = FontWeight.w800}) {
    return Text(
      str,
      style: TextStyle(
        fontFamily: 'Outfit',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  // Typography headings and default text with default color dark
  static Widget h1({String text = 'Text...', Color color = EBColor.dark}) => _textStyle(text, 32.0, color);
  static Widget h2({String text = 'Text...', Color color = EBColor.dark}) => _textStyle(text, 24.0, color);
  static Widget h3({String text = 'Text...', Color color = EBColor.dark}) => _textStyle(text, 20.0, color);
  static Widget h4({String text = 'Text...', Color color = EBColor.dark}) => _textStyle(text, 18.0, color);
  static Widget p({String text = 'Text...', Color color = EBColor.dark}) => _textStyle(text, 15.0, color, fontWeight: FontWeight.normal);
  static Widget b({String text = 'Text...', Color color = EBColor.dark}) => _textStyle(text, 15.0, color, fontWeight: FontWeight.w600);
  static Widget small({String text = 'Text...', Color color = EBColor.dark}) => _textStyle(text, 13.0, color, fontWeight: FontWeight.normal);
}
