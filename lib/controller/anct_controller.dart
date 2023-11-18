import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AnnouncementController {
  final Logger log = Logger();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> createAnnouncement(Map<String, dynamic> data) async {
    try {
      _validateUser();

      final DocumentSnapshot userDoc = await db.collection('users').doc(user!.uid).get();

      // Reference the specific collection path
      CollectionReference<Map<String, dynamic>> announcements = db.collection('municipalities').doc(userDoc['muniId']).collection('barangays').doc(userDoc['barangayAssociated']).collection('announcements');

      // Add the announcement to the specific collection
      await announcements.add(data);

      log.i('Announcement created successfully.');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while creating the announcement.';
    }
  }

  Future<void> updateAnnouncement(String annId, Map<String, dynamic> data) async {
    try {
      _validateUser();

      final DocumentSnapshot userDoc = await db.collection('users').doc(user!.uid).get();
      // Reference the specific document in the announcements collection
      DocumentReference<Map<String, dynamic>> announcement = db.collection('municipalities').doc(userDoc['muniId']).collection('barangays').doc(userDoc['barangayAssociated']).collection('announcements').doc(annId);

      // Update the document with the new data
      await announcement.update(data);

      log.i('Announcement updated successfully.');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while updating the announcement.';
    }
  }

  Future<void> deleteAnnouncement(String annId) async {
    try {
      _validateUser();

      final DocumentSnapshot userDoc = await db.collection('users').doc(user!.uid).get();
      // Reference the specific document in the announcements collection

      DocumentReference<Map<String, dynamic>> announcement = db.collection('municipalities').doc(userDoc['muniId']).collection('barangays').doc(userDoc['barangayAssociated']).collection('announcements').doc(annId);

      // Delete the document
      await announcement.delete();

      log.i('Announcement deleted successfully.');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while deleting the announcement.';
    }
  }

  Future<Stream<QuerySnapshot>> fetchAnnouncements() async {
    try {
      _validateUser();

      final DocumentSnapshot userDoc = await db.collection('users').doc(user!.uid).get();
      final CollectionReference announcements = db.collection('municipalities').doc(userDoc['muniId']).collection('barangays').doc(userDoc['barangayAssociated']).collection('announcements');

      final announcementList = announcements.orderBy('timeCreated', descending: true).snapshots();

      // Log data when received
      announcementList.listen((data) {
        for (var announcement in data.docs) {
          log.i('Announcement ID: ${announcement.id}');
          log.i('Announcement Data: ${announcement.data()}');
        }
      });

      log.d('Successfully fetched announcements.');
      return announcementList;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching announcements.';
    }
  }

  void _validateUser() {
    if (user == null) {
      throw 'User not authenticated.';
    }
  }
}
