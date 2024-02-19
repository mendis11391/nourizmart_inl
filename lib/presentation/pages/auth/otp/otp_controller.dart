import '../../../../../app/utils/app_export.dart';

class OtpController extends GetxController {
  var title = 'Verify Code'.obs,
      verificationId = '',
      appSignature = ''.obs,
      otpCode = ''.obs,
      mobile = ''.obs,
      maxSeconds = 120.obs,
      currentSeconds = 0.obs,
      isBtnEnable = false.obs,
      isResentBtnEnable = false.obs,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late ScrollController scrollController;
  late TextEditingController otpController;
  late FirebaseAuthRepo authRepo;
  late AppRepo appRepo;
  Timer? clockTime;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    otpController = TextEditingController();
    authRepo = Get.find<FirebaseAuthRepo>();
    appRepo = AppRepoImpl();
  }

  @override
  void onReady() {
    super.onReady();
    getSharedValue();
  }

  @override
  void onClose() {
    apiTimer?.cancel();
    scrollController.dispose();
    otpController.dispose();
    clockTime?.cancel();
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      startTimer();
      verificationId = await getStorageValue(UserKeys.userVerificationIdStr);
      mobile.value = await getStorageValue(UserKeys.userMobileStr);
    }
  }

  startTimer() {
    const duration = Duration(seconds: 1);
    clockTime = Timer.periodic(duration, (Timer timer) {
      currentSeconds.value = timer.tick;
      if (timer.tick >= maxSeconds.value) {
        isBtnEnable.value = false;
        isResentBtnEnable.value = true;
        timer.cancel();
      }
    });
  }

  String get getTimerText {
    const secondsPerMinute = 60;
    final secondsLeft = maxSeconds.value - currentSeconds.value;

    final formattedMinutesLeft =
        (secondsLeft ~/ secondsPerMinute).toString().padLeft(2, '0');
    final formattedSecondsLeft =
        (secondsLeft % secondsPerMinute).toString().padLeft(2, '0');

    return '$formattedMinutesLeft : $formattedSecondsLeft';
  }

  submitAction() async => apiDebounce(() async {
        hideKeyBoardFocus();
        AppLoader.showLoadingDialog();
        int verified = await authRepo.verifyOtp(verificationId, otpCode.value);
        // verified = 1, notVerified = 0, exception = -1
        if (verified >= 0) {
          apiGetUserExists();
        }else{
          otpCode.value = '';
          otpController.clear();
        }
      });

  resendAction() async => apiDebounce(() async {
        hideKeyBoardFocus();
        AppLoader.showLoadingDialog();
        String mobile = await getStorageValue(UserKeys.userMobileStr);
        bool isSuccess = await authRepo.loginWithPhone(mobile);
        if (isSuccess) {
          otpCode.value = '';
          otpController.clear();
          isBtnEnable.value = false;
          isResentBtnEnable.value = false;
          startTimer();
        }
      });

  apiGetUserExists() async {
    try {
      String firebaseId = await getStorageValue(UserKeys.firebaseIdStr);
      var response = await appRepo.checkIfUserExists(firebaseId);
      await resetLoading();
      if (response.exists ?? false) {
        navigatePage(AppConstants.homePage);
      } else {
        navigatePage(AppConstants.registerPage);
      }
    } catch (ex) {
      handleApiException(ex, 'User Exists');
    }
  }

  handleApiException(dynamic error, String tag) async {
    showToast(validString(error), toastType: ToastType.error);
    await resetLoading();
  }

  resetLoading() async {
    await AppLoader.hideLoadingDialog();
  }
}
