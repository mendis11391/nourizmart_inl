import '../../../../../app/utils/app_export.dart';
import '../product_list/units_bs.dart';

class ViewCartController extends GetxController {
  var title = 'My Cart'.obs,
      userName = 'User Name'.obs,
      mobile = '9090909090'.obs,
      storePincode = 'Select Pincode'.obs,
      query = ''.obs,
      isLoading = true.obs,
      limits = 10,
      page = 1,
      isNoMoreItem = false.obs,
      isLoadMoreApi = false.obs,
      totalProduct = 0.obs,
      isInstantDelivery = true, // FIXME : Need from Api also
      isBtnEnable = true.obs,
      isVisibleAmt = false.obs,
      totalAmt = 120.0.obs,
      allProductAmt = 90.0.obs,
      deliveryAmt = 20.0.obs,
      confirmationAmt = 30.0.obs,
      tax = 10.0.obs,
      selectedPick = 0.obs, // 0 - Home, 1 - Self
      isAllowEditing = true.obs,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late ScrollController scrollController, unitsController;
  late RxList<String> responseList;
  late RxList<String> singleItemQty;
  late AppRepo appRepo;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    unitsController = ScrollController();
    responseList = <String>[].obs;
    singleItemQty = <String>[].obs;
    appRepo = AppRepoImpl();
  }

  @override
  void onReady() {
    super.onReady();
    getSharedValue();
    // paginationTask();
  }

  @override
  void onClose() {
    apiTimer?.cancel();
    scrollController.dispose();
    unitsController.dispose();
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      isInstantDelivery = (await getStorageValue(UserKeys.whichDeliveryInt) ==
          DeliveryType.instant.value);

      for (int i = 0; i < 10; i++) {
        responseList.add(validString(i));
        singleItemQty.add('$i');
      }

      if (!isInstantDelivery) {
        totalAmt.value = 0.0;
        allProductAmt.value = 0.0;
        deliveryAmt.value = 0.0;
        tax.value = 0.0;
      }

      // invokeApiCall();
    }
  }

  invokeApiCall() async {
    showLoadingStyle.value = ApiCallLoadingTypeEnum.circularProgress;
    defaultApiCall(query.value);
  }

  defaultApiCall(String searchText) async {
    if (await checkInternetConnection()) {
      isLoading(true);
      isLoadMoreApi(false);
      isNoMoreItem(false);
      page = 1;
      if (showLoadingStyle.value == ApiCallLoadingTypeEnum.customLoading) {
        AppLoader.showLoadingDialog();
      }

      apiCallProductList(searchText, false);
    } else {
      await resetLoading(AppConstants.appZeroDuration);
    }
  }

  apiCallProductList(String searchText, bool isPagination) async {
    if (!isPagination) {
      responseList.clear();
    }
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

      await resetLoading(AppConstants.appResetLoadingDuration);
    } catch (e) {
      handleApiException(e, 'Product List');
    }
  }

  handleApiException(dynamic error, String tag) async {
    // String errorMsg = checkErrorModel(error);
    // handleException(errorMsg, tag);
    // showToast(errorMsg, msgType: ToastEnumType.error);

    showToast(validString(error), toastType: ToastType.error);
    await resetLoading(AppConstants.appShortDelayDuration);
  }

  resetLoading(int delayDuration) async {
    if (await delayNavigation(delayDuration)) {
      isLoading(false);
      isLoadMoreApi(false);
      if (showLoadingStyle.value == ApiCallLoadingTypeEnum.customLoading) {
        AppLoader.hideLoadingDialog();
      }
      showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
    }
  }

  paginationTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isLoadMoreApi.isFalse) {
        // page += limits;
        page++;
        getMoreTask();
      }
    });
  }

  getMoreTask() async {
    if (await checkInternetConnection()) {
      if (isNoMoreItem.isFalse) {
        isLoadMoreApi(true);
        showLoadingStyle.value = ApiCallLoadingTypeEnum.loadMore;
        apiCallProductList(query.value, true);
      } else {
        // page -= limits;
        page--;
        isLoadMoreApi(false);
        showToast('No more items');
      }
    }
  }

  unitAction(String item, int idx) {
    hideKeyBoardFocus();
    RxList<String> item = ['1 kg', '500 g', '250 g', '100 g'].obs;
    Get.bottomSheet(
      UnitsBottomSheet(listItem: item),
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

  deleteAction(String item, int idx) {
    showToast('Delete Action');
  }

  decreaseQty(String item, int idx) {
    showToast('Decrease Qty Action');
  }

  increaseQty(String item, int idx) {
    showToast('Increase Qty Action');
  }

  visibleAmountDetails() {
    isVisibleAmt(!isVisibleAmt.value);
  }

  changeAddressAction() {
    showToast('Change Address Action');
  }

  storePincodeAction() {
    showToast('Store Pincode Action');
  }

  changeStoreAddressAction() {
    showToast('Store Address Action');
  }

  saveAction() {
    showToast('Save Action');
    if (isAllowEditing.isFalse) {
      isAllowEditing.value = true;
      isBtnEnable.value = true;
    }
    responseList.refresh();
  }

  editAction() {
    showToast('Edit Action');
    if (isAllowEditing.isTrue) {
      isAllowEditing.value = false;
      isBtnEnable.value = false;
    }
    responseList.refresh();
  }

  submitAction() async => apiDebounce(() async {
        hideKeyBoardFocus();
        navigatePage(AppConstants.paymentPage);
      });
}
