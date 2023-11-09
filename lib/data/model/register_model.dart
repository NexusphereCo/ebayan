// this is used onRegister event
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterOfficialModel {
  // personal information
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final String address;
  final String birthDate;
  // barangay information
  final DocumentReference municipality;
  final DocumentReference barangayAssociated;
  final bool isApproved;
  final String proofOfOfficial;
  // login credentials
  final String username;
  final String password;

  RegisterOfficialModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.birthDate,
    required this.municipality,
    required this.barangayAssociated,
    required this.isApproved,
    required this.proofOfOfficial,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'address': address,
      'birthDate': birthDate,
      'municipality': municipality.id,
      'barangayAssociated': barangayAssociated.id,
      'isApproved': isApproved,
      'proofOfOfficial': proofOfOfficial,
      'username': username,
      'password': password,
    };
  }
}
