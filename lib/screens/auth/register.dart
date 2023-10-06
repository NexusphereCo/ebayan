import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/screens/auth/register_resident.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Column(
          children: [
            const EBBackButton(screenDestination: LoginScreen()),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      EBTypography.h1(
                        text: 'Be part of a Barangay!',
                        color: EBColor.primary,
                      ),
                      EBTypography.text(
                        text: 'Which user are you?',
                        muted: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 50.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EBTypography.label(
                        text: 'I am a:',
                        muted: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.formMd),
                  SizedBox(
                    width: double.infinity,
                    child: EBButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const RegisterResidentScreen(),
                          ),
                        );
                      },
                      text: 'Barangay Resident',
                      theme: 'primary',
                    ),
                  ),
                  const SizedBox(height: Spacing.formMd),
                  SizedBox(
                    width: double.infinity,
                    child: EBButton(
                      onPressed: () {},
                      text: 'Barangay Official',
                      theme: 'primary-outline',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: const EBFooter(),
    );
  }
}
