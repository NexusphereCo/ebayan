import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/data/model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class LoginController {
  Logger logger = Logger();

  Future<void> signIn(LoginModel data) async {
    try {
      logger.d('logging in user...');

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: data.email, password: data.password);

      logger.d('user has successfully logged in! redirecting to dashboard...');
    } on FirebaseAuthException catch (err) {
      final errorMessages = {
        'invalid-email': Validation.invalidEmail,
        'wrong-password': Validation.wrongPassword,
        'user-not-found': Validation.userNotFound,
        'invalid_login_credentials': Validation.invalidLoginCred,
        'too_many_requests': Validation.tooManyReq,
      };

      logger.e('${err.code}: $err');
      throw errorMessages[err.code.toLowerCase()].toString();
    }
  }
}
