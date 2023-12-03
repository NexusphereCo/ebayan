import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/data/model/municipality_model.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/data/viewmodel/barangay_view_model.dart';
import 'package:logger/logger.dart';

class BarangayController {
  final Logger _log = Logger();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final UserController _userController = UserController();

  Future<List<MunicipalityModel>> fetchMunicipalities() async {
    final querySnapshot = await _db.collection('municipalities').orderBy('municipality').get();

    if (querySnapshot.docs.isNotEmpty) {
      final municipalities = querySnapshot.docs
          .map((doc) => MunicipalityModel(
                municipality: doc['municipality'],
                zipCode: doc['zipCode'],
              ))
          .toList();

      _log.d('Successfully fetched municipalities.');
      return municipalities;
    } else {
      _log.e('No municipalities found!');
      throw 'No municipalities found!';
    }
  }

  DocumentReference fetchMunicipality(String muniId) {
    return _db.collection('municipalities').doc(muniId);
  }

  Future<List<BarangayModel>> fetchBarangaysFromMunicipality(String muniId) async {
    final querySnapshot = await _db.collection('municipalities').doc(muniId).collection('barangays').orderBy('name').get();

    if (querySnapshot.docs.isNotEmpty) {
      final barangays = querySnapshot.docs
          .map((doc) => BarangayModel(
                name: doc['name'],
                code: doc['code'],
              ))
          .toList();

      _log.d('Successfully fetched Barangay.');
      return barangays;
    } else {
      _log.e('No barangays found!');
      throw 'No barangays found!';
    }
  }

  Future<BarangayViewModel> fetchBarangayWithLatestAnnouncement(String brgyId) async {
    // Find the barangay
    var barangaysRef = _db.collectionGroup('barangays');
    var barangaySnapshot = await barangaysRef.where('code', isEqualTo: int.parse(brgyId)).get();

    // Check if there is no document
    if (barangaySnapshot.docs.isEmpty) {
      _log.e('Barangay: $brgyId not found');
      throw 'Barangay not found!';
    }

    // Take the first document assuming there's only one match
    var doc = barangaySnapshot.docs.first;

    // Fetch announcements
    final announcementsSnapshot = await doc.reference.collection('announcements').orderBy('timeCreated', descending: true).limit(7).get();
    List<AnnouncementViewModel> announcements = [];

    if (announcementsSnapshot.docs.isNotEmpty) {
      announcements = await Future.wait(
        announcementsSnapshot.docs.map(
          (doc) async {
            final authorId = doc['authorId'];
            final author = await fetchAuthorName(authorId);

            return AnnouncementViewModel(
              id: doc.id,
              heading: doc['heading'],
              body: doc['body'],
              timeCreated: (doc['timeCreated'] as Timestamp).toDate(),
              author: author,
              authorId: authorId,
            );
          },
        ),
      );
    }

    // Get the total users joined in my barangay
    final usersJoinedBrgySnapshot = await _db.collection('users').where('barangayAssociated', isEqualTo: brgyId).get();
    int numOfPeople = usersJoinedBrgySnapshot.size;

    // Return the BarangayViewModel with the mapped announcements
    return BarangayViewModel(
      code: doc['code'],
      name: doc['name'],
      adminId: doc['adminId'],
      announcements: announcements,
      numOfPeople: numOfPeople,
    );
  }

  Future<String> fetchAuthorName(String authorId) async {
    try {
      final userDoc = await _db.collection('users').doc(authorId).get();
      final String name = '${userDoc['firstName']} ${userDoc['lastName']}';
      return name;
    } catch (err) {
      _log.e('An error occurred while fetching author name: $err');
      _log.e('An error occurred while fetching author name: $authorId');
      throw 'An error occurred while fetching author name.';
    }
  }

  Future<bool> hasJoinedBrgy() async {
    final user = await _userController.getCurrentUserInfo();

    bool hasJoined = user.barangayAssociated != null;
    _log.i('Has joined a barangay: $hasJoined');

    return hasJoined;
  }

  Future<String?> getMunicipalityIdFromBarangayId(String barangayId) async {
    try {
      // Query to find the municipalityId based on the barangayId
      var querySnapshot = await _db.collectionGroup('barangays').where('barangayId', isEqualTo: barangayId).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        var barangayDoc = querySnapshot.docs.first;
        var municipalityId = barangayDoc.reference.parent.parent?.id;
        return municipalityId;
      } else {
        _log.i('Barangay with ID $barangayId not found.');
        return null;
      }
    } catch (e) {
      // Handle exceptions
      _log.e('An error occurred: $e');
      return null;
    }
  }

  Future<bool> isCodeValid(String code) async {
    // Query to find the barangayId across all municipalities
    var barangaysRef = _db.collectionGroup('barangays');
    var querySnapshot = await barangaysRef.where('code', isEqualTo: int.tryParse(code)).get();

    // Log whether the query returned any documents
    _log.i('Barangay code exist: ${querySnapshot.docs.isNotEmpty}');

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> joinBrgy(String code) async {
    // get the user's info to access the joined barangay
    final user = await _userController.getCurrentUserInfo();
    var userRef = _db.collection('users').doc(user.id);

    // update the user.barangayAssociated to the new code
    await userRef.update({'barangayAssociated': code});

    _log.i('Successfully joined a barangay!');
  }
}
