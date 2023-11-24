import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  final String id;
  final String heading;
  final String? body;
  final DateTime? timeCreated;
  final CollectionReference? comments;

  AnnouncementModel({
    required this.id,
    required this.heading,
    this.body,
    this.timeCreated,
    this.comments,
  });
}
