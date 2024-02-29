import '../../../../../app/utils/app_export.dart';
import 'bs/edit_profile_bs.dart';

class ProfileController extends GetxController {
  var title = 'Profile'.obs,
      version = ''.obs,
      firstName = 'First Name'.obs,
      lastName = 'Last Name'.obs,
      mobile = 'Mobile'.obs,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late ScrollController scrollController;
  late FirebaseAuthRepo authRepo;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
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
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    version.value = 'v ${AppConstants.appVersionName}';
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      UserDataController userData = await getUserDataController();
      firstName.value = userData.firstName.value;
      lastName.value = userData.lastName.value;
      mobile.value = userData.mobile.value;
    }
  }

  editAction() {
    hideKeyBoardFocus();
    Get.bottomSheet(
      const EditProfileBottomSheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  yourInfoAction(int id) async {
    switch (id) {
      case 1: // Order History
        navigatePage(AppConstants.orderListPage);
        break;
      case 2: // Address Book
        await saveStorageValue(UserKeys.whereFromAddressStr, 'profile');
        navigatePage(AppConstants.addressListPage);
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

  logoutAction() async {
    callYesOrNoDialog(
        mTitle: '',
        mDescriptions: 'Are you sure you want to logout?',
        mBtn1Name: 'Logout',
        mBtn2Name: 'Cancel',
        onPressedBtn1: () async {
          await AppLoader.showLoadingDialog();
          bool isLogout = await authRepo.signOut();
          if (isLogout) {
            await AppLoader.hideLoadingDialog();
            showToast('User logout successfully');
            await sessionTimedOut();
          }
        });
  }

  // submitAction() async => apiDebounce(() async {
  //       hideKeyBoardFocus();
  //       navigatePage(AppConstants.paymentDetailsPage);
  //     });
}
