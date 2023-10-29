import 'package:ebayan/constants/theme.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
