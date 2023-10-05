import 'package:ebayan/constants/colors.dart';
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
    );
  }
}
