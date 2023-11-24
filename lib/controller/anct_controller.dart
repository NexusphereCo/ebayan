import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AnnouncementController {
  final Logger log = Logger();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> createAnnouncement(String annId, Map<String, dynamic> data) async {
    try {
      _validateUser();

      // Reference the specific collection path
//  /*   CollectionReference<Map<String, dynamic>> announcements = _db.collectionGroup('announcements').where('id' isEqualTo: annId);*/

      // Add the announcement to the specific collection using the provided annId
      /*  await announcements.doc(annId).set(data);*/

      log.i('Announcement created successfully.');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while creating the announcement.';
    }
  }

  Future<void> updateAnnouncement(String annId, Map<String, dynamic> data) async {
    try {
      _validateUser();

      final DocumentSnapshot userDoc = await _db.collection('users').doc(user!.uid).get();
      // Reference the specific document in the announcements collection

      DocumentReference<Map<String, dynamic>> announcement = _db.collection('municipalities').doc(userDoc['muniId']).collection('barangays').doc(userDoc['barangayAssociated']).collection('announcements').doc(annId);

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

      final DocumentSnapshot userDoc = await _db.collection('users').doc(user!.uid).get();
      // Reference the specific document in the announcements collection

      DocumentReference<Map<String, dynamic>> announcement = _db.collection('municipalities').doc(userDoc['muniId']).collection('barangays').doc(userDoc['barangayAssociated']).collection('announcements').doc(annId);

      // Delete the document
      await announcement.delete();

      log.i('Announcement deleted successfully.');
    } catch (e) {
      log.e('An error occurred: $e');
      throw 'An error occurred while deleting the announcement.';
    }
  }

  Future<List<AnnouncementModel>> fetchAnnouncements() async {
    try {
      _validateUser();

      final DocumentSnapshot userDoc = await _db.collection('users').doc(user!.uid).get();
      var barangaysRef = _db.collectionGroup('barangays');
      var barangaySnapshot = await barangaysRef.where('code', isEqualTo: int.parse(userDoc['barangayAssociated'])).get();

      var doc = barangaySnapshot.docs.first;

      final announcementsSnapshot = await doc.reference.collection('announcements').orderBy('timeCreated', descending: true).get();

      final List<AnnouncementModel> announcementsList = announcementsSnapshot.docs.map((doc) {
        return AnnouncementModel(
          id: doc.id,
          heading: doc['heading'],
          body: doc['body'],
          timeCreated: (doc['timeCreated'] as Timestamp).toDate(),
        );
      }).toList();

      log.d('Successfully fetched announcements.');
      return announcementsList;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching announcements.';
    }
  }

  Future<AnnouncementViewModel> fetchAnnouncementDetails(String annId) async {
    try {
      _validateUser();

      final announcementsSnapshot = await _db.collectionGroup('announcements').where('id', isEqualTo: annId).get();

      if (announcementsSnapshot.docs.isEmpty) {
        throw 'Announcement not found.';
      }

      final announcementDoc = announcementsSnapshot.docs.first;

      final AnnouncementViewModel announcementDetails = AnnouncementViewModel(
        id: announcementDoc.id,
        heading: announcementDoc['heading'],
        body: announcementDoc['body'],
        timeCreated: (announcementDoc['timeCreated'] as Timestamp).toDate(),
      );

      log.d('Successfully fetched announcement details.');
      return announcementDetails;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching announcement details.';
    }
  }

  void _validateUser() {
    if (user == null) {
      throw 'User not authenticated.';
    }
  }
}
