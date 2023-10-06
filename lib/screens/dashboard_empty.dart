import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/register.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/footer.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardEmptyScreen extends StatelessWidget {
  final String _emptyPath = 'assets/svgs/illustration/empty-state.svg';
  const DashboardEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EBTopAppBar(),
      drawer: EBDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  color: EBColor.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EBTypography.h1(text: 'Welcome Back, '),
                      EBTypography.h1(text: 'Jane!', color: EBColor.primary),
                    ],
                  ),
                  const SizedBox(height: Spacing.formLg),
                  Column(
                    children: [
                      SvgPicture.asset(_emptyPath),
                      const SizedBox(height: Spacing.formLg),
                      EBTypography.p(
                          text:
                              "You currently aren't joined to any barangay spheres. Let's change that!",
                          muted: true,
                          textAlign: TextAlign.center)
                    ],
                  ),
                  const SizedBox(height: Spacing.formLg),
                  SizedBox(
                    width: double.infinity,
                    child: EBButton(
                        onPressed: () {},
                        text: 'Get Started!',
                        theme: 'primary'),
                  ),
                  const SizedBox(height: Spacing.formLg),
                  const SizedBox(height: Spacing.formLg),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: const EBBottomAppBar(),
    );
  }
}
