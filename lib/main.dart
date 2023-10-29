import 'package:ebayan/constants/theme.dart';
import 'package:ebayan/data/firebase_init.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setSystemUIOverlayStyle();
  await setPreferredOrientations();
  await firebaseInit();

  runApp(const InitApp());
}

class InitApp extends StatelessWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eBayan',
      theme: EBTheme.data(),
      routes: Routes.routes,
      home: const RouteGuard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RouteGuard extends StatelessWidget {
  const RouteGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          // Use Future.delayed to perform navigation after the current build cycle
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacementNamed(user == null ? '/login' : '/dashboard');
          });
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
