import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class EBFontWeight {
  EBFontWeight._();

  static const FontWeight thin = FontWeight.w300;
  static const FontWeight regular = FontWeight.w500;
  static const FontWeight bold = FontWeight.w600;
  static const FontWeight semiBold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}

class EBTypography {
  EBTypography._();

  static Widget _textStyle(
    String str,
    double fontSize,
    Color? color,
    bool muted,
    FontWeight fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    bool? cutOverflow,
  ) {
    return AutoSizeText(
      str,
      style: GoogleFonts.outfit(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? EBColor.dark.withOpacity(muted ? 0.5 : 1),
        ),
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: (cutOverflow ?? false) ? TextOverflow.ellipsis : null,
    );
  }

  // Typography headings and default text with default color dark
  static Widget h1({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, 32.0, color, muted, fontWeight ?? EBFontWeight.extraBold, textAlign, maxLines, cutOverflow);
  static Widget h2({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, 24.0, color, muted, fontWeight ?? EBFontWeight.extraBold, textAlign, maxLines, cutOverflow);
  static Widget h3({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, 20.0, color, muted, fontWeight ?? EBFontWeight.extraBold, textAlign, maxLines, cutOverflow);
  static Widget h4({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, 18.0, color, muted, fontWeight ?? EBFontWeight.extraBold, textAlign, maxLines, cutOverflow);
  static Widget text({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, 15.0, color, muted, fontWeight ?? EBFontWeight.regular, textAlign, maxLines, cutOverflow);
  static Widget label({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, 14.0, color, muted, fontWeight ?? EBFontWeight.semiBold, textAlign, maxLines, cutOverflow);
  static Widget small({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, 13.0, color, muted, fontWeight ?? EBFontWeight.regular, textAlign, maxLines, cutOverflow);
}
