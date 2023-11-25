import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AnnouncementModel {
  final String id;
  final String heading;
  final String? body;
  final DateTime? timeCreated;
  final CollectionReference? comments;
  final String formattedTime;

  AnnouncementModel({
    required this.id,
    required this.heading,
    this.body,
    this.timeCreated,
    this.comments,
  }) : formattedTime = DateFormat('MMMM dd, yyyy').format(timeCreated!);
}
