import 'package:ebayan/presentation/auth/login/login.dart';
import 'package:ebayan/presentation/auth/register/register.dart';
import 'package:ebayan/presentation/auth/register/official/official.dart';
import 'package:ebayan/presentation/auth/register/resident/resident.dart';
import 'package:ebayan/presentation/dashboard/announcements/announcement.dart';
import 'package:ebayan/presentation/dashboard/dashboard/dashboard.dart';
import 'package:ebayan/presentation/dashboard/join/join_brgy.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  // Screens
  static const String splash = '/splash';

  // Authentication related
  static const String login = '/login';
  static const String register = '/register';
  static const String registerOfficial = '/register/as_official';
  static const String registerResident = '/register/as_resident';

  // Dashboard related
  static const String dashboard = '/dashboard';
  static const String joinBrgy = '/dashboard/join_brgy';
  static const String announcementList = '/dashboard/announcement';

  /// NOTE(Gene): when adding routes here, make sure to modify both variables
  /// Routes.routesMap and Routes.routes.

  // Map that associates route names with their corresponding screen widgets.
  static final Map<String, Widget Function()> routesMap = {
    login: () => const LoginScreen(),
    register: () => const RegisterScreen(),
    registerOfficial: () => const RegisterOfficialScreen(),
    registerResident: () => const RegisterResidentScreen(),
    dashboard: () => const DashboardScreen(),
    joinBrgy: () => const JoinBrgyScreen(),
    announcementList: () => const AnnouncementListScreen(),
  };

  // Map that associates route names with their corresponding builder functions.
  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => const LoginScreen(),
    register: (BuildContext context) => const RegisterScreen(),
    registerOfficial: (BuildContext context) => const RegisterOfficialScreen(),
    registerResident: (BuildContext context) => const RegisterResidentScreen(),
    dashboard: (BuildContext context) => const DashboardScreen(),
    joinBrgy: (BuildContext context) => const JoinBrgyScreen(),
    announcementList: (BuildContext context) => const AnnouncementListScreen(),
  };
}

/// Creates a custom page route for navigation.
///
/// The [createRoute] function is used to generate a custom page route for
/// navigation. It takes a [route] parameter, which represents the
/// name of the route to navigate to. It first checks if the [route] has
/// a corresponding builder function in the [Routes.routesMap]. If a builder
/// function is found, it creates a [PageRouteBuilder] with a custom animation
/// effect using [SlideTransition].
///
/// The animation starts from the right (1.0, 0.0) and moves to the left (0.0),
/// applying a smoothing curve for the transition effect.
///
/// If the [route] is not found in the [Routes.routesMap], it throws an
/// exception with the message "Invalid route. Cannot create route!".
///
/// Example:
///
/// ```dart
/// Navigator.of(context).push(createRoute('/dashboard'));
/// ```
Route createRoute({required String route, Object? args}) {
  // Get the builder function for the given destination.
  // refer to the above variable for routesMap.
  final destinationBuilder = Routes.routesMap[route];

  // Check if the builder function is found.
  if (destinationBuilder != null) {
    // Create a PageRouteBuilder with a custom animation effect.
    return PageRouteBuilder(
      // The page builder function is used to build the destination widget.
      pageBuilder: (context, animation, secondaryAnimation) => destinationBuilder(),
      settings: RouteSettings(name: route, arguments: args),
      // The transitionsBuilder is used to define the transition animation.
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define the start and end positions of the animation.
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;

        // Define a smoothing curve for the animation.
        const curve = Curves.ease;

        // Create a tween for the animation.
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        // Apply a SlideTransition with the animation and child widget.
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // If destination is not found, throw an exception.
  throw Exception("Invalid route. Cannot create route!");
}
