import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class EBSnackBar {
  EBSnackBar._();

  static SnackBar info({required String text}) {
    return SnackBar(
      duration: const Duration(seconds: 5),
      content: Row(
        children: [
          Icon(FeatherIcons.info, color: EBColor.light),
          const SizedBox(width: Spacing.md),
          Flexible(
            child: EBTypography.text(text: text, color: EBColor.light),
          ),
        ],
      ),
    );
  }

  static SnackBar lostConnection() {
    return SnackBar(
      duration: const Duration(seconds: 5),
      content: Row(
        children: [
          Icon(FeatherIcons.wifiOff, color: EBColor.light),
          const SizedBox(width: Spacing.md),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EBTypography.h4(text: 'Lost Connection!', color: EBColor.light, textAlign: TextAlign.start),
                const SizedBox(height: Spacing.xs),
                EBTypography.text(text: 'You are not connected to a network.', color: EBColor.light, textAlign: TextAlign.start),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
