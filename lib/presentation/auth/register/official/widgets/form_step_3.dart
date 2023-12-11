import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

Widget buildLoginCred({
  required TabController tabController,
  // controllers
  required TextEditingController usernameController,
  required TextEditingController passwordController,
  required TextEditingController confirmPasswordController,
  // functions
  required void Function() onRegisterHandler,
  required void Function() togglePassIconHandler,
  // build context
  required BuildContext context,
  // variables
  required bool showPassword,
}) {
  return ListView(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        child: Column(
          children: [
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
            const SizedBox(height: Spacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                EBTextBox(
                  icon: FeatherIcons.user,
                  textField: EBTextField(
                    controller: usernameController,
                    enabled: false,
                    label: 'Username',
                    type: TextInputType.text,
                  ),
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
              ],
            ),
            const SizedBox(height: Spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    passwordController.text = '';
                    confirmPasswordController.text = '';
                  },
                  child: EBTypography.text(
                    text: 'Clear Information',
                    color: EBColor.green,
                    fontWeight: EBFontWeight.bold,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EBButton(
                  text: 'Previous',
                  theme: EBButtonTheme.primaryOutlined,
                  onPressed: () => tabController.animateTo(tabController.index - 1),
                ),
                const SizedBox(width: Spacing.sm),
                EBButton(
                  text: 'Register',
                  icon: Icon(
                    FeatherIcons.arrowRight,
                    size: EBFontSize.normal,
                    color: EBColor.light,
                  ),
                  theme: EBButtonTheme.primary,
                  onPressed: onRegisterHandler,
                ),
              ],
            ),
            const SizedBox(height: Spacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: EBTypography.text(
                    text: 'Already have an account? ',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: TextButton(
                    style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                    onPressed: () {
                      Navigator.of(context).push(createRoute(route: Routes.login));
                    },
                    child: EBTypography.text(
                      text: 'login.',
                      color: EBColor.primary,
                      fontWeight: EBFontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}
