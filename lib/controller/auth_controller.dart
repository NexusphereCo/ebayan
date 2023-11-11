import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/data/model/login_model.dart';
import 'package:ebayan/data/model/municipality_model.dart';
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

  dynamic fetchMunicipalities() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('municipalities').orderBy('municipality').get();
      final municipalities = querySnapshot.docs
          .map((doc) => MunicipalityModel(
                municipality: doc['municipality'],
                zipCode: doc['zipCode'],
              ))
          .toList();

      log.d('Successfully fetched municipalities.');
      return municipalities;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching municipalities!';
    }
  }

  DocumentReference fetchMunicipality(String muniId) {
    try {
      return FirebaseFirestore.instance.collection('municipalities').doc(muniId);
    } catch (e) {
      log.e('Error fetching municipality: $e');
      throw 'An error occurred while fetching the municipality: $muniId';
    }
  }

  dynamic fetchBarangaysFromMunicipality(String muniId) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('municipalities').doc(muniId).collection('barangays').orderBy('name').get();
      final barangays = querySnapshot.docs
          .map((doc) => BarangayModel(
                name: doc['name'],
                code: doc['code'],
              ))
          .toList();

      log.d('Successfully fetched Barangay.');
      return barangays;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching barangay!';
    }
  }

  DocumentReference fetchBarangay(String muniId, String brgyId) {
    try {
      return FirebaseFirestore.instance.collection('municipalities').doc(muniId).collection('barangays').doc(brgyId);
    } catch (e) {
      log.e('Error fetching municipality: $e');
      throw 'An error occurred while fetching the municipality: $brgyId';
    }
  }

  Future<void> register(RegisterOfficialModel docData) async {
    try {
      log.i(docData.toJson());

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: docData.email, password: docData.password);
      await FirebaseFirestore.instance.collection('brgyOfficials').add(docData.toJson());

      // putting doc proof to the firebaseStorage
      final storage = FirebaseStorage.instance.ref();
      final folder = storage.child('proofs');
      final proof = folder.child('DOC_${docData.lastName.toUpperCase()}_${DateTime.timestamp()}.pdf');

      await proof.putFile(docData.proofOfOfficial);
      log.i('Successfully registered user! Navigating to dashboard');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred during registration.';
    }
  }
}
