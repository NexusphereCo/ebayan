import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AnnouncementController {
  final Logger log = Logger();

  Future<List<AnnouncementModel>> fetchAnnouncements(String muniId) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final userDoc = await FirebaseFirestore.instance.collection('brgyResidents').doc(user?.uid).get();

      if (userDoc.exists) {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('municipalities').doc(muniId).collection('barangays').doc(userDoc['barangayAssociated']).collection('announcements').get();

        final announcements = querySnapshot.docs
            .map((doc) => AnnouncementModel(
                  heading: doc['heading'],
                  body: doc['body'],
                  timeCreated: doc['timeCreated'],
                ))
            .toList();

        log.d('Successfully fetched Announcements.');
        return announcements;
      } else {
        log.e('User document does not exist.');
        throw 'User document not found!';
      }
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching announcements!';
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchAnnouncement(String muniId, String annId) {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      return FirebaseFirestore.instance.collection('municipalities').doc(muniId).collection('barangays').doc(user?.uid).collection('announcements').doc(annId).get();
    } catch (e) {
      log.e('Error fetching announcement: $e');
      throw 'An error occurred while fetching the announcement: $annId';
    }
  }
}
