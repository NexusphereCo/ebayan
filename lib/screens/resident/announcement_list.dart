import 'dart:math';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBTopAppBar(),
      drawer: const EBDrawer(),
      body: ListView(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      EBTypography.h1(text: 'Announcement'),
                      const SizedBox(width: Spacing.formSm),
                      Transform.rotate(
                        angle: -15 * pi / 180,
                        child: const FaIcon(
                          FontAwesomeIcons.bullhorn,
                          size: 30,
                          color: EBColor.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.formMd),
                  const SphereInfoCard(),
                  const SizedBox(height: Spacing.formMd),
                  const Divider(
                    color: EBColor.primary,
                    height: 25,
                    thickness: 1.5,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(height: Spacing.formMd),
                  const AnnouncementCard(),
                  const AnnouncementCard(),
                  const AnnouncementCard(),
                  const AnnouncementCard(),
                  const AnnouncementCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const EBBottomAppBar(),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: EBColor.materialPrimary.shade200,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 2,
          color: EBColor.primary,
        ),
      ),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EBTypography.h4(
                      text: "Barangay Community Potluck Picnic: Let's Celebrate Together!",
                      color: EBColor.primary,
                      cutOverflow: true,
                      maxLines: 3,
                    ),
                    EBTypography.small(text: 'September 10, 2034', color: EBColor.dark, muted: true),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.formLg),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EBButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const AnnouncementScreen(),
                          ),
                        );
                      },
                      text: 'View',
                      theme: EBButtonTheme.primary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SphereInfoCard extends StatelessWidget {
  const SphereInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: EBColor.materialPrimary.shade200,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 2,
          color: EBColor.primary,
        ),
      ),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EBTypography.h4(text: 'San Felipe, Naga City', color: EBColor.dark),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          padding: const EdgeInsets.only(right: 5.0),
                          icon: const Icon(FeatherIcons.copy),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        EBTypography.text(text: 'BSF-09124A', color: EBColor.dark),
                        EBTypography.small(text: 'Copy this code', color: EBColor.dark),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        EBTypography.small(text: '42', color: EBColor.primary),
                        const SizedBox(width: 5),
                        const Icon(
                          FeatherIcons.user,
                          size: 20,
                          color: EBColor.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
