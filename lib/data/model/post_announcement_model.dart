import 'package:cloud_firestore/cloud_firestore.dart';

class PostAnnouncementModel {
  final String? id;
  final String heading;
  final String body;
  final DateTime? timeCreated;
  final String? author;
  final CollectionReference? comments;

  PostAnnouncementModel({
    this.id,
    required this.heading,
    required this.body,
    this.timeCreated,
    this.author,
    this.comments,
  });
}
