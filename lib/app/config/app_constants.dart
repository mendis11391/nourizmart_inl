import 'dart:io';

class AppConstants {
  AppConstants._privateConstructor();
  static final AppConstants _instance = AppConstants._privateConstructor();
  factory AppConstants() {
    return _instance;
  }
  static const String authorizationHeader = 'Authorization';
  static const String bearer = 'Bearer ';
  static const String mobileHeader = 'is-mobile';

  static const bool inProduction = bool.fromEnvironment('dart.vm.product');
  static bool isAndroid = Platform.isAndroid;
  static bool isIOS = Platform.isIOS;
  static const int appTransitionDuration = 300;
  static const int appDelayDuration = 500;
  static const int searchDelayDuration = 900;
  static const int appMediumDelayDuration = 200;
  static const int appShortDelayDuration = 100;
  static const int appZeroDuration = 0;
  static const int appResetLoadingDuration = appDelayDuration;
  static const int doubleClickPreventDelayDuration = appTransitionDuration;
  static int loginStatus = 0;

  static const int splashPage = 101;
  static const int loginPage = 102;
  static const int otpPage = 103;
  static const int registerPage = 104;
  static const int homePage = 105;
}
