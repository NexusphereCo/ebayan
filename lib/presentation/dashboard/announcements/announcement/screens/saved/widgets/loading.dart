import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/size.dart';
import 'package:flutter/material.dart';

Widget buildLoadingIndicator(BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: EBColor.primary,
              strokeCap: StrokeCap.round,
            ),
          ),
          const SizedBox(height: Spacing.md),
          EBTypography.text(
            text: 'Loading...',
            color: EBColor.primary,
          ),
        ],
      ),
    );
