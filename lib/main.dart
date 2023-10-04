import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/screens/login.dart';
import 'package:ebayan/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const InitApp());
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme().apply(
          bodyColor: EBColor.dark,
        ),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false, // remove the effing debug banner on the top right
    );
  }
}
