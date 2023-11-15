import 'package:ebayan/controller/auth_controller.dart';
import 'package:ebayan/data/model/login_model.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/shared/footer.dart';
import 'package:flutter/material.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:feather_icons/feather_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  void initState() {
    connectionHandler(context);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn(BuildContext context) async {
    EBLoadingScreen loadingScreen = const EBLoadingScreen();
    LoginController loginController = LoginController();
    final model = LoginModel(email: _emailController.text, password: _passwordController.text);

    loadingScreen.show(context);
    loginController.signIn(model).then((data) {
      loadingScreen.hide(context);

      if (context.mounted) Navigator.of(context).push(createRoute(route: '/dashboard'));
    }).catchError((err) {
      loadingScreen.hide(context);

      _formKey.currentState?.validate();
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar(text: err.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
              const SizedBox(height: Spacing.md),
              _buildForm(context),
            ],
          ),
        ),
        bottomNavigationBar: const EBFooter(),
      ),
    );
  }

  Form _buildForm(BuildContext context) {
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
            ),
          ),
          const SizedBox(height: Spacing.md),
          EBTextBox(
            icon: FeatherIcons.lock,
            textField: EBTextField(
              label: 'Password',
              type: TextInputType.text,
              controller: _passwordController,
              obscureText: _showPassword ? false : true,
              suffixIconButton: IconButton(
                icon: _showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                onPressed: () {
                  setState(() => _showPassword = !_showPassword);
                },
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
              onPressed: () {
                if (_formKey.currentState?.validate() == true) _signIn(context);
              },
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
      ),
    );
  }
}
