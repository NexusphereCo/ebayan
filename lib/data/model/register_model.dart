// this is used onRegister event
import 'dart:io';

class RegisterOfficialModel {
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
      'municipality': municipality,
      'barangayAssociated': barangayAssociated,
      'isApproved': isApproved,
      'proofOfOfficial': 'DOC_${lastName.toUpperCase()}_${DateTime.timestamp()}.pdf',
      'username': email,
    };
  }
}

class RegisterResidentModel {
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

  RegisterResidentModel({
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

  Map<String, dynamic> toJson() {
    return {
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
