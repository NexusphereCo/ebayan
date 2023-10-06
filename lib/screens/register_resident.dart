import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/login.dart';
import 'package:ebayan/screens/register.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:ebayan/widgets/form.dart';
import 'package:feather_icons/feather_icons.dart';

class RegisterResidentScreen extends StatelessWidget {
  const RegisterResidentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Column(
                children: [
                  EBTypography.h1(
                      text: 'Be part of a Barangay!', color: EBColor.primary),
                  EBTypography.p(
                      text:
                          'Register as a Barangay Resident. Fill in your information to get started.',
                      muted: true,
                      textAlign: TextAlign.center),
                ],
              ),
              const SizedBox(height: Spacing.formMd),
              Row(
                children: [
                  EBTypography.p(text: 'Personal Information'),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  EBTextBox(
                    label: 'First Name',
                    icon: FeatherIcons.user,
                    placeholder: 'Enter your first name',
                    type: 'text',
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Last Name',
                    icon: FeatherIcons.user,
                    placeholder: 'Enter your last name',
                    type: 'text',
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Contact Number',
                    icon: FeatherIcons.phone,
                    placeholder: 'Enter your contact number',
                    type: 'text',
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Address',
                    icon: FeatherIcons.mapPin,
                    placeholder: 'Enter your address',
                    type: 'text',
                  ),
                  SizedBox(height: Spacing.formMd),
                  EBTextBox(
                    label: 'Birth Date',
                    icon: FeatherIcons.calendar,
                    placeholder: 'Enter your birth date',
                    type: 'text',
                  ),
                  SizedBox(height: Spacing.formSm),
                ],
              ),
              const SizedBox(height: Spacing.formMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EBTypography.p(text: 'Login Credentials'),
                  EBTypography.p(
                      text:
                          'This will be your account details when logging in to this app.',
                      muted: true,
                      textAlign: TextAlign.start),
                ],
              ),
              const SizedBox(height: Spacing.formSm),
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
                  const EBTextBox(
                    label: 'Password',
                    icon: FeatherIcons.lock,
                    placeholder: 'Enter your password',
                    type: 'password',
                  ),
                  const SizedBox(height: Spacing.formSm),
                  TextButton(
                    onPressed: () {},
                    child: EBTypography.b(
                      text: 'Clear Information',
                      color: EBColor.danger,
                    ),
                  ),
                  const SizedBox(height: Spacing.formSm),
                  SizedBox(
                    width: double.infinity,
                    child: EBButton(
                        text: 'Register',
                        theme: 'primary',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        }),
                  ),
                  const SizedBox(height: Spacing.formSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      EBTypography.p(text: 'Already have an account? '),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: EBTypography.b(
                            text: 'login.', color: EBColor.primary),
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
