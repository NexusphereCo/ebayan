import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/controller/auth_controller.dart';
import 'package:ebayan/data/model/login_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EBLoadingScreen _loadingScreen = const EBLoadingScreen();

  final LoginController _loginController = LoginController();

  // controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // variables
  bool _showPassword = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> _signIn() async {
    bool isFormValid = _formKey.currentState?.validate() == true;
    if (isFormValid) {
      final model = LoginModel(email: _emailController.text, password: _passwordController.text);

      _loadingScreen.show(context);

      // login the user
      _loginController.signIn(model).then(
        (data) {
          _loadingScreen.hide(context);
          Navigator.of(context).push(createRoute(route: Routes.dashboard));
        },
      ).catchError(
        (err) {
          _loadingScreen.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: err));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          EBTextBox(
            icon: FeatherIcons.user,
            textField: EBTextField(
              label: 'Username',
              type: TextInputType.text,
              controller: _emailController,
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
              maxLines: 1,
            ),
          ),
          const SizedBox(height: Spacing.md),
          EBTextBox(
            icon: FeatherIcons.lock,
            textField: EBTextField(
              label: 'Password',
              type: TextInputType.text,
              controller: _passwordController,
              obscureText: !_showPassword,
              suffixIconButton: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: _showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                  onPressed: () {
                    setState(() => _showPassword = !_showPassword);
                  },
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
              onPressed: () => _signIn(),
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
                  Navigator.of(context).push(createRoute(route: Routes.register));
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
      ),
    );
  }
}
