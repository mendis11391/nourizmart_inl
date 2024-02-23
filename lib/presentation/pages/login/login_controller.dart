import '../../../../../app/utils/app_export.dart';

class LoginController extends GetxController {
  var title = 'Login'.obs,
      mob = ''.obs,
      isBtnEnable = false.obs,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late ScrollController scrollController;
  final loginFormKey = GlobalKey<FormState>();
  late TextEditingController mobController;
  late FocusNode mobFocusNode;
  late FirebaseAuthRepo authRepo;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    mobController = TextEditingController();
    mobFocusNode = FocusNode();
    authRepo = Get.find<FirebaseAuthRepo>();
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
    mobController.dispose();
    mobFocusNode.dispose();
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      // Api Call
    }
  }

  get getMobile => mob.value;

  clearText() {
    onChangedMobile('');
    mobController.clear();
  }

  onChangedMobile(String input) => mob.value = input;

  submitAction() async => apiDebounce(() async {
        String mobile = validString(mobController.text);
        hideKeyBoardFocus();
        AppLoader.showLoadingDialog();
        bool isSuccess = await authRepo.loginWithPhone(mobile);
        if (isSuccess) {
          navigatePage(AppConstants.otpPage);
        }
      });
}
