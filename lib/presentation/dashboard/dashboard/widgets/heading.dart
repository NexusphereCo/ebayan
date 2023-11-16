import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget buildHeading() => Wrap(
      alignment: WrapAlignment.center,
      children: [
        EBTypography.h1(text: 'Welcome Back, '),
        EBTypography.h1(
          text: FirebaseAuth.instance.currentUser?.displayName ?? 'User',
          color: EBColor.green,
        ),
      ],
    );
