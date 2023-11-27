import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/data/model/post_announcement_model.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/data/viewmodel/comment_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AnnouncementController {
  final Logger log = Logger();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> createAnnouncement(PostAnnouncementModel newAnnouncement) async {
    try {
      final userDoc = await _db.collection('users').doc(user!.uid).get();
      final announcementDoc = (await _db.collectionGroup('barangays').where('code', isEqualTo: int.parse(userDoc['barangayAssociated'])).get()).docs.first;
      final String authorName = '${userDoc['firstName']} ${userDoc['lastName']}';

      final announcementRef = await announcementDoc.reference.collection('announcements').add({
        'heading': newAnnouncement.heading,
        'body': newAnnouncement.body,
        'timeCreated': DateTime.now(),
        'author': authorName,
      });

      await announcementRef.update({'id': announcementRef.id});

      log.d('Successfully created announcement.');
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while creating the announcement.';
    }
  }

  Future<void> updateAnnouncement(PostAnnouncementModel updatedAnnouncement) async {
    try {
      final announcementsRef = _db.collectionGroup('announcements');
      final announcementSnapshot = await announcementsRef.where('id', isEqualTo: updatedAnnouncement.id).get();

      final announcementDoc = announcementSnapshot.docs.first;

      await announcementDoc.reference.update({
        'heading': updatedAnnouncement.heading,
        'body': updatedAnnouncement.body,
        'timeCreated': DateTime.now(),
      });

      log.d('Successfully updated announcement.');
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

      final AnnouncementViewModel announcementDetails = AnnouncementViewModel(
        id: announcementDoc.id,
        heading: announcementDoc['heading'],
        body: announcementDoc['body'],
        timeCreated: announcementDoc['timeCreated'].toDate(),
        author: announcementDoc['author'],
      );

      log.d('Successfully fetched announcement details.');
      return announcementDetails;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching announcement details.';
    }
  }

  Future<List<CommentViewModel>> fetchComments(String annId) async {
    try {
      final announcementsSnapshot = await _db.collectionGroup('announcements').where('id', isEqualTo: annId).get();

      if (announcementsSnapshot.docs.isEmpty) {
        throw 'Announcement not found.';
      }

      final doc = announcementsSnapshot.docs.first;

      final commentsSnapshot = await doc.reference.collection('comments').orderBy('timeCreated', descending: true).get();
      List<CommentViewModel> comments = [];

      if (commentsSnapshot.docs.isNotEmpty) {
        comments = commentsSnapshot.docs
            .map((doc) => CommentViewModel(
                  username: doc['username'],
                  text: doc['text'],
                  timeCreated: doc['timeCreated'].toDate(),
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
}
