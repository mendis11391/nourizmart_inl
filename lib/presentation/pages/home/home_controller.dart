import '../../../../../app/utils/app_export.dart';

class HomeController extends GetxController {
  var title = 'Home'.obs,
      userName = '--'.obs,
      userAddress = '--'.obs,
      isOfferLoading = true.obs,
      isOrderLoading = false.obs,
      circleInx = 0.obs,
      notificationCount = 0.obs,
      cartCount = 0.obs,
      pageNo = 0,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late final PageController pgController;
  late ScrollController orderScrollController;
  late RxList<String> offerList, orderList;
  Timer? carouselTimer;
  late DateTime preBackPress;

  @override
  void onInit() {
    super.onInit();
    userName.value = AppConstants.userName;
    userAddress.value = AppConstants.userAddress;
    pgController = PageController(initialPage: 0, viewportFraction: 0.85);
    orderScrollController = ScrollController();
    offerList = <String>[].obs;
    orderList = <String>[].obs;
    preBackPress = DateTime.now();
  }

  @override
  void onReady() {
    super.onReady();
    getSharedValue();
  }

  @override
  void onClose() {
    apiTimer?.cancel();
    carouselTimer?.cancel();
    pgController.dispose();
    orderScrollController.dispose();
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      UserDataController userData = await getUserDataController();
      userName.value = userData.firstName.value;
      userAddress.value = userData.fullAddress.value;
      invokeOfferApiCall();
      invokeOrderApiCall();
    }

    notificationCount.value = 9;
    cartCount.value = 17;
    // if (await delayNavigation(2000)) {
    //   notificationCount.value = 2;
    //   cartCount.value = 0;
    // }
  }

  invokeOfferApiCall() async {
    isOfferLoading.value = true;
    if (await checkInternetConnection()) {
      apiCallOfferList();
    } else {
      isOfferLoading.value = false;
    }
  }

  apiCallOfferList() async {
    // dynamic payload = requestByData(searchText);

    try {
      // var response = await useCase.executeStoreList(payload);

      // if (response.data != null && response.data!.rows != null) {
      //   totalStore.value = validInt(response.data!.count);

      //   if (isPagination && response.data!.rows!.isEmpty) {
      //     isLoadMoreApi(false);
      //     offset -= limits;
      //     showToast('lbl_no_more_data'.tr);
      //     isNoMoreItem(true);
      //   }
      //   responseList.addAll(response.data!.rows!);

      // } else {
      //   showToast('Failed: OnBoard Store List', msgType: ToastEnumType.error);
      // }
      offerList.add(
          'https://img.freepik.com/free-photo/fresh-vegetables-tomato-cauliflower-carrot-broccoli-onion-bell-pepper-generated-by-artificial-intelligence_25030-60620.jpg?t=st=1708269235~exp=1708272835~hmac=d33188b0740b1c197273be28816b24bc22515d8b47d88b8f45a7d0bdaa25e894&w=2000');
      offerList.add(
          'https://t4.ftcdn.net/jpg/02/61/88/57/360_F_261885799_wChAE2Eseb3sGtTNcz1nvi0V51p6mcMZ.jpg');
      offerList.add(
          'https://st4.depositphotos.com/16122460/41404/i/450/depositphotos_414040692-stock-photo-many-fresh-different-vegetables-background.jpg');

      if (offerList.isNotEmpty) {
        carouselTimer = getTimer();
      }

      isOfferLoading.value = false;
    } catch (e) {
      handleOfferApiException(e, 'Offer List');
    }
  }

  handleOfferApiException(dynamic error, String tag) async {
    showToast(validString(error), toastType: ToastType.error);
    isOfferLoading.value = false;
  }

  Timer getTimer() => Timer.periodic(
        const Duration(milliseconds: 2500),
        ((timer) async {
          // appLog('Home Offer Card Page No: $pageNo');
          if (pageNo >= offerList.length) {
            pageNo = 0;
          }
          await pgController.animateToPage(
            pageNo,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOutCirc,
          );
          pageNo++;
        }),
      );

  invokeOrderApiCall() async {
    isOrderLoading.value = true;
    if (await checkInternetConnection()) {
      apiCallOrderList();
    } else {
      isOrderLoading.value = false;
    }
  }

  apiCallOrderList() async {
    // dynamic payload = requestByData(searchText);

    try {
      // var response = await useCase.executeStoreList(payload);

      // if (response.data != null && response.data!.rows != null) {
      //   totalStore.value = validInt(response.data!.count);

      //   if (isPagination && response.data!.rows!.isEmpty) {
      //     isLoadMoreApi(false);
      //     offset -= limits;
      //     showToast('lbl_no_more_data'.tr);
      //     isNoMoreItem(true);
      //   }
      //   responseList.addAll(response.data!.rows!);

      // } else {
      //   showToast('Failed: OnBoard Store List', msgType: ToastEnumType.error);
      // }
      for (int i = 0; i < 3; i++) {
        orderList.add(validString(i));
      }

      isOrderLoading.value = false;
    } catch (e) {
      handleOrderApiException(e, 'Order List');
    }
  }

  handleOrderApiException(dynamic error, String tag) async {
    showToast(validString(error), toastType: ToastType.error);
    isOrderLoading.value = false;
  }

  cardAction() {
    navigatePage(AppConstants.viewCartPage);
  }

  notificationAction() {
    navigatePage(AppConstants.notificationsListPage);
  }

  addressAction() async {
    await saveStorageValue(UserKeys.whereFromAddressStr, 'home');
    navigatePage(AppConstants.addressListPage);
  }

  profileAction() {
    navigatePage(AppConstants.profilePage);
  }

  discountAction() async {
    await saveStorageValue(
        UserKeys.whichDeliveryInt, DeliveryType.discount.value);
    navigatePage(AppConstants.productListPage);
  }

  instantAction() async {
    await saveStorageValue(
        UserKeys.whichDeliveryInt, DeliveryType.instant.value);
    navigatePage(AppConstants.productListPage);
  }

  seeMoreAction() {
    navigatePage(AppConstants.orderListPage);
  }

  orderAction(int index) {
    navigatePage(AppConstants.orderDetailsPage);
  }

  onPauseAction() {
    carouselTimer?.cancel();
  }

  onResumeAction() {
    if (offerList.isNotEmpty &&
        carouselTimer != null &&
        !carouselTimer!.isActive) {
      appLog('Start Timer');
      carouselTimer = getTimer();
    }
  }

  // submitAction() async => apiDebounce(() async {
  //       hideKeyBoardFocus();
  //       navigatePage(AppConstants.paymentDetailsPage);
  //     });
}
