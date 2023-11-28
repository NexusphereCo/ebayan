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
              const LoginForm(),
            ],
          ),
        ),
        bottomNavigationBar: const EBFooter(),
      ),
    );
  }
}
