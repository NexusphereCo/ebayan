import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class UserController {
  final Logger log = Logger();
  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _dbAuth = FirebaseAuth.instance;

  Future<String?> getCurrentUserName() async {
    return _dbAuth.currentUser?.displayName;
  }

  Future<UserViewModel> getCurrentUserInfo() async {
    final userDoc = await _dbFirestore.collection('users').doc(_dbAuth.currentUser?.uid).get();

    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      return UserViewModel.map(userDoc.id, userData);
    } else {
      log.i('Document is not found!');
      throw 'Document is not found!';
    }
  }

  Future<String> getUserType(String uid) async {
    final userDoc = await _dbFirestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      return userDoc.data()?['userType'];
    } else {
      throw 'Document is not found!';
    }
  }
}
