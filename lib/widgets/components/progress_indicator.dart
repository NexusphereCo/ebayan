import 'package:ebayan/constants/colors.dart';

import 'package:flutter/material.dart';

class EBProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int length;

  const EBProgressIndicator({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5,
      children: List.generate(
        length,
        (index) => Container(
          height: 10,
          width: 75,
          decoration: BoxDecoration(
            color: (index + 1 == currentIndex) ? EBColor.primary[500] : EBColor.primary[200],
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
      ),
    );
  }
}
