import '../../../../app/utils/app_export.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    super.key,
    required this.onInitializationComplete,
  });

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  bool isAllowAllPermission = false,
      isAllowNextPage = false,
      isErrorPermissionDia = false,
      permanentlyDenied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBuildVersion();
      startCountdownTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () async {
        // await invokeAppPermission();
        // onResumeAction();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: splashAnimation(),
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light, // Brightness.light,
              statusBarIconBrightness: Brightness.light),
        ),
      ),
    );
  }

  getBuildVersion() async {
    try {
      var serverName = Env.baseurl == Env.stagingServer ? 'Dev' : '';
      String yamlString = await rootBundle.loadString('pubspec.yaml');
      var lines = yamlString.split('\n');
      String versionLine =
          lines.firstWhere((line) => line.trim().startsWith('version:'));
      String version = versionLine.trim().split('version:').last.trim();
      String versionName = version.split('+').first;
      String buildNumber = version.split('+').last;
      // appLog('versionName : $versionName, buildNumber : $buildNumber');
      AppConstants.appVersionName = '$versionName $serverName';
      AppConstants.appBuildNumber = validInt(buildNumber);
      // if (Env.baseurl == Env.productionServer) {
      //   invokeApiCall();
      // } else {
      //   isSuccessApiVersion = true;
      //   nextPage();
      // }
    } catch (e) {
      appLog('Unable to get App version : $e', logType: LogType.error);
    }
  }

  startCountdownTimer() async {
    if (await delayNavigation(4000)) {
      isAllowNextPage = true;
      moveToNextPage();
    }
  }

  moveToNextPage() async {
    // if (isAllowAllPermission && isAllowNextPage) {
    isAllowAllPermission = false;
    isAllowNextPage = false;
    await setUserValueForCrashlytics();
    int loginStatusInt =
        validInt(await getStorageValue(UserKeys.userLoggedInInt));
    AppConstants.loginStatus = loginStatusInt;
    widget.onInitializationComplete();
    // }
  }

  // onResumeAction() async {
  //   // if (isAllowAllPermission) {
  //   //   moveToNextPage();
  //   // } else if (!permanentlyDenied && !isErrorPermissionDia) {
  //   //   await invokeAppPermission();
  //   // } else if (permanentlyDenied && !isErrorPermissionDia) {
  //   //   appLog('Show exit permission dialog from onResume');
  //   //   showExitDialog();
  //   // } else if (permanentlyDenied && isErrorPermissionDia) {
  //   //   appLog('safe skip for exit permission dialog');
  //   // } else {
  //   //   appLog('Something wrong in permission logic');
  //   // }
  // }

  // Future<void> invokeAppPermission() async {
  //   var permissionData = await checkAppPermission();
  //   isAllowAllPermission = permissionData.isAllowed;
  //   permanentlyDenied = permissionData.isPermanentlyDenied;
  //   if (permanentlyDenied && !isErrorPermissionDia) {
  //     appLog('Show exit permission dialog from invoke App Permission');
  //     showExitDialog();
  //   }
  // }

  // void showExitDialog() {
  //   isErrorPermissionDia = true;
  //   AppAlertDialog.showAlertDialog(
  //     title: AppText(
  //       text: 'Need Permissions',
  //       size: 15,
  //       weight: FontWeight.bold,
  //     ),
  //     descriptions: AppText(
  //       text:
  //           'This app needs all the permissions to be enabled. You can grant them in app settings.", "All the permissions should be granted',
  //       size: 13,
  //       weight: FontWeight.normal,
  //     ),
  //     btn1Name: 'Exit',
  //     isHideCloseIcon: true,
  //     onPressedBtn1: () => [
  //       AppAlertDialog.hideAlertDialog(),
  //       exitApplication(),
  //     ],
  //   );
  // }
}

Widget splashAnimation() => Center(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(200)),
        ),
        child: AppImage(
          assetName: AppResource.gifSplash,
          width: getSize(200),
          height: getSize(200),
        ),
      ),
    );
