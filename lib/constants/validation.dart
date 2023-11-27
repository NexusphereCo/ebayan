class Validation {
  Validation._();

  static const String missingField = 'This field is required.';
  static const String noAccount = 'There is no account associated with that email!';
  static const String invalidEmail = 'This email address is not valid.';
  static const String invalidPhoneNumber = 'This phone number not invalid.';
  static const String userDisabled = 'This account is disabled.';
  static const String userNotFound = 'This account does not exist.';
  static const String invalidLoginCred = 'Invalid login credentials.';
  static const String tooManyReq = 'Too many request. Try again later.';
  static const String wrongPassword = 'The password is incorrect.';
  static const String weakPassword = 'This password is not strong enough.';
  static const String mismatchPassword = 'The password does not match.';
  static const String requiredMinPassword = 'The password requires a minimum of 6 characters.';
  static const String minLengthBrgyCode = 'The code requires a minimum of 5 digits.';
  static const String invalidBrgyCode = 'This code is invalid. Try a different code.';
  static const String networkFail = 'Unable to perform this request due to a network issue. Try again later.';
  static const String emailAlreadyInUse = 'This email address is already in use.';
  static const String requiresRecentLogin = 'For security reasons, please sign in again to continue.';
  static const String accountOnProcess = 'Your account is still being processed for approval.';
}
