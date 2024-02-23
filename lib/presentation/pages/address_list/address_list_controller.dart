import '../../../../../app/utils/app_export.dart';

class AddressListController extends GetxController {
  var title = 'Address'.obs,
      isLoading = true.obs,
      limits = 10,
      page = 1,
      isNoMoreItem = false.obs,
      isLoadMoreApi = false.obs,
      totalAddress = 0.obs,
      whereFrom = ''.obs,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late ScrollController scrollController;
  late RxList<String> responseList;
  late AppRepo appRepo;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    responseList = <String>[].obs;
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
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      whereFrom.value =
          validString(await getStorageValue(UserKeys.whereFromAddressStr));

      invokeApiCall();
    }
  }

  invokeApiCall() async {
    showLoadingStyle.value = ApiCallLoadingTypeEnum.circularProgress;
    defaultApiCall();
  }

  defaultApiCall() async {
    if (await checkInternetConnection()) {
      isLoading(true);
      isLoadMoreApi(false);
      isNoMoreItem(false);
      page = 1;
      if (showLoadingStyle.value == ApiCallLoadingTypeEnum.customLoading) {
        AppLoader.showLoadingDialog();
      }

      apiCallAddressList(false);
    } else {
      await resetLoading(AppConstants.appZeroDuration);
    }
  }

  apiCallAddressList(bool isPagination) async {
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

      for (int i = 0; i < 20; i++) {
        responseList.add(validString(i));
      }

      await resetLoading(AppConstants.appResetLoadingDuration);
    } catch (e) {
      handleApiException(e, 'Address List');
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
        apiCallAddressList(true);
      } else {
        // page -= limits;
        page--;
        isLoadMoreApi(false);
        showToast('No more items');
      }
    }
  }

  deleteAction(String item, int idx) {
    showToast('Delete Action');
  }

  editAction(String item, int idx) {
    showToast('Edit Action');
  }

  addAction() {
    navigatePage(AppConstants.addAddressPage);
  }

  // submitAction() async => apiDebounce(() async {
  //       hideKeyBoardFocus();
  //       navigatePage(AppConstants.paymentDetailsPage);
  //     });
}
