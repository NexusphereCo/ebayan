import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBTopAppBar(),
      drawer: const EBDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EBTypography.h1(text: 'Welcome Back, '),
                EBTypography.h1(
                  text: 'Jane!',
                  color: EBColor.primary,
                ),
              ],
            ),
            const SizedBox(height: Spacing.formLg),
            const SpaceCard(),
            const SizedBox(height: Spacing.formMd),
            const SpaceCard()
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(Asset.illustHouseEmptyPath),
                      const SizedBox(height: Spacing.formLg),
                      EBTypography.text(
                        text: "You currently aren't joined to any barangay spheres. Let's change that!",
                        muted: true,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.formLg),
                  SizedBox(
                    width: double.infinity,
                    child: EBButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const JoinBrgyScreen(),
                          ),
                        );
                      },
                      text: 'Get Started!',
                      theme: 'primary',
                    ),
                  ),
                  const SizedBox(height: Spacing.formLg),
                  const SizedBox(height: Spacing.formLg),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const EBBottomAppBar(),
    );
  }
}

class SpaceCard extends StatelessWidget {
  const SpaceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 3,
          color: EBColor.primary,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 125,
                  color: EBColor.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            EBTypography.h4(
                              text: 'San Felipe, Naga City',
                              color: EBColor.light,
                              fontWeight: EBFontWeight.bold,
                            ),
                            EBTypography.small(
                              text: '091230',
                              color: EBColor.light,
                              fontWeight: EBFontWeight.thin,
                            ),
                            const SizedBox(height: Spacing.formMd),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(Asset.illustHousePath, fit: BoxFit.fitHeight),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 75,
                  color: EBColor.materialPrimary[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.bullhorn,
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                EBTypography.small(text: 'New announcement 1hr ago'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const FaIcon(
                                  FeatherIcons.user,
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                EBTypography.small(text: '42 people'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: EBButton(onPressed: () {}, text: 'View', theme: 'primary'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 10.0,
              child: IconButton(
                icon: const Icon(
                  FeatherIcons.moreHorizontal,
                  color: EBColor.light,
                ), // Replace with your three-dots icon
                onPressed: () {
                  // Add your action here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
