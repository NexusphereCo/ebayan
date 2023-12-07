import 'dart:math';
import 'package:flutter/widgets.dart';

class RotateWidget extends StatelessWidget {
  final int degree;
  final Widget child;

  const RotateWidget({
    super.key,
    required this.degree,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: degree * pi / 180,
      child: child,
    );
  }
}
