import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
