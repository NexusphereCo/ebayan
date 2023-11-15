import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';

Widget buildHeading() => Column(
      children: [
        EBTypography.h1(
          text: 'Welcome Back!',
          color: EBColor.primary,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        EBTypography.text(
          text: 'Sign in to continue.',
          muted: true,
        ),
      ],
    );
