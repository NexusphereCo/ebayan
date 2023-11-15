import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/utils/style.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

SnackBar snackBar({required String text}) {
  return SnackBar(
    duration: const Duration(seconds: 5),
    content: Row(
      children: [
        Icon(FeatherIcons.info, color: EBColor.light),
        const SizedBox(width: Spacing.md),
        Text(text),
      ],
    ),
  );
}
