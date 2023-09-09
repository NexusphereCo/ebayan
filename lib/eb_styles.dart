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

  static Widget h1(str, {Color color = Colors.dark}) => _textStyle(str, 32.0, color);
  static Widget h2(str, {Color color = Colors.dark}) => _textStyle(str, 24.0, color);
  static Widget h3(str, {Color color = Colors.dark}) => _textStyle(str, 20.0, color);
  static Widget h4(str, {Color color = Colors.dark}) => _textStyle(str, 18.0, color);
  static Widget p(str, {Color color = Colors.dark}) => _textStyle(str, 15.0, color, fontWeight: FontWeight.normal);
  static Widget b(str, {Color color = Colors.dark}) => _textStyle(str, 15.0, color, fontWeight: FontWeight.w600);
  static Widget small(str, {Color color = Colors.dark}) => _textStyle(str, 13.0, color, fontWeight: FontWeight.normal);
}

class Button {
  static ElevatedButton primary(String label, void Function() onPressed) {
    const double paddingTB = 15.0;
    const double paddingRB = 32.0;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0), // Adjust the radius to control the button's roundness
        ),
        padding: const EdgeInsets.fromLTRB(paddingRB, paddingTB, paddingRB, paddingTB), // Adjust the horizontal padding
        elevation: 0,
        backgroundColor: Colors.primary,
      ),
      onPressed: onPressed,
      child: Typography.b(label, color: Colors.light),
    );
  }

  static ElevatedButton primaryOutlined(String label, void Function() onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0), // Adjust the radius to control the button's roundness
          side: const BorderSide(
            color: Colors.primary, // Set the border (stroke) color to the primary color
          ),
        ),
        backgroundColor: Colors.light,
        padding: const EdgeInsets.fromLTRB(32.0, 15.0, 32.0, 15.0), // Adjust the horizontal padding
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Typography.b(label, color: Colors.primary),
    );
  }
}
