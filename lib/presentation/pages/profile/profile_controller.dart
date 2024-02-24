import '../../../../../app/utils/app_export.dart';

class ProfileController extends GetxController {
  var title = 'Profile'.obs,
      version = ''.obs,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
  }

  @override
  void onReady() {
    super.onReady();
    version.value = 'v ${AppConstants.appVersionName}';
    getSharedValue();
  }

  @override
  void onClose() {
    apiTimer?.cancel();
    scrollController.dispose();
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      // Api Call
    }
  }

  editAction() {
    showToast('Edit Action');
  }

  yourInfoAction(int id) {
    switch (id) {
      case 1: // Order History
        showToast('Order History Action');
        break;
      case 2: // Address Book
        showToast('Address Book Action');
        break;
    }
  }

  otherInfoAction(int id) {
    switch (id) {
      case 1: // Terms Action
        showToast('Terms Action');
        break;
      case 2: // Privacy Action
        showToast('Privacy Action');
        break;
      case 3: // About Action
        showToast('About Action');
        break;
    }
  }

  logoutAction() {
    showToast('Logout Action');
  }

  // submitAction() async => apiDebounce(() async {
  //       hideKeyBoardFocus();
  //       navigatePage(AppConstants.paymentDetailsPage);
  //     });
}
