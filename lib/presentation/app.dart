import 'package:ebayan/constants/theme.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

/// this class checks for the user's authState meaning if they are
/// logged in or not. it redirects them to which screen they should
/// be redirected based on their state: login (guest) or dashboard (authenticated)
class RouteGuard extends StatefulWidget {
  const RouteGuard({super.key});

  @override
  State<RouteGuard> createState() => _RouteGuardState();
}

class _RouteGuardState extends State<RouteGuard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final user = snapshot.data;

          // Use Future.delayed to perform navigation after the current build cycle.
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacementNamed(user == null ? '/login' : '/dashboard');
          });
        }

        // Show the loading screen or another appropriate widget.
        return const EBLoadingScreen(solid: true);
      },
    );
  }
}
