import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/resident/dashboard.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/*
  Authored by: Johcel Gene T. Bitara
  Company: NexusphereCo.
  Project: eBayan
  Feature: [EB-003] Join Barangay Screen
  Description: a screen for brgy. residents to use. in this screen,
    user will be prompted to enter their code (disseminated by their officials)
    unto the textfield (consisting of numerical code).
 */

class JoinBrgyScreen extends StatelessWidget {
  const JoinBrgyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBTopAppBar(),
      drawer: const EBDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Column(
          children: [
            const EBBackButton(screenDestination: DashboardScreen()),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Asset.illustHousesPath),
                  const SizedBox(height: Spacing.formLg),
                  EBTypography.h3(text: 'Enter Barangay Sphere Code'),
                  EBTypography.text(
                    text: 'This code is disseminated by your barangay official',
                    muted: true,
                  ),
                  const SizedBox(height: Spacing.formLg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EBButton(
                        onPressed: () {},
                        text: 'Join',
                        theme: 'primary',
                      ),
                    ],
                  ),
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
