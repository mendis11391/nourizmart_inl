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
  static const String profileRoute = '/profile';
  static const String notificationsListRoute = '/notification';
  static const String productListRoute = '/productList';
  static const String viewCartRoute = '/viewCart';
  static const String orderListRoute = '/orderList';
  static const String orderDetailsRoute = '/orderDetails';
  static const String addressListRoute = '/addressList';
  static const String addAddressRoute = '/addAddress';
  static const String paymentRoute = '/payment';
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
    case AppConstants.profilePage:
      Get.toNamed(AppRoutes.profileRoute);
      break;
    case AppConstants.notificationsListPage:
      Get.toNamed(AppRoutes.notificationsListRoute);
      break;
    case AppConstants.productListPage:
      Get.toNamed(AppRoutes.productListRoute);
      break;
    case AppConstants.viewCartPage:
      Get.toNamed(AppRoutes.viewCartRoute);
      break;
    case AppConstants.orderListPage:
      Get.toNamed(AppRoutes.orderListRoute);
      break;
    case AppConstants.orderDetailsPage:
      Get.toNamed(AppRoutes.orderDetailsRoute);
      break;
    case AppConstants.addressListPage:
      Get.toNamed(AppRoutes.addressListRoute);
      break;
    case AppConstants.addAddressPage:
      Get.toNamed(AppRoutes.addAddressRoute);
      break;
    case AppConstants.paymentPage:
      Get.toNamed(AppRoutes.paymentRoute);
      break;

    default:
      showToast('Need to add page in App Route');
      break;
  }
}
