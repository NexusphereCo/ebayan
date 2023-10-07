import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/auth/register.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:ebayan/widgets/form.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:page_transition/page_transition.dart';

/*
  Authored by: Johcel Gene T. Bitara
  Company: NexusphereCo.
  Project: eBayan
  Feature: [EB-001] Login Screen
  Description: a login screen for brgy. officials/residents to use. 
    in this screen, they are required to input their username and password.
 */

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showTxtPassword = false;

  void _showPassword() {
    setState(() {
      showTxtPassword = !showTxtPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                EBTypography.h1(
                  text: 'Welcome Back!',
                  color: EBColor.primary,
                ),
                EBTypography.text(
                  text: 'Sign in to continue.',
                  muted: true,
                ),
              ],
            ),
            const SizedBox(height: Spacing.formMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const EBTextBox(
                  label: 'Username',
                  icon: FeatherIcons.user,
                  placeholder: 'Enter your username',
                  type: 'text',
                ),
                const SizedBox(height: Spacing.formMd),
                EBTextBox(
                  label: 'Password',
                  icon: FeatherIcons.lock,
                  placeholder: 'Enter your password',
                  type: showTxtPassword ? 'password-reveal' : 'password',
                  suffixIcon: showTxtPassword ? FeatherIcons.eye : FeatherIcons.eyeOff,
                  suffixIconOnPressed: _showPassword,
                ),
                const SizedBox(height: Spacing.formSm),
                TextButton(
                  onPressed: () {},
                  child: EBTypography.text(
                    text: 'Forgot Password?',
                    color: EBColor.primary,
                    fontWeight: EBFontWeight.bold,
                  ),
                ),
                const SizedBox(height: Spacing.formMd),
                SizedBox(
                  width: double.infinity,
                  child: EBButton(
                    text: 'Login',
                    theme: 'primary',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: Spacing.formSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    EBTypography.text(text: 'Don\'t have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const RegisterScreen(),
                          ),
                        );
                      },
                      child: EBTypography.text(
                        text: 'create a new account.',
                        color: EBColor.primary,
                        fontWeight: EBFontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: const EBFooter(),
    );
  }
}