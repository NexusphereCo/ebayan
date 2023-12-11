import 'package:ebayan/presentation/auth/account/info.dart';
import 'package:ebayan/presentation/auth/login/login.dart';
import 'package:ebayan/presentation/auth/register/official/screens/wait.dart';
import 'package:ebayan/presentation/auth/register/register.dart';
import 'package:ebayan/presentation/auth/register/official/official.dart';
import 'package:ebayan/presentation/auth/register/resident/resident.dart';
import 'package:ebayan/presentation/announcements/announcement/announcement.dart';
import 'package:ebayan/presentation/announcements/announcement/screens/create/create.dart';
import 'package:ebayan/presentation/announcements/announcement/screens/edit/edit.dart';
import 'package:ebayan/presentation/announcements/announcement/screens/saved/saved.dart';
import 'package:ebayan/presentation/announcements/announcement_list.dart';
import 'package:ebayan/presentation/dashboard/dashboard.dart';
import 'package:ebayan/presentation/dashboard/screens/dashboard_empty.dart';
import 'package:ebayan/presentation/dashboard/screens/dashboard_joined.dart';
import 'package:ebayan/presentation/join/join_brgy.dart';
import 'package:ebayan/presentation/people/people.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Routes {
  Routes._();
  // Splash screen
  static const String splash = '/splash';
  // --------------------------------------------------------------------------------------
  // Authentication related
  // --------------------------------------------------------------------------------------
  static const String login = '/login';
  static const String register = '/register';
  static const String accountInfo = '/account/info';
  static const String registerOfficial = '/register/as_official';
  static const String registerOfficialWaitlist = '/register/as_official/wait';
  static const String registerResident = '/register/as_resident';
  // --------------------------------------------------------------------------------------
  // Dashboard related
  // --------------------------------------------------------------------------------------
  static const String dashboard = '/dashboard';
  static const String dashboardJoined = '/dashboard/joined';
  static const String dashboardEmpty = '/dashboard/empty';
  static const String people = '/dashboard/people';
  static const String joinBrgy = '/dashboard/join_brgy';
  // --------------------------------------------------------------------------------------
  // Announcement related
  // --------------------------------------------------------------------------------------
  static const String announcement = '/dashboard/announcement';
  static const String announcements = '/dashboard/announcements';
  static const String createAnnouncement = '/dashboard/announcements/create';
  static const String editAnnouncement = '/dashboard/announcements/edit';
  static const String savedAnnouncement = '/account/announcements/saved';

  // Misc.
  static final Logger log = Logger();

  /// NOTE(Gene) IMPORTANT: when adding routes here, make sure to modify both variables
  /// Routes.routesMap and Routes.routes.

  // Map that associates route names with their corresponding screen widgets.
  // This is only used for createRoutes function
  static final Map<String, Widget Function()> routesMap = {
    // Authentication related
    login: () => const LoginScreen(),
    register: () => const RegisterScreen(),
    accountInfo: () => const AccountScreen(),
    registerOfficial: () => const RegisterOfficialScreen(),
    registerOfficialWaitlist: () => const WaitScreen(),
    registerResident: () => const RegisterResidentScreen(),
    // Dashboard related
    dashboard: () => const DashboardScreen(),
    dashboardJoined: () => const JoinedDashboardView(),
    dashboardEmpty: () => const EmptyDashboardView(),
    people: () => const PeopleScreen(),
    joinBrgy: () => const JoinBrgyScreen(),
    // Announcements related
    announcements: () => const AnnouncementListScreen(),
    createAnnouncement: () => const CreateAnnouncementScreen(),
    announcement: () => const AnnouncementScreen(),
    editAnnouncement: () => const EditAnnouncementScreen(),
    savedAnnouncement: () => const SavedAnnouncementScreen(),
  };

  // Map that associates route names with their corresponding builder functions.
  static final routes = <String, WidgetBuilder>{
    // Authentication related
    login: (BuildContext context) => const LoginScreen(),
    register: (BuildContext context) => const RegisterScreen(),
    accountInfo: (BuildContext context) => const AccountScreen(),
    registerOfficial: (BuildContext context) => const RegisterOfficialScreen(),
    registerOfficialWaitlist: (BuildContext context) => const WaitScreen(),
    registerResident: (BuildContext context) => const RegisterResidentScreen(),
    // Dashboard related
    dashboard: (BuildContext context) => const DashboardScreen(),
    dashboardJoined: (BuildContext context) => const JoinedDashboardView(),
    dashboardEmpty: (BuildContext context) => const EmptyDashboardView(),
    people: (BuildContext context) => const PeopleScreen(),
    joinBrgy: (BuildContext context) => const JoinBrgyScreen(),
    // Announcement related
    announcements: (BuildContext context) => const AnnouncementListScreen(),
    createAnnouncement: (BuildContext context) => const CreateAnnouncementScreen(),
    announcement: (BuildContext context) => const AnnouncementScreen(),
    editAnnouncement: (BuildContext context) => const EditAnnouncementScreen(),
    savedAnnouncement: (BuildContext context) => const SavedAnnouncementScreen(),
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
