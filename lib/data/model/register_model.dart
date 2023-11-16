// this is used onRegister event
import 'dart:io';

class OfficialModel {
  final String userType;
  // personal information
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final String address;
  final String birthDate;
  // barangay information
  final String municipality;
  final String barangayAssociated;
  final bool isApproved;
  final File proofOfOfficial;
  // login credentials
  final String username;
  final String password;

  OfficialModel({
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
    required this.userType,
  });

  /// This will be used to be stored in the firestore
  /// notice that password is not included because it is
  /// stored in the firebase auth.
  /// returns a [Map] json.
  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'address': address,
      'birthDate': birthDate,
      'municipality': municipality,
      'barangayAssociated': barangayAssociated,
      'isApproved': isApproved,
      'proofOfOfficial': 'DOC_${lastName.toUpperCase()}_${DateTime.timestamp()}.pdf',
      'username': email,
    };
  }
}

class ResidentModel {
  final String userType;
  // personal information
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final String address;
  final String birthDate;
  final String? barangayAssociated;
  // login credentials
  final String username;
  final String password;

  ResidentModel({
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.birthDate,
    required this.barangayAssociated,
    required this.username,
    required this.password,
  });

  /// This will be used to be stored in the firestore
  /// notice that password is not included because it is
  /// stored in the firebase auth.
  /// returns a [Map] json.
  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'address': address,
      'birthDate': birthDate,
      'barangayAssociated': barangayAssociated,
      'username': email,
    };
  }
}
