import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/screens/auth/register.dart';
import 'package:ebayan/screens/resident/dashboard.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextControllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showPassword = false;

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // NOTE: fix this
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: const DashboardScreen(),
        ),
      );
    } catch (e) {
      print('Sign-in failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                EBTypography.h1(
                  text: 'Welcome Back!',
                  color: EBColor.primary,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                EBTypography.text(
                  text: 'Sign in to continue.',
                  muted: true,
                ),
              ],
            ),
            const SizedBox(height: Spacing.formMd),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  EBTextBox(
                    icon: FeatherIcons.user,
                    textField: EBTextField(
                      label: 'Username',
                      type: TextInputType.text,
                      controller: emailController,
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) {
                          return Validation.missingField;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    icon: FeatherIcons.lock,
                    textField: EBTextField(
                      label: 'Password',
                      type: TextInputType.text,
                      controller: passwordController,
                      obscureText: _showPassword ? false : true,
                      suffixIconButton: IconButton(
                        icon: _showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) {
                          return Validation.missingField;
                        }
                        return null;
                      },
                    ),
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
                      theme: EBButtonTheme.primary,
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          signIn();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: Spacing.formSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: EBTypography.text(
                          text: 'Don\'t have an account? ',
                          cutOverflow: true,
                        ),
                      ),
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
                        style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
                        child: Flexible(
                          child: EBTypography.text(
                            text: 'create a new account.',
                            color: EBColor.primary,
                            fontWeight: EBFontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const EBFooter(),
    );
  }
}
