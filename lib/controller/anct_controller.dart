import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/data/viewmodel/comment_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AnnouncementController {
  final Logger log = Logger();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<String> createAnnouncement(heading, body) async {
    try {
      final userDoc = await _db.collection('users').doc(user!.uid).get();
      final announcementDoc = (await _db.collectionGroup('barangays').where('code', isEqualTo: int.parse(userDoc['barangayAssociated'])).get()).docs.first;

      final announcementRef = await announcementDoc.reference.collection('announcements').add({
        'heading': heading,
        'body': body,
        'timeCreated': DateTime.now(),
        'authorId': userDoc.id,
      });

      await announcementRef.update({'id': announcementRef.id});
      log.d('Successfully created announcement.');
      return announcementRef.id.toString();
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while creating the announcement.';
    }
  }

  Future<String> updateAnnouncement(annId, heading, body) async {
    try {
      final announcementsRef = _db.collectionGroup('announcements');
      final announcementSnapshot = await announcementsRef.where('id', isEqualTo: annId).get();

      final announcementDoc = announcementSnapshot.docs.first;

      await announcementDoc.reference.update({
        'heading': heading,
        'body': body,
        'timeCreated': DateTime.now(),
      });

      log.d('Successfully updated announcement.');
      return annId;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while updating the announcement.';
    }
  }

  Future<void> deleteAnnouncement(String annId) async {
    try {
      final announcementsRef = _db.collectionGroup('announcements');
      final announcementSnapshot = await announcementsRef.where('id', isEqualTo: annId).get();

      if (announcementSnapshot.docs.isEmpty) {
        throw 'Announcement not found.';
      }

      final announcementDoc = announcementSnapshot.docs.first;
      await announcementDoc.reference.delete();

      log.d('Successfully deleted announcement.');
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while deleting the announcement.';
    }
  }

  Future<List<AnnouncementModel>> fetchAnnouncements() async {
    try {
      final DocumentSnapshot userDoc = await _db.collection('users').doc(user!.uid).get();
      var barangaysRef = _db.collectionGroup('barangays');
      var barangaySnapshot = await barangaysRef.where('code', isEqualTo: int.parse(userDoc['barangayAssociated'])).get();

      var announcementDoc = barangaySnapshot.docs.first;

      final announcementsSnapshot = await announcementDoc.reference.collection('announcements').orderBy('timeCreated', descending: true).get();

      final List<AnnouncementModel> announcementsList = announcementsSnapshot.docs.map((announcementDoc) {
        return AnnouncementModel(
          id: announcementDoc.id,
          heading: announcementDoc['heading'],
          body: announcementDoc['body'],
          timeCreated: (announcementDoc['timeCreated']).toDate(),
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
      final announcementsSnapshot = await _db.collectionGroup('announcements').where('id', isEqualTo: annId).get();

      if (announcementsSnapshot.docs.isEmpty) {
        throw 'Announcement not found.';
      }

      final announcementDoc = announcementsSnapshot.docs.first;
      final authorId = announcementDoc['authorId'];
      final author = await fetchAuthorName(authorId);

      final AnnouncementViewModel announcementDetails = AnnouncementViewModel(
        id: announcementDoc.id,
        heading: announcementDoc['heading'],
        body: announcementDoc['body'],
        timeCreated: announcementDoc['timeCreated'].toDate(),
        author: author,
        authorId: authorId,
      );

      log.d('Successfully fetched announcement details.');
      return announcementDetails;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching announcement details.';
    }
  }

  Future<String> fetchAuthorName(String authorId) async {
    try {
      final userDoc = await _db.collection('users').doc(authorId).get();
      final String name = '${userDoc['firstName']} ${userDoc['lastName']}';
      return name;
    } catch (err) {
      log.e('An error occurred while fetching author name: $err');
      log.e('An error occurred while fetching author name: $authorId');
      throw 'An error occurred while fetching author name.';
    }
  }

  Future<List<CommentViewModel>> fetchComments(String annId) async {
    try {
      final announcementsSnapshot = await _db.collectionGroup('announcements').where('id', isEqualTo: annId).get();

      if (announcementsSnapshot.docs.isEmpty) {
        throw 'Announcement not found.';
      }

      final doc = announcementsSnapshot.docs.first;

      final commentsSnapshot = await doc.reference.collection('reactions').orderBy('timeCreated', descending: true).get();
      List<CommentViewModel> comments = [];

      if (commentsSnapshot.docs.isNotEmpty) {
        comments = commentsSnapshot.docs
            .map((doc) => CommentViewModel(
                  username: doc['username'],
                  text: doc['text'],
                  timeCreated: doc['timeCreated'].toDate(),
                  userId: doc['userId'],
                ))
            .toList();
      }

      log.d('Successfully fetched comments: $comments');
      return comments;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching comments.';
    }
  }

  Future<List<AnnouncementModel>> fetchSavedAnnouncements() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      if (userId == null) {
        throw 'User not authenticated.';
      }

      final userController = UserController();
      final announcementController = AnnouncementController();

      final savedAnnIds = await userController.getSavedAnnouncements();

      final List<AnnouncementModel> savedAnnouncements = [];
      for (final annId in savedAnnIds) {
        final announcement = await announcementController.fetchAnnouncementDetails(annId.id);
        savedAnnouncements.add(announcement as AnnouncementModel);
      }

      return savedAnnouncements;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching saved announcements.';
    }
  }
}
