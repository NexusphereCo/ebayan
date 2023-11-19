import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

Widget buildForm({
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required void Function() onLoginHandler,
  required void Function() onTogglePasswordHandler,
  // variables
  required showPassword,
}) {
  return Column(
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
            final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

            if (value == null || value.isEmpty) {
              return Validation.missingField;
            } else if (!emailRegExp.hasMatch(value)) {
              return Validation.invalidEmail;
            }
            return null;
          },
        ),
      ),
      const SizedBox(height: Spacing.md),
      EBTextBox(
        icon: FeatherIcons.lock,
        textField: EBTextField(
          label: 'Password',
          type: TextInputType.text,
          controller: passwordController,
          obscureText: !showPassword,
          suffixIconButton: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
              onPressed: onTogglePasswordHandler,
            ),
          ),
          validator: (value) {
            value = value?.trim();
            value = value?.trim();
            if (value == null || value.isEmpty) return Validation.missingField;
            if (value.length < 6) return Validation.requiredMinPassword;

            return null;
          },
        ),
      ),
      const SizedBox(height: Spacing.sm),
      TextButton(
        onPressed: () {},
        child: EBTypography.text(
          text: 'Forgot Password?',
          color: EBColor.primary,
          fontWeight: EBFontWeight.bold,
        ),
      ),
      const SizedBox(height: Spacing.md),
      SizedBox(
        width: double.infinity,
        child: EBButton(
          text: 'Login',
          theme: EBButtonTheme.primary,
          onPressed: onLoginHandler,
        ),
      ),
      const SizedBox(height: Spacing.sm),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EBTypography.text(
            text: 'Don\'t have an account? ',
            cutOverflow: true,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(createRoute(route: '/register'));
            },
            style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
            child: EBTypography.text(
              text: 'create a new account.',
              color: EBColor.primary,
              fontWeight: EBFontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  );
}
