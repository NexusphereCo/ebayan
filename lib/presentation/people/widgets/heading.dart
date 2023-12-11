import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/presentation/dashboard/widgets/loading_bar.dart';

import 'package:flutter/material.dart';

Widget buildHeading({required int numOfPeople}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      EBTypography.h1(text: 'People'),
      const SizedBox(height: Spacing.sm),
      EBTypography.text(text: '$numOfPeople people are connected in this barangay sphere'),
      const SizedBox(height: Spacing.md),
    ],
  );
}

Widget buildLoadingHeading() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      EBLoadingBar(width: 200, height: 30, colors: [EBColor.primary[100]!, EBColor.primary[50]!.withOpacity(0.5)]),
      const SizedBox(height: Spacing.sm),
      EBLoadingBar(width: double.infinity, colors: [EBColor.primary[100]!, EBColor.primary[50]!.withOpacity(0.5)]),
      const SizedBox(height: Spacing.md),
    ],
  );
}
