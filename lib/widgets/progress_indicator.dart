import 'package:ebayan/constants/colors.dart';
import 'package:flutter/material.dart';

class EBProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int length;

  const EBProgressIndicator({
    Key? key,
    required this.currentIndex,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5,
      children: [
        for (int i = 1; i <= length; i++)
          Container(
            height: 10,
            width: 100,
            decoration: BoxDecoration(
              color: (i == currentIndex) ? EBColor.materialPrimary[500] : EBColor.materialPrimary[200],
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
      ],
    );
  }
}
