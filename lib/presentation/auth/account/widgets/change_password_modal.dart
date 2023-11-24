import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

Future<void> showChangePasswordModal({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  // controllers
  required TextEditingController passwordController,
  required TextEditingController confirmPasswordController,
  // functions
  required void Function() onSubmitHandler,
  required void Function() togglePassIconHandler,
  // variables
  required bool showPassword,
}) =>
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: EBColor.light,
            borderRadius: BorderRadius.circular(EBBorderRadius.lg),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 30,
                color: EBColor.green[600]!.withOpacity(0.25),
              ),
            ],
          ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(Global.paddingBody),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    EBTypography.h2(text: 'New Password'),
                    const SizedBox(height: Spacing.xs),
                    EBTypography.text(
                      text: 'Set the new password for your account so you can login and access all the features.',
                      muted: true,
                    ),
                    const SizedBox(height: Spacing.md),
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
                            onPressed: togglePassIconHandler,
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
                            onPressed: togglePassIconHandler,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: EBTypography.text(text: 'Cancel', color: EBColor.red),
                        ),
                        const SizedBox(width: Spacing.md),
                        EBButton(
                          onPressed: () => onSubmitHandler(),
                          text: 'Change Password',
                          theme: EBButtonTheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
