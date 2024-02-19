class UserKeys {
  //* Singleton logic
  UserKeys._privateConstructor();
  static final UserKeys _instance = UserKeys._privateConstructor();
  factory UserKeys() {
    return _instance;
  }

  //* Auth data
  static const String accessTokenStr = 'ats';
  static const String userLoggedInInt = 'uli_i';
  static const String userMobileStr = 'ums';
  static const String userVerificationIdStr = 'uvi_s';
  static const String firebaseIdStr = 'fbi_s';
}
