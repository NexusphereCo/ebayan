import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

Widget commentHeading() => Column(
      children: [
        const SizedBox(height: Spacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EBTypography.h4(text: 'Comments'),
            Row(
              children: [
                Icon(
                  FeatherIcons.feather,
                  size: EBFontSize.normal,
                  color: EBColor.green,
                ),
                const SizedBox(width: 3),
                EBTypography.text(
                  text: 'Post a comment',
                  color: EBColor.green,
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: Spacing.md),
      ],
    );
