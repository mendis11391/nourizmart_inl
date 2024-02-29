import '../../../../../app/utils/app_export.dart';
import '../../../data/models/pincode_res_mod.dart';
import '../../../domain/view_cart_use_case.dart';
import '../product_list/bs/units_bs.dart';
import 'bs/pincode_bs.dart';
import 'bs/store_bs.dart';

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
      loadingPincode = false.obs,
      tempPincode = ''.obs,
      previousSelected = '',
      isOpenPincodeBS = false.obs,
      isPageActive = false.obs,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late ScrollController scrollController,
      unitsScrollController,
      pincodeScrollController;
  late RxList<String> responseList;
  late RxList<String> singleItemQty;
  late ViewCartUseCase useCase;
  late List<PincodeResponse> pincodeList;
  late PincodeResponse selectedPincodeItem;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    unitsScrollController = ScrollController();
    pincodeScrollController = ScrollController();
    responseList = <String>[].obs;
    singleItemQty = <String>[].obs;
    useCase = ViewCartUseCase(AppRepoImpl());
    pincodeList = <PincodeResponse>[];
    selectedPincodeItem = PincodeResponse();
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
    unitsScrollController.dispose();
    pincodeScrollController.dispose();
    isPageActive.value = false;
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    isPageActive.value = true;
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      isInstantDelivery = (await getStorageValue(UserKeys.whichDeliveryInt) ==
          DeliveryType.instant.value);

      invokeApiCall();
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
    AppAlertDialog.showAlertDialog(
      descriptions: const AppText(
        text: 'Are you sure, you want to remove this item?',
        size: 13,
      ),
      btn1Name: 'Delete',
      btn2Name: 'Cancel',
      isHideCloseIcon: true,
      topIcon: const Icon(
        Icons.warning_amber_rounded,
        size: 22,
      ),
      onPressedBtn1: () async => {
        AppAlertDialog.hideAlertDialog(),
        showToast('Delete Action'),
      },
      onPressedBtn2: () => {
        AppAlertDialog.hideAlertDialog(),
      },
    );
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

  changeAddressAction() async {
    await saveStorageValue(UserKeys.whereFromAddressStr, 'cart');
    await navigatePage(AppConstants.addressListPage);
  }

  storePincodeAction() {
    hideKeyBoardFocus();
    loadingPincode.value = true;
    apiCallPincode();
  }

  changeStoreAddressAction() async {
    hideKeyBoardFocus();
    Get.bottomSheet(
      const StoreBottomSheet(),
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

  apiCallPincode() async {
    try {
      String payload = validString(9);
      pincodeList.clear();
      pincodeList = await useCase.executePincode(payload);
      if (pincodeList.isNotEmpty) {
        // if (pincodeList.length == 1) {
        //   if (await delayNavigation(50)) {
        //     selectedPincodeItem = pincodeList.first;
        //     storePincode.value = validString(pincodeList.first.pincode);
        //   }
        // }
        if (isPageActive.isTrue && isOpenPincodeBS.isFalse) {
          isOpenPincodeBS.value = true;
          showDropDown();
        }
      } else {
        handleApiException('', 'Empty Pincode List');
      }
      loadingPincode.value = false;
    } catch (e) {
      handleApiException(e, 'Pincode List');
      loadingPincode.value = false;
    }
  }

  showDropDown() async {
    hideKeyBoardFocus();
    previousSelected = '';
    List<String> bsList = [];
    previousSelected = validString(selectedPincodeItem.pincode);
    for (var it in pincodeList) {
      bsList.add(validString(it.pincode));
    }

    final result = await Get.bottomSheet(
      PincodeBottomSheet(
        controller: this,
        listItem: bsList,
        onTapClose: () => bsPincodeCloseAction(),
        previousSelect: previousSelected,
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    if (!isFieldEmpty(result)) {
      bsPincodeSelectAction(result);
    }
  }

  bsPincodeCloseAction() {
    isOpenPincodeBS.value = false;
    backAction();
  }

  bsPincodeSelectAction(String data) {
    isOpenPincodeBS.value = false;
    for (var pr in pincodeList) {
      if (validString(pr.pincode) == data) {
        if (storePincode.value != data) {
          storePincode.value = validString(pr.pincode);
          selectedPincodeItem = pr;
        }
      }
    }
  }
}
