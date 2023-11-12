import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/utils/global.dart';
import 'package:logger/logger.dart';

class BarangayController {
  final Logger log = Logger();

  Future<bool> hasJoinedBrgy() async {
    try {
      final user = await getCurrentUserInfo();
      log.i(user.data());

      if (user.exists) {
        bool hasJoined = user.data()?['barangayAssociated'] != null ? true : false;
        log.i('Has joined a barangay: $hasJoined');

        return hasJoined;
      }
      throw 'Document is not found.';
    } catch (e) {
      log.e('An error occurred. $e');
      throw 'An error occurred. $e';
    }
  }

  Future<bool> isCodeValid(String code) async {
    try {
      // Query to find the barangayId across all municipalities
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collectionGroup('barangays').where('id', isEqualTo: code).where('code', isEqualTo: code).get();

      // Check if the query returned any documents
      log.i('Barangay code exist: ${querySnapshot.docs.isNotEmpty}');

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle exceptions
      log.e('An error occurred: $e');
      return false;
    }
  }

  Future<void> joinBrgy(String code) async {
    try {
      final user = await getCurrentUserInfo();
      final userType = await getUserType(user.id);

      var userRef = FirebaseFirestore.instance.collection(userType).doc(user.id);
      userRef.update({'barangayAssociated': code});

      log.i('Successfully updated barangay.');
    } catch (e) {
      log.e('An error occurred. $e');
      throw 'An error occurred. $e';
    }
  }
}
