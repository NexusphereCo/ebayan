import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

SnackBar snackBar({required String text}) {
  return SnackBar(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    content: Row(
      children: [
        Icon(FeatherIcons.info, color: EBColor.light),
        const SizedBox(width: Spacing.md),
        Text(
          text,
          style: const TextStyle(fontFamily: EBTypography.fontFamily),
        ),
      ],
    ),
    backgroundColor: EBColor.primary,
    duration: const Duration(seconds: 5),
  );
}
