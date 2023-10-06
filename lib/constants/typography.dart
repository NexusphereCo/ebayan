import 'package:ebayan/constants/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class EBTypography {
  EBTypography._();

  static const FontWeight _thin = FontWeight.w300;
  static const FontWeight _regular = FontWeight.w500;
  static const FontWeight _bold = FontWeight.w600;
  static const FontWeight _semiBold = FontWeight.w700;
  static const FontWeight _extraBold = FontWeight.w800;

  static Widget _textStyle(String str, double fontSize, Color? color,
      bool muted, FontWeight fontWeight, TextAlign? textAlign) {
    return Text(str,
        style: GoogleFonts.outfit(
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? EBColor.dark.withOpacity(muted ? 0.5 : 1),
          ),
        ),
        textAlign: textAlign);
  }

  // Typography headings and default text with default color dark
  static Widget h1(
          {required String text,
          Color? color,
          bool muted = false,
          TextAlign? textAlign}) =>
      _textStyle(text, 32.0, color, muted, _extraBold, textAlign);
  static Widget h2(
          {required String text,
          Color? color,
          bool muted = false,
          TextAlign? textAlign}) =>
      _textStyle(text, 24.0, color, muted, _extraBold, textAlign);
  static Widget h3(
          {required String text,
          Color? color,
          bool muted = false,
          TextAlign? textAlign}) =>
      _textStyle(text, 20.0, color, muted, _extraBold, textAlign);
  static Widget h4(
          {required String text,
          Color? color,
          bool muted = false,
          TextAlign? textAlign}) =>
      _textStyle(text, 18.0, color, muted, _extraBold, textAlign);
  static Widget p(
          {required String text,
          Color? color,
          bool muted = false,
          TextAlign? textAlign}) =>
      _textStyle(text, 15.0, color, muted, _regular, textAlign);
  static Widget b(
          {required String text,
          Color? color,
          bool muted = false,
          TextAlign? textAlign}) =>
      _textStyle(text, 15.0, color, muted, _bold, textAlign);
  static Widget label(
          {required String text,
          Color? color,
          bool muted = false,
          TextAlign? textAlign}) =>
      _textStyle(text, 15.0, color, muted, _semiBold, textAlign);
  static Widget small(
          {required String text,
          Color? color,
          bool muted = false,
          TextAlign? textAlign}) =>
      _textStyle(text, 13.0, color, muted, _regular, textAlign);
}
