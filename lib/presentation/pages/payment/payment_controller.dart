import '../../../../../app/utils/app_export.dart';

class PaymentController extends GetxController {
  var title = 'Payment'.obs,
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

  // submitAction() async => apiDebounce(() async {
  //       hideKeyBoardFocus();
  //       navigatePage(AppConstants.paymentDetailsPage);
  //     });
}
