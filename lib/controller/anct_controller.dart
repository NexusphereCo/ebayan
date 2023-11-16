import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class AnnouncementController {
  final Logger log = Logger();
  final User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

  late CollectionReference _announcements;

  AnnouncementController() {
    initAnnouncements();
  }

  // Asynchronous method to initialize announcements collection
  Future<void> initAnnouncements() async {
    String? brgyID = await getBrgyID();
    String? muniID = await getMuniID();

    _announcements = db.collection('municipalities').doc(muniID).collection('barangays').doc(brgyID).collection('announcements');
  }

  // get users Barangay ID
  Future<String?> getBrgyID() async {
    DocumentSnapshot userDoc = await db.collection('brgyOfficial').doc(user?.uid).get();
    final brgyId = userDoc['barangayAssociated'];
    return brgyId;
  }

  //get users Municipality ID
  Future<String?> getMuniID() async {
    DocumentSnapshot userDoc = await db.collection('brgyOfficial').doc(user?.uid).get();

    final QuerySnapshot findMunId = await db.collection('municipalities').where('barangays', arrayContains: userDoc['barangayAssociated']).get();
    String muniId = findMunId.docs.first.id;
    return muniId;
  }

  // Format DateTime to a specific format
  String formatDT(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  //CRUD part

  //Create Announcement
  Future<void> createAnnouncement(String heading, String body) async {
    try {
      await _announcements.add({
        'heading': heading,
        'body': body,
        'timeCreated': formatDT(DateTime.now()),
      });
    } catch (e) {
      log.e('Error creating announcement: $e');
      throw 'An error occurred while creating the announcement';
    }
  }

  //Read Announcment
  Future<List<AnnouncementModel>> readAnnouncements() async {
    try {
      // Get all documents from the 'announcements' collection
      QuerySnapshot querySnapshot = await _announcements.get();

      // Return a list of announcement data
      return querySnapshot.docs.map((doc) {
        return AnnouncementModel(
          heading: doc['heading'],
          body: doc['body'],
          timeCreated: doc['timeCreated'],
        );
      }).toList();
    } catch (e) {
      log.e('Error reading announcement: $e');
      throw 'An error occurred while reading the announcement';
    }
  }

  //Update Announcement
  Future<void> updateAnnouncement(String annId, String newHeading, String newBody) async {
    try {
      await _announcements.doc(annId).update({
        'heading': newHeading,
        'body': newBody,
        'timeCreated': 'Edited(${formatDT(DateTime.now())})',
      });
    } catch (e) {
      log.e('Error updating announcement: $e');
      throw 'An error occurred while updating the announcement';
    }
  }

  //Delete Announcement
  Future<void> deleteAnnouncement(String annId) async {
    try {
      await _announcements.doc(annId).delete();
    } catch (e) {
      log.e('Error deleting announcement: $e');
      throw 'An error occurred while deleting the announcement';
    }
  }
}
