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

  Future<List<String>> fetchAnnouncementIDs() async {
    try {
      _validateUser();

      final DocumentSnapshot userDoc = await db.collection('users').doc(user!.uid).get();
      final CollectionReference announcements = db.collection('municipalities').doc(userDoc['muniId']).collection('barangays').doc(userDoc['barangayAssociated']).collection('announcements');

      final announcementList = await announcements.get();

      final List<String> announcementIDs = announcementList.docs.map((doc) => doc.id).toList();

      log.d('Successfully fetched announcement IDs.');
      return announcementIDs;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching announcement IDs.';
    }
  }

  Future<AnnouncementModel> viewAnnouncement(String annId) async {
    try {
      _validateUser();

      final DocumentSnapshot userDoc = await db.collection('users').doc(user!.uid).get();
      // Reference the specific document in the announcements collection
      DocumentSnapshot<Map<String, dynamic>> announcement = await db.collection('municipalities').doc(userDoc['muniId']).collection('barangays').doc(userDoc['barangayAssociated']).collection('announcements').doc(annId).get();

      if (announcement.exists) {
        // Map the document data to your AnnouncementModel class
        AnnouncementModel announcementData = AnnouncementModel.fromMap(announcement.data()!);

        log.i('Announcement details fetched successfully:'
            '\nHeading: ${announcementData.heading}'
            '\nBody: ${announcementData.body}'
            '\nTime Created: ${announcementData.formattedTime}');
        return announcementData;
      } else {
        throw 'Announcement not found.';
      }
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while fetching the announcement details.';
    }
  }

  void _validateUser() {
    if (user == null) {
      throw 'User not authenticated.';
    }
  }
}
