import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildEmptyDashboard() => Padding(
      padding: const EdgeInsets.all(Global.paddingBody),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: Spacing.md),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  EBTypography.h1(text: 'Welcome Back, '),
                  EBTypography.h1(text: 'User', color: EBColor.green),
                  EBTypography.h1(text: '!', color: EBColor.green),
                ],
              ),
              const SizedBox(height: Spacing.lg),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(Asset.houseEmpty),
                    const SizedBox(height: Spacing.lg),
                    EBTypography.text(
                      text: "You currently aren't joined to any barangay spheres. Let's change that!",
                      muted: true,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.lg),
                SizedBox(
                  width: double.infinity,
                  child: EBButton(
                    onPressed: () {},
                    text: 'Get Started!',
                    theme: EBButtonTheme.primary,
                  ),
                ),
                const SizedBox(height: Spacing.lg),
                const SizedBox(height: Spacing.lg),
              ],
            ),
          ),
        ],
      ),
    );
