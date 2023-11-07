import 'package:cloud_firestore/cloud_firestore.dart';

class BarangayModel {
  final String? adminId;
  final int code;
  final String name;
  final List<DocumentReference>? residentIds;
  final CollectionReference? announcements;

  BarangayModel({
    this.adminId,
    required this.code,
    required this.name,
    this.residentIds,
    this.announcements,
  });
}
