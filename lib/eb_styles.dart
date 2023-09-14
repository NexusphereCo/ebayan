import 'package:flutter/material.dart';

class Colors {
  static const Color primary = Color.fromRGBO(46, 49, 146, 1);
  static const Color warning = Color.fromRGBO(255, 147, 20, 1);
  static const Color danger = Color.fromRGBO(246, 64, 64, 1);
  static const Color light = Color.fromRGBO(255, 255, 255, 1);
  static const Color dark = Color.fromRGBO(0, 0, 0, 1);
}

class Typography {
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
  static Widget h1(str, {Color color = Colors.dark}) => _textStyle(str, 32.0, color);
  static Widget h2(str, {Color color = Colors.dark}) => _textStyle(str, 24.0, color);
  static Widget h3(str, {Color color = Colors.dark}) => _textStyle(str, 20.0, color);
  static Widget h4(str, {Color color = Colors.dark}) => _textStyle(str, 18.0, color);
  static Widget p(str, {Color color = Colors.dark}) => _textStyle(str, 15.0, color, fontWeight: FontWeight.normal);
  static Widget b(str, {Color color = Colors.dark}) => _textStyle(str, 15.0, color, fontWeight: FontWeight.w600);
  static Widget small(str, {Color color = Colors.dark}) => _textStyle(str, 13.0, color, fontWeight: FontWeight.normal);
}

class Button {
  static double paddingTB = 15.0;
  static double paddingRB = 32.0;
  static double borderRadius = 50.0;

  static Widget _defBtnStyle(String label, Color color, void Function() onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.fromLTRB(paddingRB, paddingTB, paddingRB, paddingTB),
        elevation: 0,
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: Typography.b(label, color: Colors.light),
    );
  }

  static Widget _outlinedBtnStyle(String label, Color color, void Function() onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: color),
        ),
        backgroundColor: Colors.light,
        padding: EdgeInsets.fromLTRB(paddingRB, paddingTB, paddingRB, paddingTB),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Typography.b(label, color: color),
    );
  }

  // Normal buttons
  static Widget primary(String label, void Function() onPressed) => _defBtnStyle(label, Colors.primary, onPressed);
  static Widget warning(String label, void Function() onPressed) => _defBtnStyle(label, Colors.warning, onPressed);
  static Widget danger(String label, void Function() onPressed) => _defBtnStyle(label, Colors.danger, onPressed);
  static Widget dark(String label, void Function() onPressed) => _defBtnStyle(label, Colors.dark, onPressed);

  // Outlined buttons
  static Widget primaryOutlined(String label, void Function() onPressed) => _outlinedBtnStyle(label, Colors.primary, onPressed);
  static Widget darkOutlined(String label, void Function() onPressed) => _outlinedBtnStyle(label, Colors.dark, onPressed);
}
