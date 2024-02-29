import 'dart:developer' as developer;

import '../utils/app_export.dart';

Timer? apiTimer;

bool isFieldEmpty(dynamic input) {
  return input == null ||
      input.toString().trim().isEmpty ||
      input.toString().trim().toLowerCase() == 'null';
}

String validString(dynamic input) {
  return isFieldEmpty(input) ? '' : input.toString().trim();
}

String validStringOrHyphen(dynamic input) {
  return !isFieldEmpty(input) ? validString(input) : '--';
}

int validInt(dynamic input) {
  return isFieldEmpty(input) ? 0 : (int.tryParse(input.toString()) ?? 0);
}

double validDouble(dynamic input) {
  return isFieldEmpty(input) ? 0.0 : (double.tryParse(input.toString()) ?? 0.0);
}

getDeviceWidth() {
  return applicationContext.mediaQuery.size.width;
}

getDeviceHeight() {
  return applicationContext.mediaQuery.size.height;
}

getDeviceStatusBarHeight() {
  return applicationContext.mediaQuery.padding.top;
}

Color getPrimaryColor() {
  return applicationContext.theme.primaryColor;
}

Color getDisabledColor() {
  return applicationContext.theme.disabledColor;
}

backUntilThenNewScreenAction(String nextPage, String untilPageRoute) async {
  hideKeyBoardFocus();
  // Get.offNamedUntil(nextPage, (route) => Get.currentRoute == untilPageRoute);
  Get.offNamedUntil(nextPage, (route) => route.isFirst);
}

backUntilAction(String untilPageRoute) async {
  hideKeyBoardFocus();
  Get.until((route) => Get.currentRoute == untilPageRoute);
}

backAction() async {
  hideKeyBoardFocus();
  Get.back();
}

Future<bool> delayNavigation(int delayDuration) async {
  bool isFinished =
      await Future.delayed(Duration(milliseconds: delayDuration), () {
    return true;
  });
  return isFinished;
}

apiDebounce(
  VoidCallback callback, {
  Duration duration = const Duration(
      milliseconds: AppConstants.doubleClickPreventDelayDuration),
}) {
  if (apiTimer != null) {
    apiTimer!.cancel();
  }

  apiTimer = Timer(duration, callback);
}

sessionTimedOut() async {
  // changeAppTheme();
  await getUserStorage().erase();
  await saveStorageValue(UserKeys.userLoggedInInt, 0);
  Get.offAllNamed(AppRoutes.loginRoute);
}

checkInternetConnection() async {
  bool hasInternet = await InternetConnection().hasInternetAccess;
  if (hasInternet) {
    return true;
  } else {
    showToast('No internet connection', toastType: ToastType.error);
    return false;
  }
}

hideKeyBoardFocus({bool hideOnlyKeyBoard = false, bool hideOnlyFocus = false}) {
  if (hideOnlyFocus) {
    FocusScope.of(applicationContext).unfocus();
    return;
  }

  if (hideOnlyKeyBoard) {
    FocusManager.instance.primaryFocus?.unfocus();
    return;
  }

  FocusManager.instance.primaryFocus?.unfocus();
  Get.focusScope!.unfocus();
}

showToast(dynamic msg, {ToastType toastType = ToastType.normal}) {
  msg = (msg.toString().trim().isEmpty ||
          msg.toString().trim().toLowerCase() == 'null')
      ? 'Something went wrong'
      : msg.toString();
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: toastType == ToastType.error
          ? Colors.deepOrange
          : toastType == ToastType.success
              ? Colors.green
              : Colors.blueGrey);
}

void appLog(
  dynamic msg, {
  LogType logType = LogType.normal,
  int logPreviousLine = 1,
  bool removeDot = false,
}) {
  if (!AppConstants.inProduction) {
    var stackTrace = StackTrace.current;
    final regexCodeLine = RegExp(r' (\(.*\))$');

    String logMessage = '';
    String lineInfo = '';

    if (logType == LogType.error) {
      lineInfo = validString(
          extractLineNumberAndPath(stackTrace, regexCodeLine, logPreviousLine));
    }

    switch (logType) {
      case LogType.request:
        logMessage = '\x1B[36m$msg\x1B[0m'; // Request log
        break;
      case LogType.response:
        logMessage = '\x1B[34m$msg\x1B[0m'; // Response log
        break;
      case LogType.error:
        logMessage = '\x1B[31m$msg\x1B[0m$lineInfo'; // Error log
        break;
      case LogType.json:
        logMessage = jsonEncode(msg); // JSON log
        break;
      default:
        lineInfo =
            validString(extractLineNumberAndPath(stackTrace, regexCodeLine, 1));
        logMessage = '\x1B[35m$msg\x1B[0m\t\t$lineInfo';
        break;
    }

    developer.log(logMessage);
  }
}

