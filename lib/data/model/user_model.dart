import 'dart:io';

import 'package:path/path.dart' as path;

enum UserType { official, resident }

class UserModel {
  final UserType userType;
  // personal information
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final String address;
  final String birthDate;
  // barangay information
  // (nullable for residents)
  final String? barangayAssociated;
  final bool? isApproved;
  final File? proofOfOfficial;
  // login credentials
  final String username;
  final String password;

  UserModel({
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.birthDate,
    this.barangayAssociated,
    this.isApproved,
    this.proofOfOfficial,
    required this.username,
    required this.password,
  });

  /// This will be used to be stored in the firestore
  /// notice that password is not included because it is
  /// stored in the firebase auth.
  /// returns a [Map] json.
  Map<String, dynamic> toJson() {
    switch (userType) {
      case UserType.resident:
        return {
          'userType': 'RESIDENT',
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'contactNumber': contactNumber,
          'address': address,
          'birthDate': birthDate,
          'barangayAssociated': barangayAssociated,
          'username': email,
        };
      case UserType.official:
        String docFileName = 'DOC_${lastName.toUpperCase()}_${DateTime.timestamp()}${path.extension(proofOfOfficial!.path)}';
        return {
          'userType': 'OFFICIAL',
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'contactNumber': contactNumber,
          'address': address,
          'birthDate': birthDate,
          'barangayAssociated': barangayAssociated,
          'isApproved': isApproved,
          'proofOfOfficial': docFileName,
          'username': email,
        };

      default:
        throw 'Model is not valid';
    }
  }
}

class UserUpdateModel {
  // personal information
  final String firstName;
  final String lastName;
  final String birthDate;
  final String contactNumber;
  final String address;

  UserUpdateModel({
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.address,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'contactNumber': contactNumber,
      'address': address,
    };
  }
}
