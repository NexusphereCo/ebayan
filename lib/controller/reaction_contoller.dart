import 'package:ebayan/data/viewmodel/comment_view_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class ReactionController {
  final Logger log = Logger();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> createComment(String annId, String text) async {
    try {
      final announcementSnapshot = await _db //
          .collectionGroup('announcements')
          .where('id', isEqualTo: annId)
          .get();

      if (announcementSnapshot.docs.isEmpty) {
        throw 'Announcement not found.';
      }

      final announcementDoc = announcementSnapshot.docs.first;

      final commentRef = await announcementDoc //
          .reference
          .collection('comments')
          .add({
        'text': text,
        'timeCreated': DateTime.now(),
        'userId': user!.uid,
      });

      await commentRef.update({'id': commentRef.id});

      log.d('Successfully created comment.');
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while creating the comment.';
    }
  }

  Future<List<CommentViewModel>> fetchComments(String annId) async {
    try {
      final announcementsSnapshot = await _db //
          .collectionGroup('announcements')
          .where('id', isEqualTo: annId)
          .get();

      if (announcementsSnapshot.docs.isEmpty) {
        throw 'Announcement not found.';
      }

      final doc = announcementsSnapshot.docs.first;

      final commentsSnapshot = await doc //
          .reference
          .collection('comments')
          .orderBy('timeCreated', descending: true)
          .get();

      List<CommentViewModel> comments = [];

      if (commentsSnapshot.docs.isNotEmpty) {
        comments = await Future.wait(
          commentsSnapshot.docs.map(
            (doc) async {
              final userId = doc['userId'];
              final username = await fetchUserName(userId);

              return CommentViewModel(
                text: doc['text'],
                timeCreated: doc['timeCreated'].toDate(),
                userId: userId,
                username: username,
              );
            },
          ),
        );
      }

      log.d('Successfully fetched comments: $comments');
      return comments;
    } catch (err) {
      log.e('An error occurred: $err');
      throw 'An error occurred while fetching comments.';
    }
  }

  Future<String> fetchUserName(String authorId) async {
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

  Future<void> setReaction(String annId, bool thumbsUp, bool thumbsDown) async {
    // 1. Check first if the user has already reacted to the post
    // 2. If the user has none, then create a new doc.
    // If the user has, then just update the values
    final announcementSnapshot = await _db //
        .collectionGroup('announcements')
        .where('id', isEqualTo: annId)
        .get();

    if (announcementSnapshot.docs.isEmpty) {
      throw 'Announcement not found.';
    }

    final reactionsCollection = announcementSnapshot //
        .docs
        .first
        .reference
        .collection('reactions');

    final existingReactionSnapshot = await reactionsCollection.where('userId', isEqualTo: user!.uid).get();

    if (existingReactionSnapshot.docs.isNotEmpty) {
      // User has already reacted, update the values
      final existingReactionDoc = existingReactionSnapshot.docs.first;

      if (!thumbsUp && !thumbsDown) {
        existingReactionDoc.reference.delete();
      } else {
        await existingReactionDoc.reference.update({
          'isLiked': thumbsUp,
          'isDisliked': thumbsDown,
        });
      }
    } else {
      // User has not reacted yet, create a new doc
      await reactionsCollection.add({
        'isLiked': thumbsUp,
        'isDisliked': thumbsDown,
        'userId': user!.uid,
      });
    }
  }

  Future<bool?> fetchReaction(String annId) async {
    // 1. Check first if the user has already reacted to the post
    // 2. If the user has none, then create a new doc.
    // If the user has, then just update the values
    final announcementSnapshot = await _db //
        .collectionGroup('announcements')
        .where('id', isEqualTo: annId)
        .get();

    if (announcementSnapshot.docs.isEmpty) {
      throw 'Announcement not found.';
    }

    final reactionsCollection = announcementSnapshot //
        .docs
        .first
        .reference
        .collection('reactions');

    final existingReactionSnapshot = await reactionsCollection.where('userId', isEqualTo: user!.uid).get();

    if (existingReactionSnapshot.docs.isNotEmpty) {
      // User has already reacted, determine if they liked or not
      final existingReactionDoc = existingReactionSnapshot.docs.first;
      bool isLiked = await existingReactionDoc.data()['isLiked'];
      return isLiked;
    }
    // User has not reacted yet, create a new doc
    return null;
  }
}
