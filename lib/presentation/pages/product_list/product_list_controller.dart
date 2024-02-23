import '../../../../../app/utils/app_export.dart';
import 'filter_bs.dart';
import 'units_bs.dart';

class ProductListController extends GetxController {
  var title = 'Product List'.obs,
      query = ''.obs,
      isLoading = true.obs,
      limits = 10,
      page = 1,
      isNoMoreItem = false.obs,
      isLoadMoreApi = false.obs,
      totalProduct = 0.obs,
      isChangedFilterItem = false.obs,
      isInstantDelivery = true,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late TextEditingController searchController;
  late ScrollController scrollController, chipScrollController, unitsController;
  final productFormKey = GlobalKey<FormState>();
  late RxList<String> responseList;
  late List<String> resFilterList, reqFilterList, previousSelectedFilterList;
  late RxList<String> selectedFilterList;
  late RxList<String> singleItemQty;
  late AppRepo appRepo;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    chipScrollController = ScrollController();
    unitsController = ScrollController();
    searchController = TextEditingController();
    responseList = <String>[].obs;
    resFilterList = <String>[];
    reqFilterList = <String>[];
    previousSelectedFilterList = <String>[];
    selectedFilterList = <String>[].obs;
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
    chipScrollController.dispose();
    unitsController.dispose();
    searchController.dispose();
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      isInstantDelivery = (await getStorageValue(UserKeys.whichDeliveryInt) ==
          DeliveryType.instant.value);

      for (int i = 0; i < 20; i++) {
        responseList.add(validString(i));
        singleItemQty.add('Select unit');
      }

      // invokeApiCall();
    }
  }

  get getSearchText => query.value;

  clearSearchText() {
    onChangedSearchText('');
    searchController.clear();
  }

  onChangedSearchText(String input) => {
        query.value = input,
        searchFilter(query.value),
      };

  searchFilter(String search) async => apiDebounce(
        () async {
          query.value = search;
          isLoading(true);
          showLoadingStyle.value = ApiCallLoadingTypeEnum.search;
          defaultApiCall(search);
        },
        duration:
            const Duration(milliseconds: AppConstants.searchDelayDuration),
      );

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

  filterAction() async {
    hideKeyBoardFocus();
    resFilterList = ['Vegetables', 'Fruits', 'Leafy'];
    previousSelectedFilterList.clear();
    previousSelectedFilterList.addAll(selectedFilterList);
    Get.bottomSheet(
      FilterBottomSheet(
        controller: this,
        filterItem: resFilterList,
        onTapClose: () => bsFilterCloseAction(),
        onTapClear: () => bsFilterClearAction(),
        onTapApply: () => bsFilterApplyAction(),
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
  }

  bsFilterCloseAction() {
    selectedFilterList.clear();
    if (previousSelectedFilterList.isNotEmpty) {
      selectedFilterList.addAll(previousSelectedFilterList);
    }
    //checkFilterApplyBtn();
    isChangedFilterItem.value = false;
    backAction();
  }

  bsFilterClearAction() {
    selectedFilterList.clear();
    reqFilterList.clear();
    checkFilterApplyBtn();
  }

  bsFilterApplyAction() {
    isChangedFilterItem.value = false;
    backAction();
    // refreshAction();
  }

  checkFilterApplyBtn() {
    isChangedFilterItem.value = !isListsAreEqual(
      previousSelectedFilterList,
      selectedFilterList,
      (item) => item,
    );
  }

  refreshAction() {
    showLoadingStyle.value = ApiCallLoadingTypeEnum.circularProgress;
    defaultApiCall(query.value);
  }

  selectOrUnSelectFilterItem(String item) {
    selectedFilterList.contains(item)
        ? selectedFilterList.remove(item)
        : selectedFilterList.add(item);

    checkFilterApplyBtn();
  }

  removeFilteredAction(String item) {
    if (isLoading.isTrue || selectedFilterList.isEmpty) {
      return;
    }
    selectedFilterList.removeWhere((rd) => rd == item && rd == item);
    showLoadingStyle.value = ApiCallLoadingTypeEnum.circularProgress;
    refreshAction();
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

  addressAction() async {
    await saveStorageValue(UserKeys.whereFromAddressStr, 'home');
    navigatePage(AppConstants.addressListPage);
  }

  viewCartAction() {
    navigatePage(AppConstants.viewCartPage);
  }

  

  // submitAction() async => apiDebounce(() async {
  //       hideKeyBoardFocus();
  //       navigatePage(AppConstants.paymentDetailsPage);
  //     });
}
