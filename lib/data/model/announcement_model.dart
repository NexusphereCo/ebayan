import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  final String heading;
  final String body;
  final Timestamp timeCreated;
  final CollectionReference? comments;

  AnnouncementModel({required this.heading, required this.body, required this.timeCreated, this.comments});
}
