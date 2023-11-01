import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:logger/logger.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/shared/footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:feather_icons/feather_icons.dart';

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
  final Logger logger = Logger();

  // TextControllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;
  bool _showLoading = false;

  String _emailValidator = '';
  String _passwordValidator = '';
  String _miscValidator = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
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
          if (_showLoading) const EBLoadingScreen(),
        ],
      ),
      bottomNavigationBar: const EBFooter(),
    );
  }

  /// Attempts to sign in with the provided email and password.
  ///
  /// If successful, it navigates to the dashboard. If there are authentication errors,
  /// it displays appropriate error messages and handles them accordingly.
  ///
  /// [context] is the current build context.
  Future<void> _signIn(BuildContext context) async {
    setState(() => _showLoading = true);

    logger.d('logging in user...');

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      logger.d('user has successfully logged in! redirecting to dashboard...');

      if (context.mounted) Navigator.of(context).push(createRoute('/dashboard'));
    } on FirebaseAuthException catch (err) {
      final errorMessages = {
        'invalid-email': Validation.invalidEmail,
        'wrong-password': Validation.wrongPassword,
        'user-not-found': Validation.userNotFound,
        'invalid_login_credentials': Validation.invalidLoginCred,
        'too_many_requests': Validation.tooManyReq,
      };

      final errorMessage = errorMessages[err.code.toLowerCase()];

      if (errorMessage != null) {
        setState(() {
          if (err.code == 'wrong-password') {
            _passwordValidator = errorMessage;
          } else if (err.code == 'invalid-email') {
            _emailValidator = errorMessage;
          } else {
            _miscValidator = errorMessage;
          }
        });

        _formKey.currentState?.validate();

        if (context.mounted && _miscValidator.isNotEmpty) ScaffoldMessenger.of(context).showSnackBar(snackBar(text: _miscValidator));
      }

      setState(() => _showLoading = false);
      logger.e('${err.code}: $err');
    }
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
                if (value == null || value.isEmpty) return Validation.missingField;
                if (_emailValidator.isNotEmpty) return Validation.invalidEmail;
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
                if (value == null || value.isEmpty) return Validation.missingField;
                if (_passwordValidator.isNotEmpty) return Validation.wrongPassword;
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
                _resetValidator();

                logger.i('attempting to sign user in...');
                logger.i('validation state (is-valid): ${_formKey.currentState?.validate()}');

                if (_formKey.currentState?.validate() == true) {
                  _signIn(context);
                }
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
                  Navigator.of(context).push(createRoute('/register'));
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

  void _resetValidator() {
    setState(() {
      _emailValidator = '';
      _passwordValidator = '';
    });
  }
}
