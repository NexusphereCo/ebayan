import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/data/model/user_model.dart';
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

  Future<void> updateInfo(UserUpdateModel data) async {
    await _dbAuth.currentUser?.updateDisplayName(data.firstName);
    await _dbFirestore.collection('users').doc(_dbAuth.currentUser?.uid).update(data.toJson());
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await _dbAuth.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (err) {
      final errorMessages = {
        'requires-recent-login': Validation.requiresRecentLogin,
      };

      log.e('${err.code}: $err');
      throw errorMessages[err.code.toLowerCase()].toString();
    }
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

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    log.i('User has been logged out.');
  }

  Future<void> saveAnnouncement(String annId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      final savedAnnouncementRef = _dbFirestore.collection('users').doc(userId).collection('savedAnnouncements').doc(annId);

      // Check if the announcement is already saved to avoid duplicate entries
      final savedAnnouncementDoc = await savedAnnouncementRef.get();
      if (!savedAnnouncementDoc.exists) {
        await savedAnnouncementRef.set({});
        log.d('Successfully saved announcement.');
      } else {
        log.w('Announcement is already saved.');
      }
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while saving announcement.';
    }
  }

  Future<List<String>> getSavedAnnouncements() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      final snapshot = await _dbFirestore.collection('users').doc(userId).collection('savedAnnouncements').get();

      log.d('Successfully fetched saved announcements');
      return snapshot.docs.map((doc) => doc.id).toList(); // Assuming 'annId' is the document ID
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching saved announcements.';
    }
  }

  Future<void> deleteSavedAnnouncement(String annId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      final savedAnnouncementRef = _dbFirestore.collection('users').doc(userId).collection('savedAnnouncements').doc(annId);

      // Check if the announcement exists before deleting it
      final savedAnnouncementDoc = await savedAnnouncementRef.get();
      if (savedAnnouncementDoc.exists) {
        await savedAnnouncementRef.delete();
        log.d('Successfully deleted saved announcement.');
      } else {
        log.w('Announcement not found in saved list.');
      }
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while deleting saved announcement.';
    }
  }
}
