import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/size.dart';
import 'package:flutter/material.dart';

Widget buildHeading({required int numOfPeople}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EBTypography.h1(text: 'People'),
        const SizedBox(height: Spacing.sm),
        EBTypography.text(text: '$numOfPeople people are connected in this barangay sphere'),
      ],
    );
