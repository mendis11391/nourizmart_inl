import 'app_route_export.dart';

class AppRoutes {
  //* Singleton logic
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  factory AppRoutes() {
    return _instance;
  }

  //* Pages Route *//
  static const String initial = '/splash';
  static const String notFound = '/notFound';
  static const String loginRoute = '/login';
  static const String otpRoute = '/otp';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
}

/*
~ It switches to different pages based on the value of pageIdx, 
*/
navigatePage(int pageIdx, {dynamic bundle}) {
  hideKeyBoardFocus();
  switch (pageIdx) {
    case AppConstants.loginPage:
      Get.offAllNamed(AppRoutes.loginRoute);
      break;
    case AppConstants.otpPage:
      Get.toNamed(AppRoutes.otpRoute);
      break;
    case AppConstants.registerPage:
      Get.offAndToNamed(AppRoutes.registerRoute);
      break;
    case AppConstants.homePage:
      Get.offAllNamed(AppRoutes.homeRoute);
      break;

    default:
      showToast('Need to add page in App Route');
      break;
  }
}
