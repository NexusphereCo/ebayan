import 'package:ebayan/constants/theme.dart';
import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/utils/global.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setSystemUIOverlayStyle();
  await setPreferredOrientations();
  await firebaseInit();

  runApp(const InitApp());
}

Future<FirebaseApp> firebaseInit() async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class InitApp extends StatelessWidget {
  const InitApp({Key? key}) : super(key: key);

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
