import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AnnouncementController {
  final Logger log = Logger();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> createAnnouncement(
    Map<String, dynamic> data,
  ) async {
    try {
      await _validateUser();

      String? barangayId = await _getBarangayId();

      await db.collection('barangays').doc(barangayId).collection('announcements').add(data);

      log.i('Announcement created successfully.');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while creating the announcement.';
    }
  }

  Future<void> updateAnnouncement(String announcementId, Map<String, dynamic> data) async {
    try {
      await _validateUser();

      String? barangayId = await _getBarangayId();

      await db.collection('barangays').doc(barangayId).collection('announcements').doc(announcementId).update(data);

      log.i('Announcement updated successfully.');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while updating the announcement.';
    }
  }

  Future<void> deleteAnnouncement(String announcementId) async {
    try {
      await _validateUser();

      String? barangayId = await _getBarangayId();

      await db.collection('barangays').doc(barangayId).collection('announcements').doc(announcementId).delete();

      log.i('Announcement deleted successfully.');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while deleting the announcement.';
    }
  }

  Future<List<Map<String, dynamic>>> fetchAnnouncements() async {
    try {
      await _validateUser();

      String? barangayId = await _getBarangayId();

      final QuerySnapshot querySnapshot = await db.collection('barangays').doc(barangayId).collection('announcements').orderBy('timeCreated', descending: true).get();

      final announcements = querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'body': doc['body'],
                'heading': doc['heading'],
                'timeCreated': doc['timeCreated'],
              })
          .toList();

      log.d('Successfully fetched announcements.');
      return announcements;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching announcements.';
    }
  }

  Future<void> _validateUser() async {
    if (user == null) {
      throw 'User not authenticated.';
    }
  }

  Future<String?> _getBarangayId() async {
    try {
      if (user == null) {
        throw 'User not authenticated.';
      }

      final DocumentSnapshot userDoc = await db.collection('users').doc(user!.uid).get();

      if (userDoc.exists) {
        return userDoc['barangayAssociated'];
      } else {
        throw 'User document not found.';
      }
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while getting barangayId.';
    }
  }
}
