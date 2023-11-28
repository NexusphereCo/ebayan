import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class ChangePasswordModalForm extends StatefulWidget {
  const ChangePasswordModalForm({super.key});

  @override
  State<ChangePasswordModalForm> createState() => _ChangePasswordModalFormState();
}

class _ChangePasswordModalFormState extends State<ChangePasswordModalForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EBLoadingScreen _loadingScreen = const EBLoadingScreen();
  final UserController _userController = UserController();
  // controllers
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  // variables
  bool _showPassword = false;

  Future<void> _changePassword() async {
    _loadingScreen.show(context);
    bool isFormValid = _formKey.currentState?.validate() == true;

    if (isFormValid) {
      final passw = _passwordController.text;

      await _userController.changePassword(passw).then(
        (value) {
          _loadingScreen.hide(context);
          Navigator.of(context).pop();
        },
      ).catchError(
        (err) {
          ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: err));
          Navigator.of(context).pop();
        },
      );
    }

    if (context.mounted) _loadingScreen.hide(context);
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
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
                controller: _passwordController,
                label: 'Password',
                type: TextInputType.text,
                obscureText: _showPassword ? false : true,
                suffixIconButton: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: _showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                    onPressed: () => setState(() {
                      _showPassword = !_showPassword;
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
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                type: TextInputType.text,
                obscureText: _showPassword ? false : true,
                suffixIconButton: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: _showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                    onPressed: () => setState(() {
                      _showPassword = !_showPassword;
                    }),
                  ),
                ),
                maxLines: 1,
                validator: (value) {
                  value = value?.trim();
                  if (value == null || value.isEmpty) return Validation.missingField;
                  if (value != _passwordController.text) return Validation.mismatchPassword;
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
                  onPressed: () => _changePassword(),
                  text: 'Change Password',
                  theme: EBButtonTheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: _buildForm(context),
      ),
    );
  }
}
