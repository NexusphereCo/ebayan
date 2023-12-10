import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/data/model/login_model.dart';
import 'package:ebayan/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class LoginController {
  final FirebaseAuth _dbAuth = FirebaseAuth.instance;
  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;
  final Logger log = Logger();

  Future<void> signIn(LoginModel data) async {
    try {
      log.d('Logging in user...');

      // Query the user based on the provided email
      final userQuery = await _dbFirestore //
          .collection('users')
          .where('email', isEqualTo: data.email)
          .get();

      // Check if the user with the provided email exists
      if (userQuery.docs.isNotEmpty) {
        final userType = userQuery.docs.first['userType'];

        switch (userType) {
          case 'OFFICIAL':
            // If the user is an official, check if they are approved
            final isApproved = userQuery.docs.first['isApproved'] as bool;

            if (isApproved) {
              // Validated, sign-in the user
              await _dbAuth.signInWithEmailAndPassword(email: data.email, password: data.password);
              log.d('User has successfully logged in! Redirecting to the dashboard...');
            } else {
              throw Validation.accountOnProcess;
            }
            break;
          case 'RESIDENT':
            // If the user is a resident, just sign them in
            await _dbAuth.signInWithEmailAndPassword(email: data.email, password: data.password);
            log.d('User has successfully logged in! Redirecting to the dashboard...');
            break;
        }
      } else {
        throw Validation.noAccount;
      }
    } on FirebaseAuthException catch (err) {
      final errorMessages = {
        'invalid-email': Validation.invalidEmail,
        'wrong-password': Validation.wrongPassword,
        'user-disabled': Validation.userDisabled,
        'user-not-found': Validation.userNotFound,
        'invalid-login-credentials': Validation.invalidLoginCred,
        'invalid-credential': Validation.invalidLoginCred,
        'network-request-failed': Validation.networkFail,
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

class RegisterController {
  final FirebaseAuth _dbAuth = FirebaseAuth.instance;
  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;
  final Logger log = Logger();

  Future<void> registerAsOfficial(UserModel docData) async {
    try {
      log.i(docData.toJson());

      UserCredential userCredentials = await _dbAuth.createUserWithEmailAndPassword(email: docData.email, password: docData.password);
      await _dbFirestore.collection('users').doc(userCredentials.user?.uid).set(docData.toJson());

      // putting doc proof to the firebaseStorage
      final storage = FirebaseStorage.instance.ref();
      final folder = storage.child('proofs');
      final proof = folder.child('DOC_${docData.lastName.toUpperCase()}_${DateTime.timestamp()}.pdf');

      await proof.putFile(docData.proofOfOfficial!);

      // set the display name
      await userCredentials.user?.updateDisplayName(docData.firstName);

      await FirebaseAuth.instance.signOut();

      log.i('Successfully registered official! Navigating to waitlist');
    } on FirebaseAuthException catch (err) {
      final errorMessages = {
        'email-already-in-use': Validation.emailAlreadyInUse,
        'invalid-email': Validation.invalidEmail,
        'user-not-found': Validation.userNotFound,
        'operation-not-allowed': Validation.invalidLoginCred,
        'weak-password': Validation.weakPassword,
      };

      log.e('${err.code}: $err');
      throw errorMessages[err.code.toLowerCase()].toString();
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred during registration.';
    }
  }

  Future<void> registerAsResident(UserModel docData) async {
    try {
      log.i(docData.toJson());

      UserCredential userCredentials = await _dbAuth.createUserWithEmailAndPassword(email: docData.email, password: docData.password);
      await _dbFirestore //
          .collection('users')
          .doc(userCredentials.user?.uid)
          .set(docData.toJson());

      // set the display name
      await userCredentials.user?.updateDisplayName(docData.firstName);

      log.i('Successfully registered resident! Navigating to dashboard');
    } on FirebaseAuthException catch (err) {
      final errorMessages = {
        'email-already-in-use': Validation.emailAlreadyInUse,
        'invalid-email': Validation.invalidEmail,
        'user-not-found': Validation.userNotFound,
        'operation-not-allowed': Validation.invalidLoginCred,
        'weak-password': Validation.weakPassword,
      };

      log.e('${err.code}: $err');
      throw errorMessages[err.code.toLowerCase()].toString();
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred during registration.';
    }
  }
}
