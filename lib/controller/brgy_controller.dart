import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class BarangayController {
  final Logger log = Logger();

  Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserInfo() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final officialDoc = await FirebaseFirestore.instance.collection('brgyOfficials').doc(user?.uid).get();
      final residentDoc = await FirebaseFirestore.instance.collection('brgyResidents').doc(user?.uid).get();

      if (officialDoc.exists) {
        return officialDoc;
      } else if (residentDoc.exists) {
        return residentDoc;
      } else {
        throw 'Document is not found!';
      }
    } catch (e) {
      throw 'Document is not found!';
    }
  }

  Future<bool> hasJoinedBrgy() async {
    try {
      final user = await getCurrentUserInfo();
      log.i(user.data());

      if (user.exists) {
        return user.data()?['barangayAssociated'] != null ? true : false;
      }
      throw 'Document is not found.';
    } catch (e) {
      log.e('An error occurred. $e');
      throw 'An error occurred. $e';
    }
  }
}
