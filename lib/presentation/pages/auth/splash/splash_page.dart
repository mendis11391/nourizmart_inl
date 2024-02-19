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
    // appLog('initState');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // appLog('All ui are rendered');
      startCountdownTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    // appLog('Start build');
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

  startCountdownTimer() async {
    if (await delayNavigation(3500)) {
      // appLog('Finish Count down');
      isAllowNextPage = true;
      moveToNextPage();
    }
  }

  moveToNextPage() async {
    // if (isAllowAllPermission && isAllowNextPage) {
    isAllowAllPermission = false;
    isAllowNextPage = false;
    int loginStatusInt =
        validInt(await getStorageValue(UserKeys.userLoggedInInt));
    AppConstants.loginStatus = loginStatusInt;
    widget.onInitializationComplete();
    // }
  }

  // onResumeAction() async {
  //   appLog('onResumeAction');
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
          assetName: AppResource.icGifSplash,
          width: getSize(200),
          height: getSize(200),
        ),
      ),
    );
