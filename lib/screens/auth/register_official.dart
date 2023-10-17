import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/screens/auth/register.dart';
import 'package:ebayan/screens/resident/dashboard.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:ebayan/widgets/form.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  Authored by: Miguel Damien L. Garcera
  Company: NexusphereCo.
  Project: eBayan
  Feature: [EB-002] Register Official Screen
  Description: a register screen for brgy. Officials to use. 
    upon registering as x, users will be filling up a form regarding their 
    personal information and login credentials to be used within the app.
 */

class RegisterOfficialScreen extends StatefulWidget {
  const RegisterOfficialScreen({super.key});

  @override
  State<RegisterOfficialScreen> createState() => _RegisterOfficialScreenState();
}

class _RegisterOfficialScreenState extends State<RegisterOfficialScreen> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SafeArea(child: EBBackButton(screenDestination: RegisterScreen())),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    EBTypography.h1(
                      text: 'Be part of a Barangay!',
                      color: EBColor.primary,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        EBTypography.text(
                          text: 'Register as a ',
                          muted: true,
                          textAlign: TextAlign.center,
                        ),
                        EBTypography.text(
                          text: 'Barangay Official.',
                          muted: true,
                          textAlign: TextAlign.center,
                          fontWeight: EBFontWeight.bold,
                        ),
                        EBTypography.text(
                          text: ' Fill in your information to get started.',
                          muted: true,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.formMd),
              EBTypography.label(text: 'Personal Information'),
              const SizedBox(height: Spacing.formMd),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  EBTextBox(
                    label: 'First Name',
                    icon: FeatherIcons.user,
                    textField: EBTextField(
                      placeholder: 'Enter your first name',
                      type: TextInputType.name,
                    ),
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Last Name',
                    icon: FeatherIcons.user,
                    textField: EBTextField(
                      placeholder: 'Enter your last name',
                      type: TextInputType.name,
                    ),
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Contact Number',
                    icon: FeatherIcons.phone,
                    textField: EBTextField(
                      placeholder: 'Enter your contact number',
                      type: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Address',
                    icon: FeatherIcons.mapPin,
                    textField: EBTextField(
                      placeholder: 'Enter your address',
                      type: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Birth Date',
                    icon: FeatherIcons.calendar,
                    textField: EBTextField(
                      placeholder: 'Enter your birth date',
                      type: TextInputType.datetime,
                    ),
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Barangay Associated',
                    icon: FeatherIcons.navigation,
                    textField: EBTextField(
                      placeholder: 'Choose',
                      type: TextInputType.streetAddress,
                    ),
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Proof of Official Position',
                    icon: FeatherIcons.file,
                    textField: EBTextField(
                      placeholder: '*.pdf',
                      type: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: Spacing.formSm),
                ],
              ),
              const SizedBox(height: Spacing.formLg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EBTypography.label(text: 'Login Credentials'),
                  EBTypography.text(
                    text: 'This will be your account details when logging in to this app.',
                    muted: true,
                    textAlign: TextAlign.start,
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
                    textField: EBTextField(
                      placeholder: 'Enter your username',
                      type: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Password',
                    icon: FeatherIcons.lock,
                    textField: EBTextField(
                      placeholder: 'Enter your password',
                      type: TextInputType.text,
                      obscureText: _showPassword ? false : true,
                      suffixIconButton: IconButton(
                        icon: _showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Confirm Password',
                    icon: FeatherIcons.lock,
                    textField: EBTextField(
                      placeholder: 'Re-enter your password',
                      type: TextInputType.text,
                      obscureText: _showConfirmPassword ? false : true,
                      suffixIconButton: IconButton(
                        icon: _showConfirmPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                        onPressed: () {
                          setState(() {
                            _showConfirmPassword = !_showConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.formLg),
                  TextButton(
                    onPressed: () {},
                    child: EBTypography.text(
                      text: 'Clear Information',
                      color: EBColor.danger,
                      fontWeight: EBFontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Spacing.formSm),
                  SizedBox(
                    width: double.infinity,
                    child: EBButton(
                      text: 'Register',
                      theme: EBButtonTheme.primary,
                      onPressed: () {
                        // NOTE: This is temporary
                        Future<void> createNewUser() async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('finishedTutorial', false);
                        }

                        createNewUser();

                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const DashboardScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: Spacing.formSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      EBTypography.text(
                        text: 'Already have an account? ',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const LoginScreen(),
                            ),
                          );
                        },
                        child: EBTypography.text(
                          text: 'login.',
                          color: EBColor.primary,
                          fontWeight: EBFontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.formLg),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const EBFooter(),
    );
  }
}
