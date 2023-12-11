import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';
import 'package:ebayan/widgets/layout_components/footer.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class ForgotPasswordResetScreen extends StatefulWidget {
  const ForgotPasswordResetScreen({super.key});

  @override
  State<ForgotPasswordResetScreen> createState() => _ForgotPasswordResetScreenState();
}

class _ForgotPasswordResetScreenState extends State<ForgotPasswordResetScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(enablePop: true, noTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              EBTypography.h1(
                text: 'Reset Password',
                color: EBColor.primary,
                maxLines: 2,
              ),
              EBTypography.text(
                text: 'Enter your new password.',
                muted: true,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: Spacing.xl),
              EBTextBox(
                icon: FeatherIcons.lock,
                textField: EBTextField(
                  controller: passwordController,
                  label: 'Password',
                  type: TextInputType.text,
                  obscureText: showPassword ? false : true,
                  suffixIconButton: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      icon: showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                      onPressed: () => setState(() {
                        showPassword = !showPassword;
                      }),
                    ),
                  ),
                  maxLines: 1,
                  validator: (value) {
                    value = value?.trim();
                    if (value == null || value.isEmpty) return Validation.missingField;
                    if (value.length < 6) return Validation.requiredMinPassword;

                    return null;
                  },
                ),
              ),
              const SizedBox(height: Spacing.md),
              EBTextBox(
                icon: FeatherIcons.lock,
                textField: EBTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  type: TextInputType.text,
                  obscureText: showPassword ? false : true,
                  suffixIconButton: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      icon: showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                      onPressed: () => setState(() {
                        showPassword = !showPassword;
                      }),
                    ),
                  ),
                  maxLines: 1,
                  validator: (value) {
                    value = value?.trim();
                    if (value == null || value.isEmpty) return Validation.missingField;
                    if (value != passwordController.text) return Validation.mismatchPassword;
                    if (value.length < 6) return Validation.requiredMinPassword;

                    return null;
                  },
                ),
              ),
              const SizedBox(height: Spacing.md),
              SizedBox(
                width: double.infinity,
                child: EBButton(
                  onPressed: () {
                    Navigator.of(context).push(createRoute(route: Routes.forgotPasswOtp));
                  },
                  text: 'Reset Password',
                  icon: Icon(
                    FeatherIcons.arrowRight,
                    color: EBColor.light,
                    size: EBFontSize.h4,
                  ),
                  theme: EBButtonTheme.primary,
                ),
              ),
              const SizedBox(height: Spacing.xxxl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const EBFooter(),
    );
  }
}
