import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/data/model/login_model.dart';
import 'package:ebayan/data/model/register_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class LoginController {
  final Logger log = Logger();

  Future<void> signIn(LoginModel data) async {
    try {
      log.d('logging in user...');

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: data.email, password: data.password);

      log.d('user has successfully logged in! redirecting to dashboard...');
    } on FirebaseAuthException catch (err) {
      final errorMessages = {
        'invalid-email': Validation.invalidEmail,
        'wrong-password': Validation.wrongPassword,
        'user-not-found': Validation.userNotFound,
        'invalid_login_credentials': Validation.invalidLoginCred,
        'too_many_requests': Validation.tooManyReq,
      };

      log.e('${err.code}: $err');
      throw errorMessages[err.code.toLowerCase()].toString();
    } on Exception catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching municipalities!';
    }
  }
}

class RegisterOfficialController {
  final Logger log = Logger();

  Future<void> register(RegisterOfficialModel docData) async {
    try {
      log.i(docData.toJson());

      UserCredential userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: docData.email, password: docData.password);
      await FirebaseFirestore.instance.collection('brgyOfficials').doc(userCredentials.user?.uid).set(docData.toJson());

      // putting doc proof to the firebaseStorage
      final storage = FirebaseStorage.instance.ref();
      final folder = storage.child('proofs');
      final proof = folder.child('DOC_${docData.lastName.toUpperCase()}_${DateTime.timestamp()}.pdf');

      await proof.putFile(docData.proofOfOfficial);

      // set the display name
      await userCredentials.user?.updateDisplayName(docData.firstName);

      log.i('Successfully registered official! Navigating to dashboard');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred during registration.';
    }
  }
}

class RegisterResidentController {
  final Logger log = Logger();

  Future<void> register(RegisterResidentModel docData) async {
    try {
      log.i(docData.toJson());

      UserCredential userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: docData.email, password: docData.password);
      await FirebaseFirestore.instance.collection('brgyResidents').doc(userCredentials.user?.uid).set(docData.toJson());

      // set the display name
      await userCredentials.user?.updateDisplayName(docData.firstName);

      log.i('Successfully registered resident! Navigating to dashboard');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred during registration.';
    }
  }
}
