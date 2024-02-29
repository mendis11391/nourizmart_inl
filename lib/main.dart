import 'package:nourish_mart/presentation/pages/splash/splash_page.dart';

import 'app/utils/app_export.dart';
import 'presentation/nourish_mart_app.dart';

final navigatorKey = GlobalKey<NavigatorState>();
BuildContext applicationContext = navigatorKey.currentContext!;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initServices();
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(
          onInitializationComplete: () {
            runApp(const NourishMartApp());
          },
        ),
      ),
    );
  } /* , (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack) */);
}

initServices() async {
  try {
    // WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init('USER_STORAGE');
    await initUserStorage();
    Get.put(DioServiceImpl(), permanent: true);
    Get.put(AppRepoImpl(), permanent: true);
    Get.put(UserDataController(), permanent: true);
    Get.put(FirebaseAuthRepo(), permanent: true);
  } catch (err) {
    handleException(err, 'Main Init Services');
  }
}
