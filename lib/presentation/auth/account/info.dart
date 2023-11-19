import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: SvgPicture.asset(
              Asset.illustAccInfoBackg,
              fit: BoxFit.fill, // or BoxFit.cover based on your requirement
            ),
          ),
          Column(
            children: [
              const SizedBox(height: Spacing.md),
              EBTypography.h1(text: 'Account Information'),
              const SizedBox(height: Spacing.xxl),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(Global.paddingBody),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: EBColor.light,
                          border: Border.all(color: EBColor.green),
                          borderRadius: BorderRadius.circular(EBBorderRadius.lg),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(FeatherIcons.user, size: EBFontSize.h2),
                                      const SizedBox(width: Spacing.sm),
                                      EBTypography.h4(text: 'Personal Information'),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        EBTypography.label(text: 'Edit', color: EBColor.green),
                                        const SizedBox(width: Spacing.sm),
                                        Icon(FeatherIcons.edit, color: EBColor.green, size: EBFontSize.h4),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  EBTypography.text(text: 'First Name:', muted: true),
                                  const SizedBox(width: Spacing.sm),
                                  EBTypography.text(text: 'John Doe', muted: true),
                                ],
                              ),
                              Row(
                                children: [
                                  EBTypography.text(text: 'Last Name:', muted: true),
                                  const SizedBox(width: Spacing.sm),
                                  EBTypography.text(text: 'Smith', muted: true),
                                ],
                              ),
                              const SizedBox(height: Spacing.md),
                              Row(
                                children: [
                                  const Icon(FeatherIcons.phone, size: EBFontSize.h2),
                                  const SizedBox(width: Spacing.sm),
                                  EBTypography.h4(text: 'Contact Information'),
                                ],
                              ),
                              const SizedBox(height: Spacing.md),
                              Row(
                                children: [
                                  EBTypography.text(text: 'Phone No.:', muted: true),
                                  const SizedBox(width: Spacing.sm),
                                  EBTypography.text(text: '0966 322 5541', muted: true),
                                ],
                              ),
                              Row(
                                children: [
                                  EBTypography.text(text: 'Email Address:', muted: true),
                                  const SizedBox(width: Spacing.sm),
                                  EBTypography.text(text: 'jsmith@gmail.com', muted: true),
                                ],
                              ),
                              const SizedBox(height: Spacing.md),
                              Row(
                                children: [
                                  const Icon(FeatherIcons.mapPin, size: EBFontSize.h2),
                                  const SizedBox(width: Spacing.sm),
                                  EBTypography.h4(text: 'Address'),
                                ],
                              ),
                              const SizedBox(height: Spacing.md),
                              EBTypography.text(
                                text: 'Cokeville Homes, Subdivision Marines Village, San Felipe, N.C. 4400, Camarines Sur',
                                muted: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.lg),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(EBBorderRadius.md),
                            color: EBColor.green,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(FeatherIcons.lock, color: EBColor.light),
                                  const SizedBox(width: Spacing.sm),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      EBTypography.h4(
                                        text: 'Change Password',
                                        color: EBColor.light,
                                      ),
                                      EBTypography.small(
                                        text: 'Manage your login credentials',
                                        color: EBColor.light,
                                        fontWeight: EBFontWeight.thin,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Icon(FeatherIcons.arrowRight, color: EBColor.light),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.sm),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(EBBorderRadius.md),
                            color: EBColor.green,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(FeatherIcons.lock, color: EBColor.light),
                                  const SizedBox(width: Spacing.sm),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      EBTypography.h4(
                                        text: 'Logout',
                                        color: EBColor.light,
                                      ),
                                      EBTypography.small(
                                        text: 'Sign-out and come back for news later!',
                                        color: EBColor.light,
                                        fontWeight: EBFontWeight.thin,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Icon(FeatherIcons.arrowRight, color: EBColor.light),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 4),
    );
  }
}
