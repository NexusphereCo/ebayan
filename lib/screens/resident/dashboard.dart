import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardScreen extends StatelessWidget {
  final String _illustrationPath = 'assets/svgs/illustration/empty-state.svg';

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
                      SvgPicture.asset(_illustrationPath),
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
                      onPressed: () {},
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
