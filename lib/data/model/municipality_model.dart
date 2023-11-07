import 'package:cloud_firestore/cloud_firestore.dart';

class MunicipalityModel {
  final String municipality;
  final int zipCode;
  final CollectionReference? barangays;

  MunicipalityModel({
    required this.municipality,
    required this.zipCode,
    this.barangays,
  });
}
