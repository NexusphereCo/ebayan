class Validation {
  Validation._();

  static const String missingField = 'This field is required.';
  static const String invalidEmail = 'This email address is not valid.';
  static const String invalidPhoneNumber = 'This phone number not invalid.';
  static const String userNotFound = 'This account does not exist.';
  static const String invalidLoginCred = 'Invalid login credentials.';
  static const String tooManyReq = 'Too many request. Try again later.';
  static const String wrongPassword = 'The password is incorrect.';
  static const String mismatchPassword = 'The password does not match.';
  static const String requiredMinPassword = 'The password requires a minimum of 6 characters.';
  static const String minLengthBrgyCode = 'The code requires a minimum of 5 digits.';
  static const String invalidBrgyCode = 'This code is invalid. Try a different code.';
}
