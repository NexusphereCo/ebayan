import 'dart:math';

import 'package:flutter/material.dart';

class Spacing {
  Spacing._();

  // Extra Small
  static const double xs = 3.0;
  // Small
  static const double sm = 5.0;
  // Medium
  static const double md = 15.0;
  // Large
  static const double lg = 30.0;
  // Extra Large
  static const double xl = 45.0;
  // Double Extra Large
  static const double xxl = 60.0;
  // Triple Extra Large
  static const double xxxl = 100.0;
}

class Global {
  Global._();

  static const double paddingBody = 20.0;
}

class EBBorderRadius {
  EBBorderRadius._();

  // Extra Small
  static const double xs = 3.0;
  // Small (default, forms)
  static const double sm = 6.0;
  // Medium
  static const double md = 12.0;
  // Large
  static const double lg = 20.0;
  // Extra Large
  static const double xl = 45.0;
  // Double Extra Large
  static const double xxl = 60.0;
  // Triple Extra Large
  static const double xxxl = 100.0;
}

// ignore: non_constant_identifier_names
Widget RotateWidget({required int degree, required Widget child}) {
  return Transform.rotate(angle: degree * pi / 180, child: child);
}
