import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/layouts/layout_dashboard.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
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
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        child: Column(
          children: [
            const EBBackButton(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Asset.illustHousesPath),
                  const SizedBox(height: Spacing.lg),
                  EBTypography.h3(
                    text: 'Enter Barangay Sphere Code',
                    textAlign: TextAlign.center,
                  ),
                  EBTypography.text(
                    text: 'This code is disseminated by your barangay official',
                    textAlign: TextAlign.center,
                    muted: true,
                  ),
                  const SizedBox(height: Spacing.lg),
                  MultiTextField(
                    onCompleted: (val) {},
                    onChanged: (val) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EBButton(
                        onPressed: () {},
                        text: 'Join',
                        theme: EBButtonTheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const EBAppBarBottom(),
    );
  }
}
