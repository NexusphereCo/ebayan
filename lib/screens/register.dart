import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/footer.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                EBTypography.h1(text: 'Be part of a Barangay!', color: EBColor.primary),
                EBTypography.p(text: 'Which user are you?', muted: true),
              ],
            ),
            const SizedBox(height: 50.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EBTypography.p(text: 'I am a:', muted: true),
              ],
            ),
            const SizedBox(height: Spacing.formMd),
            SizedBox(
              width: double.infinity,
              child: EBButton(onPressed: () {}, text: 'Barangay Resident', theme: 'primary'),
            ),
            const SizedBox(height: Spacing.formMd),
            SizedBox(
              width: double.infinity,
              child: EBButton(onPressed: () {}, text: 'Barangay Official', theme: 'primary-outline'),
            ),
          ],
        ),
      ),
      bottomSheet: const EBFooter(),
    );
  }
}
