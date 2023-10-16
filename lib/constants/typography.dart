import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:flutter/widgets.dart';

class EBFontWeight {
  EBFontWeight._();

  static const FontWeight thin = FontWeight.w300;
  static const FontWeight regular = FontWeight.w500;
  static const FontWeight bold = FontWeight.w600;
  static const FontWeight semiBold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}

class EBFontSize {
  EBFontSize._();

  static const double h1 = 32.0;
  static const double h2 = 24.0;
  static const double h3 = 20.0;
  static const double h4 = 18.0;
  static const double normal = 15.0;
  static const double label = 14.0;
  static const double small = 13.0;
}

class EBTypography {
  EBTypography._();

  static const String fontFamily = 'Outfit';

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
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? EBColor.dark.withOpacity(muted ? 0.5 : 1),
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: (cutOverflow ?? false) ? TextOverflow.ellipsis : null,
    );
  }

  // Typography headings and default text with default color dark
  static Widget h1({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, EBFontSize.h1, color, muted, fontWeight ?? EBFontWeight.extraBold, textAlign, maxLines, cutOverflow);
  static Widget h2({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, EBFontSize.h2, color, muted, fontWeight ?? EBFontWeight.extraBold, textAlign, maxLines, cutOverflow);
  static Widget h3({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, EBFontSize.h3, color, muted, fontWeight ?? EBFontWeight.extraBold, textAlign, maxLines, cutOverflow);
  static Widget h4({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, EBFontSize.h4, color, muted, fontWeight ?? EBFontWeight.extraBold, textAlign, maxLines, cutOverflow);
  static Widget text({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, EBFontSize.normal, color, muted, fontWeight ?? EBFontWeight.regular, textAlign, maxLines, cutOverflow);
  static Widget label({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, EBFontSize.label, color, muted, fontWeight ?? EBFontWeight.semiBold, textAlign, maxLines, cutOverflow);
  static Widget small({required String text, Color? color, FontWeight? fontWeight, bool muted = false, TextAlign? textAlign, int? maxLines, bool? cutOverflow}) => _textStyle(text, EBFontSize.small, color, muted, fontWeight ?? EBFontWeight.regular, textAlign, maxLines, cutOverflow);
}
