import 'package:ebayan/data/firebase_init.dart';
import 'package:ebayan/screens/app.dart';
import 'package:ebayan/utils/global.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setSystemUIOverlayStyle();
  await setPreferredOrientations();
  await firebaseInit();

  runApp(const MyApp());
}
