import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:ebayan/widgets/form.dart';
import 'package:feather_icons/feather_icons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                EBTypography.h1(text: 'Welcome Back!', color: EBColor.primary),
                EBTypography.p(text: 'Sign in to continue.'),
              ],
            ),
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const EBTextBox(
                  label: 'Username',
                  icon: FeatherIcons.user,
                  placeholder: 'Enter your username',
                  type: 'text',
                ),
                const SizedBox(height: 20.0),
                const EBTextBox(
                  label: 'Password',
                  icon: FeatherIcons.lock,
                  placeholder: 'Enter your password',
                  type: 'password',
                ),
                const SizedBox(height: 20.0),
                EBTypography.p(text: 'Forgot Password?'),
                const SizedBox(height: 20.0),
                EBButton(onPressed: () {}, text: 'Login', theme: 'primary'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
