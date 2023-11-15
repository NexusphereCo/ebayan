import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:ebayan/widgets/shared/footer.dart';
import 'package:flutter/material.dart';

/*
  Authored by: Miguel Damien L. Garcera
  Company: NexusphereCo.
  Project: eBayan
  Feature: [EB-002] Register Screen
  Description: the initial register screen for brgy. officials/residents to 
    use. in this screen, users will have an option for registering either as
    brgy. officials or brgy. residents.
 */

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(enablePop: true, noTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: Spacing.xl),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EBTypography.label(
                    text: 'I am a:',
                    muted: true,
                  ),
                ],
              ),
              const SizedBox(height: Spacing.md),
              SizedBox(
                width: double.infinity,
                child: EBButton(
                  onPressed: () async {
                    if (await isConnected() && context.mounted) {
                      Navigator.of(context).push(createRoute(route: '/register/as_resident'));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: Validation.networkFail));
                    }
                  },
                  text: 'Barangay Resident',
                  theme: EBButtonTheme.primary,
                ),
              ),
              const SizedBox(height: Spacing.md),
              SizedBox(
                width: double.infinity,
                child: EBButton(
                  onPressed: () async {
                    if (await isConnected() && context.mounted) {
                      Navigator.of(context).push(createRoute(route: '/register/as_official'));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: Validation.networkFail));
                    }
                  },
                  text: 'Barangay Official',
                  theme: EBButtonTheme.primaryOutlined,
                ),
              ),
              const SizedBox(height: Spacing.xxxl),
            ],
          ),
        ),
      ),
      bottomSheet: const EBFooter(),
    );
  }
}
