import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/resident/join_brgy.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
