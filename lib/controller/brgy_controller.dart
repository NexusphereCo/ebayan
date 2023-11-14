import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/data/model/municipality_model.dart';
import 'package:ebayan/utils/global.dart';
import 'package:logger/logger.dart';

class BarangayController {
  final Logger log = Logger();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  dynamic fetchMunicipalities() async {
    try {
      final QuerySnapshot querySnapshot = await db.collection('municipalities').orderBy('municipality').get();
      final municipalities = querySnapshot.docs
          .map((doc) => MunicipalityModel(
                municipality: doc['municipality'],
                zipCode: doc['zipCode'],
              ))
          .toList();

      log.d('Successfully fetched municipalities.');
      return municipalities;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching municipalities!';
    }
  }

  DocumentReference fetchMunicipality(String muniId) {
    try {
      return db.collection('municipalities').doc(muniId);
    } catch (e) {
      log.e('Error fetching municipality: $e');
      throw 'An error occurred while fetching the municipality: $muniId';
    }
  }

  dynamic fetchBarangaysFromMunicipality(String muniId) async {
    try {
      final QuerySnapshot querySnapshot = await db.collection('municipalities').doc(muniId).collection('barangays').orderBy('name').get();
      final barangays = querySnapshot.docs
          .map((doc) => BarangayModel(
                name: doc['name'],
                code: doc['code'],
              ))
          .toList();

      log.d('Successfully fetched Barangay.');
      return barangays;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching barangay!';
    }
  }

  DocumentReference fetchBarangay(String muniId, String brgyId) {
    try {
      return db.collection('municipalities').doc(muniId).collection('barangays').doc(brgyId);
    } catch (e) {
      log.e('Error fetching municipality: $e');
      throw 'An error occurred while fetching the municipality: $brgyId';
    }
  }

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
      var barangaysRef = db.collectionGroup('barangays');
      var querySnapshot = await barangaysRef.where('code', isEqualTo: int.parse(code)).get();

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

      var userRef = db.collection(userType).doc(user.id);
      userRef.update({'barangayAssociated': code});

      log.i('Successfully joined a barangay!.');
    } catch (e) {
      log.e('An error occurred. $e');
      throw 'An error occurred. $e';
    }
  }
}
