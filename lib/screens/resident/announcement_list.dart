import 'dart:math';

import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/resident/dashboard.dart';
import 'package:ebayan/screens/resident/join_brgy.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

/*
  Authored by: Miguel Damien L. Garcera
  Company: NexusphereCo.
  Project: eBayan
  Feature: [EB-004] Dashboard (Resident) Screen
  Description: a dashboard screen for brgy. officials/residents to use. 
    after registering/logging in, users are redirected to this dashboard
    screen which will contain their list of barangay spheres.

    users after creating an account, will have an interactive guide/tutorial
    for navigating the dashboard.
 */

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const EBTopAppBar(),
        drawer: const EBDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(Global.paddingBody),
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
                  )
                ],
              ),
              const SizedBox(height: Spacing.formMd),
              const SphereCard(),
              const SizedBox(height: Spacing.formMd),
              const Divider(
                color: EBColor.primary,
                height: 25,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              const SizedBox(height: Spacing.formMd),
              const AnnouncementCard(),
            ],
          ),
        ),
        bottomNavigationBar: const EBBottomAppBar(),
      ),
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }

class AnnouncementCard extends StatefulWidget {
  const AnnouncementCard({
    super.key,
  });

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  SampleItem? selectedMenu;

  Widget _cardAnnouncment() {
    return Container(
      width: double.infinity,
      height: 125,
      color: EBColor.materialPrimary.shade200,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EBTypography.h4(text: "Barangay Community", color: EBColor.primary),
                  EBTypography.h4(text: "Potluck Picnic: Let's", color: EBColor.primary),
                  EBTypography.h4(text: "Celebrate Together!", color: EBColor.primary),
                  EBTypography.small(text: 'September 10, 2034', color: EBColor.dark, muted: true),
                  const SizedBox(height: Spacing.formMd),
                ],
              ),
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
                      theme: 'primary'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(
        width: 3,
        color: EBColor.primary,
      ),
    );

    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(15.0),
      bottomRight: Radius.circular(15.0),
      topLeft: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    );

    return Container(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Column(
              children: [
                _cardAnnouncment(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SphereCard extends StatefulWidget {
  const SphereCard({
    super.key,
  });

  @override
  State<SphereCard> createState() => _SphereCardState();
}

class _SphereCardState extends State<SphereCard> {
  SampleItem? selectedMenu;

  Widget _cardHeader() {
    return Container(
      width: double.infinity,
      height: 80,
      color: EBColor.materialPrimary.shade200,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EBTypography.h4(text: 'San Felipe, Naga City', color: EBColor.dark),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      EBTypography.small(text: '42', color: EBColor.primary),
                      const SizedBox(width: 5),
                      const Icon(
                        FeatherIcons.user,
                        size: 16,
                        color: EBColor.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(
        width: 3,
        color: EBColor.primary,
      ),
    );

    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(15.0),
      bottomRight: Radius.circular(15.0),
      topLeft: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    );

    return Container(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Column(
              children: [
                _cardHeader(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
