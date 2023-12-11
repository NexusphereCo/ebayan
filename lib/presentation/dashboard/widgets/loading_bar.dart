import 'package:flutter/material.dart';

/// A Loading Bar
/// ```dart
/// EBLoadingBar() => returns a default width of 100% with height 15 and a color gradient of: [Colors.green[200]!, Colors.green[100]!]
/// EBLoadingBar(width: 100, height: 20, colors: [...]) => customized params
/// ```
class EBLoadingBar extends StatelessWidget {
  final double? width;
  final double? height;
  final List<Color>? colors;

  const EBLoadingBar({
    this.width,
    this.height,
    this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 15.0,
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 5),
        tween: Tween<double>(begin: -1, end: 1),
        curve: Curves.easeInOut,
        builder: (BuildContext context, double value, Widget? child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                begin: Alignment(-1 + value, 0),
                end: Alignment(1 + value, 0),
                colors: colors ?? [Colors.green[200]!, Colors.green[100]!],
              ),
            ),
          );
        },
      ),
    );
  }
}
