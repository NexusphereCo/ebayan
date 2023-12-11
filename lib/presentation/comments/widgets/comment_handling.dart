import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';

Widget buildNoComments() {
  return SizedBox(
    height: 50,
    child: Center(
      child: EBTypography.text(text: 'No comments available yet.', muted: true),
    ),
  );
}
