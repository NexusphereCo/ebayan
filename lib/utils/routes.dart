import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/screens/auth/register.dart';
import 'package:ebayan/screens/auth/register_official.dart';
import 'package:ebayan/screens/auth/register_resident.dart';
import 'package:ebayan/screens/resident/announcement.dart';
import 'package:ebayan/screens/resident/dashboard.dart';
import 'package:ebayan/screens/resident/join_brgy.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String splash = '/splash';

  // screens
  // authentication related
  static const String login = '/login';
  static const String register = '/register';
  static const String registerOfficial = '/register/as_official';
  static const String registerResident = '/register/as_resident';

  // dashboard related
  static const String dashboard = '/dashboard';
  static const String joinBrgy = '/dashboard/join_brgy';
  static const String announcement = '/dashboard/announcements';

  static final Map<String, Widget Function()> routesMap = {
    login: () => const LoginScreen(),
    register: () => const RegisterScreen(),
    registerOfficial: () => const RegisterOfficialScreen(),
    registerResident: () => const RegisterResidentScreen(),
    dashboard: () => const DashboardScreen(),
    joinBrgy: () => const JoinBrgyScreen(),
    announcement: () => const AnnouncementScreen(),
    // Add more route mappings as needed
  };

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => const LoginScreen(),
    register: (BuildContext context) => const RegisterScreen(),
    registerOfficial: (BuildContext context) => const RegisterOfficialScreen(),
    registerResident: (BuildContext context) => const RegisterResidentScreen(),
    dashboard: (BuildContext context) => const DashboardScreen(),
    joinBrgy: (BuildContext context) => const JoinBrgyScreen(),
    announcement: (BuildContext context) => const AnnouncementScreen(),
  };
}

Route createRoute(String destination) {
  final destinationBuilder = Routes.routesMap[destination];

  if (destinationBuilder != null) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationBuilder(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  throw Exception("Invalid route. Cannot create route!");
}
