import 'package:flutter/material.dart';

Widget buildLoadingContainer({
  required double width,
  List<Color>? colors,
}) =>
    SizedBox(
      width: width,
      height: 15,
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
