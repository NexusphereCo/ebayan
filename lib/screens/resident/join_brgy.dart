import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/resident/dashboard.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class JoinBrgyScreen extends StatelessWidget {
  final String _illustrationPath = 'assets/svgs/illustration/join-brgy.svg';

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
            Row(
              children: [
                IconButton(
                  color: EBColor.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: const DashboardScreen(),
                      ),
                    );
                  },
                  icon: const Icon(FeatherIcons.arrowLeft),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(_illustrationPath),
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
