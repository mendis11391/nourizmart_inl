import '../app/utils/app_export.dart';

class NourishMartApp extends StatelessWidget {
  const NourishMartApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nourish Mart',
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(
          milliseconds: AppConstants.appTransitionDuration,
        ),
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: AppColors.appThemeColor,
          primaryColor: AppColors.appThemeColor,
          disabledColor: AppColors.appThemeColor.shade200,
          fontFamily: 'inter',
          scaffoldBackgroundColor: AppColors.appBgGray,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: AppRoutes.homeRoute,
        // initialRoute: AppConstants.loginStatus == 1
        //     ? AppRoutes.homeRoute
        //     : AppRoutes.loginRoute,
        getPages: RouteGenerator.routes,
        unknownRoute: RouteGenerator.unknownRoute,
      );
}
