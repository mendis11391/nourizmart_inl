class AppStrings {
  AppStrings._privateConstructor();
  static final AppStrings _instance = AppStrings._privateConstructor();
  factory AppStrings() {
    return _instance;
  }

  //* Application Title *//
  /// Android: it is used in Recent apps,
  /// iOS: it is used in App switcher or CFBundleDisplayName in Info.plist
  static const String applicationTitle = 'Smart OPS';

  //* AppBar Title *//
  static const String appBarHome = 'Product Page';

  //* Hint message *//
  // static const String hintEmailAddress = 'Email address';
  // static const String hintPassword = 'Password';
  static const String hintSearch = 'Search';

  //* Dia Error Message *//
  static const String errorDiaUnknown = 'UnKnown Exception!!!';
  static const String errorDiaEx = 'Dio Exception: ';
  static const String errorDiaReqCancel = 'Request cancellation';
  static const String errorDiaConnectionTimeOut = 'Connection timed out';
  static const String errorDiaResTimeOut = 'Response timeout';
  static const String errorDiaReqTimeOut = 'Request timed out';
  static const String errorDiaNoInternet = 'No internet connection';
  static const String errorDiaWentWrong = 'Something went wrong';
  static const String errorDiaBadReq = 'Bad request error';
  static const String errorDiaUnAuth = 'Unauthorized';
  static const String errorDiaServerRefuses = 'The server refuses to execute';
  static const String errorDiaPageNotFound = 'Page not found';
  static const String errorDiaReqNotAllowed = 'Request method not allowed';
  static const String errorDiaInternalServer = 'Internal server error';
  static const String errorDiaBadGateway = 'Bad gateway';
  static const String errorDiaNoService = 'Service unavailable';
  static const String errorDiaNoHttp = 'HTTP protocol request is not supported';
  static const String errorDiaUnknownRes = 'Unknown response mistake';
  static const String errorDiaResWentWrong = 'Oops response went wrong';

  //* App Error Message *//
  static const String errorNetwork = 'No Internet';
  static const String errorNetworkMsg = 'Please check your internet connection';
  static const String errorEmailEmpty = 'Enter an email';
  static const String errorEmailValid = 'Enter a valid email';
  static const String errorPasswordEmpty = 'Enter a password';
  static const String errorPasswordValid = 'Enter a valid password';
  static const String errorDataNotFound = 'Data not found';
  static const String errorEmptyAccessToken =
      'Service unavailable, Please try again later';

  //* Dialog message *//
  static const String diaBackAgain = 'Press back button again to exit';
  static const String diaLogoutMsg = 'Are you sure you want to logout?';
  static const String diaLogout = 'Logout';
  static const String diaBtnYes = 'Yes';
  static const String diaBtnNo = 'No';

  static const String diaBtnOk = 'OK';

  //* Button message *//
  static const String btnLogin = 'Login';
  static const String btnOk = 'Ok';

  //* Normal message *//
  static const String email = 'Email';
  static const String password = 'Password';
}
