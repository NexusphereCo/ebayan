import 'package:ebayan/constants/theme.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/form.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const InitApp());
}

class InitApp extends StatelessWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eBayan-test',
      theme: EBTheme.data(),
      home: const TestScreen(),
      debugShowCheckedModeBanner: true,
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EBTextField(
                placeholder: 'Enter something',
                enabled: false,
                type: TextInputType.text,
              ),
              const SizedBox(height: 20),
              const EBTextField(
                placeholder: 'Enter something',
                type: TextInputType.text,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 5,
                children: [
                  EBButton(
                    onPressed: () {},
                    text: 'Default',
                    theme: EBButtonTheme.primary,
                  ),
                  EBButton(
                    onPressed: () {},
                    text: 'Button With Icon',
                    icon: const Icon(FeatherIcons.arrowRight),
                    theme: EBButtonTheme.primaryOutlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
