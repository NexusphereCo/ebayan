import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

class EmptyDashboardView extends StatelessWidget {
  const EmptyDashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
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
                  text: FirebaseAuth.instance.currentUser?.displayName ?? 'User',
                  color: EBColor.primary,
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(Asset.illustHouseEmptyPath),
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
                      onPressed: () {
                        Navigator.of(context).push(createRoute(route: '/dashboard/join_brgy'));
                      },
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(route: '/dashboard/join_brgy'));
        },
        child: const Icon(FeatherIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const EBAppBarBottom(),
    );
  }
}