import 'package:ebayan/controller/auth_controller.dart';
import 'package:ebayan/data/model/login_model.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/shared/footer.dart';
import 'package:flutter/material.dart';

import 'widgets/form.dart';
import 'widgets/heading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EBLoadingScreen loadingScreen = const EBLoadingScreen();

  // Controller
  final LoginController loginController = LoginController();

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
    final model = LoginModel(email: _emailController.text, password: _passwordController.text);

    loadingScreen.show(context);
    loginController.signIn(model).then((data) {
      loadingScreen.hide(context);

      if (context.mounted) Navigator.of(context).push(createRoute(route: '/dashboard'));
    }).catchError((err) {
      loadingScreen.hide(context);

      _formKey.currentState?.validate();
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: err.toString()));
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
              buildHeading(),
              const SizedBox(height: Spacing.md),
              Form(
                key: _formKey,
                child: buildForm(
                  context: context,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  showPassword: _showPassword,
                  onTogglePasswordHandler: () {
                    setState(() => _showPassword = !_showPassword);
                  },
                  onLoginHandler: () {
                    if (_formKey.currentState?.validate() == true) _signIn(context);
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const EBFooter(),
      ),
    );
  }
}
