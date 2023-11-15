import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ebayan/firebase_options.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

/// customize the appearance of system elements
/// regarding the notification top overlay.
void setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // make navigation bar transparent.
    systemNavigationBarColor: Colors.transparent,
    // set navigation bar icon brightness to light.
    systemNavigationBarIconBrightness: Brightness.light,
    // make status bar transparent.
    statusBarColor: Colors.transparent,
    // met status bar icon brightness to dark.
    statusBarIconBrightness: Brightness.dark,
  ));
}

/// met preferred device orientations.
Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    // allow portrait orientation in the upright position.
    DeviceOrientation.portraitUp,
    // allow portrait orientation in the upside-down position.
    DeviceOrientation.portraitDown,
  ]);
}

Future<FirebaseApp> firebaseInit() async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<String?> getCurrentUserName() async {
  User? user = FirebaseAuth.instance.currentUser;
  return user?.displayName;
}

Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserInfo() async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;
    final officialDoc = await FirebaseFirestore.instance.collection('brgyOfficials').doc(user?.uid).get();
    final residentDoc = await FirebaseFirestore.instance.collection('brgyResidents').doc(user?.uid).get();

    if (officialDoc.exists) {
      return officialDoc;
    } else if (residentDoc.exists) {
      return residentDoc;
    } else {
      throw 'Document is not found!';
    }
  } catch (e) {
    throw 'Document is not found!';
  }
}

Future<String> getUserType(String uid) async {
  try {
    final officialDoc = await FirebaseFirestore.instance.collection('brgyOfficials').doc(uid).get();
    final residentDoc = await FirebaseFirestore.instance.collection('brgyResidents').doc(uid).get();

    if (officialDoc.exists) {
      return 'brgyOfficials';
    } else if (residentDoc.exists) {
      return 'brgyResidents';
    } else {
      throw 'Document is not found!';
    }
  } catch (e) {
    throw 'Document is not found!';
  }
}

Future<void> connectionHandler(BuildContext context) async {
  Logger log = Logger();
  ConnectivityResult previousConnectivity = await Connectivity().checkConnectivity();
  bool isDisconnected = false;
  Route<dynamic>? previousRoute;

  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    log.i('Checking for network...');

    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      log.e('Connection: lost connection to the network!');
      // Save the previous route when the connection is lost.
      if (context.mounted) {
        previousRoute = ModalRoute.of(context);
        isDisconnected = true;

        // Navigate to the error screen 502.
        Navigator.of(context).pushReplacement(createRoute(route: '/error/502'));
      }
    } else if (isDisconnected) {
      log.i('Connection: reestablished!');
      isDisconnected = false;

      // If the connection is restored, check if there's a previous route and navigate back.
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

    // Update the previous connectivity status.
    previousConnectivity = connectivityResult;
  });
}
