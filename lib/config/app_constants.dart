import 'dart:io';

class AppConstants {
  AppConstants._privateConstructor();
  static final AppConstants _instance = AppConstants._privateConstructor();
  factory AppConstants() {
    return _instance;
  }

  static const bool inProduction = bool.fromEnvironment('dart.vm.product');
  static bool isAndroid = Platform.isAndroid;
  static bool isIOS = Platform.isIOS;
  static const int appTransitionDuration = 300;
  static const int appDelayDuration = 500;
  static const int appMediumDelayDuration = 200;
  static const int appShortDelayDuration = 100;
  static const int doubleClickPreventDelayDuration = appTransitionDuration;
  static const appStoreUrl = '';
  static const playStoreUrl = '';
}
