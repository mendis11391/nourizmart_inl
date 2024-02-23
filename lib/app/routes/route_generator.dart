import 'app_route_export.dart';

class RouteGenerator {
  //* Singleton logic
  RouteGenerator._privateConstructor();
  static final RouteGenerator _instance = RouteGenerator._privateConstructor();
  factory RouteGenerator() {
    return _instance;
  }

  static final routes = [
    GetPage(
      name: AppRoutes.loginRoute,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.otpRoute,
      page: () => const OtpPage(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.registerRoute,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.homeRoute,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.profileRoute,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.notificationsListRoute,
      page: () => const NotificationsListPage(),
      binding: NotificationsListBinding(),
    ),
    GetPage(
      name: AppRoutes.productListRoute,
      page: () => const ProductListPage(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: AppRoutes.viewCartRoute,
      page: () => const ViewCartPage(),
      binding: ViewCartBinding(),
    ),
    GetPage(
      name: AppRoutes.orderListRoute,
      page: () => const OrderListPage(),
      binding: OrderListBinding(),
    ),
    GetPage(
      name: AppRoutes.orderDetailsRoute,
      page: () => const OrderDetailsPage(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.addressListRoute,
      page: () => const AddressListPage(),
      binding: AddressListBinding(),
    ),
    GetPage(
      name: AppRoutes.addAddressRoute,
      page: () => const AddAddressPage(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: AppRoutes.paymentRoute,
      page: () => const PaymentPage(),
      binding: PaymentBinding(),
    ),
  ];

  //* Unknown Pages Route *//
  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const NotFoundPage(),
  );
}

class MyMiddleware extends GetMiddleware {
  //* Singleton logic
  MyMiddleware._privateConstructor();
  static final MyMiddleware _instance = MyMiddleware._privateConstructor();
  factory MyMiddleware() {
    return _instance;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    appLog(page?.name);
    return super.onPageCalled(page);
  }
}
