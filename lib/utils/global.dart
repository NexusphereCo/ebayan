import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ebayan/firebase_options.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
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
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

    return userDoc;
  } catch (e) {
    throw 'Document is not found!';
  }
}

Future<String> getUserType(String uid) async {
  try {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return 'user';
  } catch (e) {
    throw 'Document is not found!';
  }
}

/// this function handles connection error such as no connection.
Future<void> connectionHandler(BuildContext context) async {
  final Logger log = Logger();

  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    log.i('Checking for network...');

    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      log.e('Connection: lost connection to the network!');
      // Save the previous route when the connection is lost.
      if (context.mounted) {
        // Navigate to the error screen 502.
        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.lostConnection());
      }
    }
  });
}

Future<bool> isConnected() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return (connectivityResult != ConnectivityResult.none);
}
