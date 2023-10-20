import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/screens/auth/register_resident.dart';
import 'package:ebayan/screens/auth/register_official.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

/*
  Authored by: Miguel Damien L. Garcera
  Company: NexusphereCo.
  Project: eBayan
  Feature: [EB-002] Register Screen
  Description: the initial register screen for brgy. officials/residents to 
    use. in this screen, users will have an option for registering either as
    brgy. officials or brgy. residents.
 */

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        child: Column(
          children: [
            const SafeArea(child: EBBackButton(screenDestination: LoginScreen())),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      EBTypography.h1(
                        text: 'Be part of a Barangay!',
                        color: EBColor.primary,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      EBTypography.text(
                        text: 'Which user are you?',
                        muted: true,
                        textAlign: TextAlign.center,
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
                      theme: EBButtonTheme.primary,
                    ),
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
                            child: const RegisterOfficialScreen(),
                          ),
                        );
                      },
                      text: 'Barangay Official',
                      theme: EBButtonTheme.primaryOutlined,
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
