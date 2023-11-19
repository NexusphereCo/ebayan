class UserViewModel {
  final String id;
  final String userType;
  // personal information
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final String address;
  final String birthDate;
  // barangay information
  final String? municipality;
  final String? barangayAssociated;
  final bool? isApproved;
  final String? proofOfOfficial;
  // login credentials
  final String username;

  UserViewModel({
    required this.id,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.birthDate,
    this.municipality,
    this.barangayAssociated,
    this.isApproved,
    this.proofOfOfficial,
    required this.username,
  });

  factory UserViewModel.map(String userId, Map<String, dynamic> data) {
    return UserViewModel(
      id: userId,
      userType: data['userType'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      contactNumber: data['contactNumber'],
      address: data['address'],
      birthDate: data['birthDate'],
      municipality: data['municipality'],
      barangayAssociated: data['barangayAssociated'],
      isApproved: data['isApproved'],
      proofOfOfficial: data['proofOfOfficial'],
      username: data['username'],
    );
  }
}
