import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EBTheme {
  EBTheme._();

  static ThemeData data() {
    return ThemeData(
      primarySwatch: EBColor.materialPrimary,
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: EBColor.dark,
      ),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: GoogleFonts.outfit(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: EBFontWeight.regular,
            color: EBColor.primary,
          ),
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: EBColor.primary, width: 1.0),
        ),
      ),
    );
  }
}
