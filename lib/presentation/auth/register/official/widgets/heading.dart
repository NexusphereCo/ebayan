import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/size.dart';
import 'package:flutter/material.dart';

SizedBox buildHeading() => SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          EBTypography.h1(
            text: 'Be part of a Barangay!',
            color: EBColor.primary,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              EBTypography.text(
                text: 'Register as a ',
                muted: true,
                textAlign: TextAlign.center,
              ),
              EBTypography.text(
                text: 'Barangay Official.',
                muted: true,
                textAlign: TextAlign.center,
                fontWeight: EBFontWeight.bold,
              ),
              EBTypography.text(
                text: ' Fill in your information to get started.',
                muted: true,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: Spacing.md),
        ],
      ),
    );
