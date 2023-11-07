import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/data/model/municipality_model.dart';
import 'package:logger/logger.dart';

class RegisterOfficialController {
  Logger logger = Logger();

  dynamic fetchMunicipalities() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('municipalities').orderBy('municipality').get();

      List<MunicipalityModel> municipalities = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;

          municipalities.add(
            MunicipalityModel(
              municipality: data['municipality'],
              zipCode: data['zipCode'],
            ),
          );
        }

        logger.d('Successfully fetched municipalities.');
        return municipalities;
      }
    } catch (err) {
      logger.e('$err');
      throw 'An error occurred while fetching municipalities!';
    }
  }

  dynamic fetchBarangay(String muniUid) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('municipalities').doc(muniUid).collection('barangays').orderBy('name').get();

      List<BarangayModel> barangays = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;

          barangays.add(
            BarangayModel(
              code: data['code'],
              name: data['name'],
            ),
          );
        }

        logger.d('Successfully fetched Barangay.');
        return barangays;
      }
    } catch (err) {
      logger.e('$err');
      throw 'An error occurred while fetching barangay!';
    }
  }
}