String extractLineNumberAndPath(
    StackTrace stackTrace, RegExp regexCodeLine, int logPreviousLine) {
  try {
    String rawMessage = stackTrace.toString().split('\n')[logPreviousLine];
    if (rawMessage.contains('package:') && rawMessage.contains('.dart:')) {
      RegExp regex = RegExp(r'#\d+\s+([\w.]+)\s+\(.*:(\d+:\d+)\)');
      Match? match = regex.firstMatch(rawMessage);
      if (match != null) {
        String methodName = match.group(1)!;
        String lineNumber = match.group(2)!;
        return '$methodName:$lineNumber';
      }
    } else {
      Match? match = regexCodeLine.firstMatch(rawMessage);
      if (match != null) {
        // String fileName =
        //     stackTrace.toString().split('\n')[0].split('(')[1].split(')')[0];
        // return ' (Line $capturedLine in $fileName)';
        String capturedLine = match.group(1) ?? '';
        return capturedLine;
      }
    }

    return '';
  } on Exception catch (e) {
    if (!AppConstants.inProduction) {
      developer.log(e.toString(), name: 'Extract Line Number EX');
    }
    return '';
  }
}

String makeCurrencyFormat(dynamic input,
    {bool isRupee = false, bool isShowZeroDigit = false}) {
  try {
    if (isRupee) {
      double number = double.tryParse(input.toString()) ?? 0.0;
      NumberFormat numberFormat = NumberFormat.currency(
        locale: 'HI',
        symbol: '₹',
      );

      String result = numberFormat.format(number);
      if (!isShowZeroDigit) {
        result = result.replaceAll('.00', '');
      }
      return result;
    } else {
      return input.toString().padLeft(2, '0');
    }
  } on Error catch (e) {
    handleException(e, 'Make Two Digits');
    return input.toString().padLeft(2, '0');
  } catch (error) {
    handleException(error, 'Make Two Digits');
    return input.toString().padLeft(2, '0');
  }
}

callOkDialog({
  String mTitle = 'Alert!',
  String mDescriptions = 'Are you sure, you want to exit?',
  String mBtn1Name = 'Yes',
  bool hideCloseIcon = true,
}) {
  AppAlertDialog.showAlertDialog(
    title: AppText(
      text: mTitle,
      size: 15,
      weight: FontWeight.bold,
    ),
    descriptions: AppText(
      text: mDescriptions,
      size: 13,
      weight: FontWeight.normal,
    ),
    btn1Name: mBtn1Name,
    isHideCloseIcon: hideCloseIcon,
    onPressedBtn1: () => [
      AppAlertDialog.hideAlertDialog(),
    ],
  );
}

callYesOrNoDialog({
  String mTitle = 'Alert!',
  String mDescriptions = 'Are you sure, you want to exit?',
  String mBtn1Name = 'Yes',
  String mBtn2Name = 'No',
  bool hideCloseIcon = true,
  required VoidCallback onPressedBtn1,
}) {
  AppAlertDialog.showAlertDialog(
    title: isFieldEmpty(mTitle)
        ? null
        : AppText(
            text: mTitle,
            size: 15,
            weight: FontWeight.bold,
          ),
    descriptions: AppText(
      text: mDescriptions,
      size: 13,
      weight: FontWeight.normal,
    ),
    btn1Name: mBtn1Name,
    btn2Name: mBtn2Name,
    isHideCloseIcon: hideCloseIcon,
    onPressedBtn1: onPressedBtn1,
    onPressedBtn2: () => AppAlertDialog.hideAlertDialog(),
  );
}

exitApplication() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

bool isListsAreEqual<T>(
    List<T> oldList, List<T> newList, String Function(T) getKey) {
  oldList.sort((a, b) => getKey(a).compareTo(getKey(b)));
  newList.sort((a, b) => getKey(a).compareTo(getKey(b)));

  if (oldList.length != newList.length) {
    return false;
  }

  for (int i = 0; i < oldList.length; i++) {
    if (getKey(oldList[i]) != getKey(newList[i])) {
      return false;
    }
  }

  return true;
}

Future<UserDataController> getUserDataController() async {
  UserDataController userDataController = Get.find<UserDataController>();
  if (isFieldEmpty(userDataController.firstName.value)) {
    await userDataController.loadUserData();
    //userDataController = Get.find<UserDataController>();
  }
  return userDataController;
}

// updateLocalUserData() async {
//   var data = Get.find<UserDataController>();
//   await data.loadUserData();
// }

setUserValueForCrashlytics() async {
  UserDataController userData = await getUserDataController();
  AppConstants.userName = userData.firstName.value;
  AppConstants.userAddress = userData.fullAddress.value;

  // crashlytics.setCustomKey('User_Name', 'User_Name');
  // crashlytics.setCustomKey('Mobile', 'Mobile');
  // crashlytics.setCustomKey('User_Id', 'User_Id');
}

handleException(dynamic error, String tag) {
  appLog(
    '$tag Ex : ${error.toString()}',
    logPreviousLine: 3,
    logType: LogType.error,
  );
}

String? isValidateMobile(String mobile) {
  final RegExp regex = RegExp(r'^([1-9][0-9]{9}$)');

  if (isFieldEmpty(mobile)) {
    return 'Enter mobile number';
  } else if (!regex.hasMatch(mobile)) {
    return 'Enter a mobile number';
  } else {
    return null;
  }
}

Color getOrderStatusColor(String status) {
  return status == 'Delivered'
      ? getPrimaryColor()
      : status == 'Cancelled'
          ? Colors.red
          : const Color(0xFFEDB73E);
}
