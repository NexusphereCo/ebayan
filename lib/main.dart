import 'package:ebayan/data/firebase_init.dart';
import 'package:ebayan/screens/app.dart';
import 'package:ebayan/utils/global.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // initialize system settings
  WidgetsFlutterBinding.ensureInitialized();
  setSystemUIOverlayStyle();
  await setPreferredOrientations();

  // initialize Firebase services
  await firebaseInit();

  // run the application
  runApp(const MyApp());
}
