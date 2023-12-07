import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';

Widget buildLoadingIndicator() {
  return SizedBox(
    height: 300,
    child: Center(
      child: CircularProgressIndicator(
        color: EBColor.primary,
        strokeCap: StrokeCap.round,
      ),
    ),
  );
}

Widget buildNoComments() {
  return SizedBox(
    height: 50,
    child: Center(
      child: EBTypography.text(text: 'No comments available yet.', muted: true),
    ),
  );
}
