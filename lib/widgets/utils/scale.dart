import 'package:flutter/material.dart';

class Scale extends StatelessWidget {
  final double scaleFactor;
  final Widget child;

  const Scale({super.key, required this.scaleFactor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scaleFactor,
      child: child,
    );
  }
}
