import 'package:ebayan/constants/theme.dart';
import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  setSystemUIOverlayStyle();
  await setPreferredOrientations();

  runApp(InitApp(prefs: prefs));
}

class InitApp extends StatelessWidget {
  final SharedPreferences prefs;

  const InitApp({required this.prefs, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eBayan',
      theme: EBTheme.data(),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
