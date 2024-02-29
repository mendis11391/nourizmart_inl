import '../../../../../app/utils/app_export.dart';
import '../../../data/models/area_res_mod.dart';
import '../../../data/models/district_res_mod.dart';
import '../../../data/models/get_user_res_mod.dart';
import '../../../data/models/pincode_res_mod.dart';
import '../../../data/models/state_res_mod.dart';
import '../../../domain/register_use_case.dart';
import 'bs/register_bs.dart';

class RegisterController extends GetxController {
  var title = 'Register'.obs,
      fn = ''.obs,
      ln = ''.obs,
      mob = ''.obs,
      house = ''.obs,
      street = ''.obs,
      state = ''.obs,
      district = ''.obs,
      pincode = ''.obs,
      area = ''.obs,
      land = ''.obs,
      isBtnEnable = false.obs,
      previousSelected = '',
      selectedCurrentItem = ''.obs,
      loadingState = true.obs,
      loadingDistrict = false.obs,
      loadingPincode = false.obs,
      loadingArea = false.obs,
      isEnableState = false.obs,
      isEnableDistrict = false.obs,
      isEnablePincode = false.obs,
      isEnableArea = false.obs,
      showLoadingStyle = ApiCallLoadingTypeEnum.none.obs;
  late TextEditingController fnController,
      lnController,
      mobController,
      houseController,
      streetController,
      stateController,
      districtController,
      pincodeController,
      areaController,
      landController;
  late FocusNode fnFocusNode,
      lnFocusNode,
      mobFocusNode,
      houseFocusNode,
      streetFocusNode,
      stateFocusNode,
      districtFocusNode,
      pincodeFocusNode,
      areaFocusNode,
      landFocusNode;
  late RegisterUseCase useCase;
  late ScrollController scrollController, dropdownScrollController;
  final registerFormKey = GlobalKey<FormState>();
  late List<StateResponse> stateList;
  late StateResponse selectedStateItem;
  late List<DistrictResponse> districtList;
  late DistrictResponse selectedDistrictItem;
  late List<PincodeResponse> pincodeList;
  late PincodeResponse selectedPincodeItem;
  late List<AreaResponse> areaList;
  late AreaResponse selectedAreaItem;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    useCase = RegisterUseCase(AppRepoImpl());
    fnController = TextEditingController();
    lnController = TextEditingController();
    mobController = TextEditingController();
    houseController = TextEditingController();
    streetController = TextEditingController();
    stateController = TextEditingController();
    districtController = TextEditingController();
    pincodeController = TextEditingController();
    areaController = TextEditingController();
    landController = TextEditingController();
    fnFocusNode = FocusNode();
    lnFocusNode = FocusNode();
    mobFocusNode = FocusNode();
    houseFocusNode = FocusNode();
    streetFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    districtFocusNode = FocusNode();
    pincodeFocusNode = FocusNode();
    areaFocusNode = FocusNode();
    landFocusNode = FocusNode();
    dropdownScrollController = ScrollController();
    stateList = <StateResponse>[];
    selectedStateItem = StateResponse();
    districtList = <DistrictResponse>[];
    selectedDistrictItem = DistrictResponse();
    pincodeList = <PincodeResponse>[];
    selectedPincodeItem = PincodeResponse();
    areaList = <AreaResponse>[];
    selectedAreaItem = AreaResponse();
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
    fnController.dispose();
    lnController.dispose();
    mobController.dispose();
    houseController.dispose();
    streetController.dispose();
    stateController.dispose();
    districtController.dispose();
    pincodeController.dispose();
    areaController.dispose();
    landController.dispose();
    fnFocusNode.dispose();
    lnFocusNode.dispose();
    mobFocusNode.dispose();
    houseFocusNode.dispose();
    streetFocusNode.dispose();
    stateFocusNode.dispose();
    districtFocusNode.dispose();
    pincodeFocusNode.dispose();
    areaFocusNode.dispose();
    landFocusNode.dispose();
    dropdownScrollController.dispose();
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      String mobile =
          validString(await getStorageValue(UserKeys.userMobileStr));
      StateResponse sr = StateResponse(stateId: 1, stateName: 'Karnataka');
      stateList.add(sr);

      if (await delayNavigation(50)) {
        onChangedMob(mobile);
        mobController.text = mobile;
        stateController.text = validString(stateList.first.stateName);
        selectedStateItem = stateList.first;
        loadingState.value = false;
        isEnableState.value = true;

        loadingDistrict.value = true;
        apiCallDistrict(false);
      }
    }
  }

  get getFn => fn.value;
  get getLn => ln.value;
  get getMob => mob.value;
  get getHouseNo => house.value;
  get getStreet => street.value;
  get getLand => land.value;

  onChangedFn(String input) => fn.value = input;
  onChangedLn(String input) => ln.value = input;
  onChangedMob(String input) => mob.value = input;
  onChangedHouseNo(String input) => house.value = input;
  onChangedStreet(String input) => street.value = input;
  onChangedLand(String input) => land.value = input;

  clearFnText() {
    onChangedFn('');
    fnController.clear();
  }

  clearLnText() {
    onChangedLn('');
    lnController.clear();
  }

  clearMobText() {
    onChangedMob('');
    mobController.clear();
  }

  clearHouseNoText() {
    onChangedHouseNo('');
    houseController.clear();
  }

  clearStreet() {
    onChangedStreet('');
    streetController.clear();
  }

  clearLand() {
    onChangedLand('');
    landController.clear();
  }

  stateAction() {
    showDropDown(DropDownType.state);
  }

  districtAction() {
    if (districtList.isNotEmpty) {
      showDropDown(DropDownType.district);
    } else {
      showLoadingStyle.value = ApiCallLoadingTypeEnum.customLoading;
      AppLoader.showLoadingDialog();
      apiCallDistrict(true);
    }
  }

  pincodeAction() {
    if (pincodeList.isNotEmpty) {
      showDropDown(DropDownType.pincode);
    } else {
      showLoadingStyle.value = ApiCallLoadingTypeEnum.customLoading;
      AppLoader.showLoadingDialog();
      apiCallPincode(true);
    }
  }

  areaAction() {
    if (areaList.isNotEmpty) {
      showDropDown(DropDownType.area);
    } else {
      showLoadingStyle.value = ApiCallLoadingTypeEnum.customLoading;
      AppLoader.showLoadingDialog();
      apiCallArea(true);
    }
  }

  showDropDown(DropDownType type) async {
    hideKeyBoardFocus();
    previousSelected = '';
    List<String> bsList = [];
    if (type == DropDownType.state) {
      previousSelected = validString(selectedStateItem.stateName);
      for (var it in stateList) {
        bsList.add(validString(it.stateName));
      }
    } else if (type == DropDownType.district) {
      previousSelected = validString(selectedDistrictItem.districtName);
      for (var it in districtList) {
        bsList.add(validString(it.districtName));
      }
    } else if (type == DropDownType.pincode) {
      previousSelected = validString(selectedPincodeItem.pincode);
      for (var it in pincodeList) {
        bsList.add(validString(it.pincode));
      }
    } else if (type == DropDownType.area) {
      previousSelected = validString(selectedAreaItem.areaName);
      for (var it in areaList) {
        bsList.add(validString(it.areaName));
      }
    }

    final result = await Get.bottomSheet(
      RegisterBottomSheet(
        controller: this,
        listItem: bsList,
        onTapClose: () => bsRegisterCloseAction(type),
        // onTapSelect: (item) => bsRegisterSelectAction(type, item),
        dropDownType: type,
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
      bsRegisterSelectAction(type, result);
    }
  }

  bsRegisterCloseAction(DropDownType type) {
    //checkFilterApplyBtn();
    backAction();
  }

  bsRegisterSelectAction(DropDownType type, String selectedName) {
    if (type == DropDownType.state) {
      for (var sr in stateList) {
        if (validString(sr.stateName) == selectedName) {
          stateController.text = validString(sr.stateName);
          selectedStateItem = sr;
          isEnableDistrict.value = true;
        }
      }
    } else if (type == DropDownType.district) {
      for (var dr in districtList) {
        if (validString(dr.districtName) == selectedName) {
          districtController.text = validString(dr.districtName);
          selectedDistrictItem = dr;
          isEnablePincode.value = true;
        }
      }
    } else if (type == DropDownType.pincode) {
      for (var pr in pincodeList) {
        if (validString(pr.pincode) == selectedName) {
          pincodeController.text = validString(pr.pincode);
          selectedPincodeItem = pr;
          isEnableArea.value = true;
        }
      }
    } else if (type == DropDownType.area) {
      for (var ar in areaList) {
        if (validString(ar.areaName) == selectedName) {
          areaController.text = validString(ar.areaName);
          selectedAreaItem = ar;
        }
      }
    }
  }

  apiCallDistrict(bool isClicked) async {
    try {
      String payload = validString(selectedStateItem.stateId);
      districtList.clear();
      districtList = await useCase.executeDistrict(payload);
      if (districtList.isNotEmpty) {
        if (districtList.length == 1) {
          if (await delayNavigation(50)) {
            selectedDistrictItem = districtList.first;
            districtController.text =
                validString(districtList.first.districtName);
            isEnablePincode.value = true;
            if (!isClicked) {
              loadingPincode.value = true;
              apiCallPincode(false);
            }
          }
        } else {
          if (showLoadingStyle.value == ApiCallLoadingTypeEnum.customLoading) {
            showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
            await AppLoader.hideLoadingDialog();
          }
        }
        if (isClicked) {
          if (showLoadingStyle.value == ApiCallLoadingTypeEnum.customLoading) {
            showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
            await AppLoader.hideLoadingDialog();
          }
          showDropDown(DropDownType.district);
        }
      } else {
        handleApiException('', 'Empty District List');
      }
      loadingDistrict.value = false;
    } catch (e) {
      handleApiException(e, 'District List');
      loadingDistrict.value = false;
    }
    isEnableDistrict.value = true;
  }

  apiCallPincode(bool isClicked) async {
    try {
      String payload = validString(selectedDistrictItem.districtId);
      pincodeList.clear();
      pincodeList = await useCase.executePincode(payload);
      if (pincodeList.isNotEmpty) {
        if (pincodeList.length == 1) {
          if (await delayNavigation(50)) {
            selectedPincodeItem = pincodeList.first;
            pincodeController.text = validString(pincodeList.first.pincode);
            isEnableArea.value = true;
            if (!isClicked) {
              loadingArea.value = true;
              apiCallArea(false);
            }
          }
        } else {
          if (showLoadingStyle.value == ApiCallLoadingTypeEnum.customLoading) {
            showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
            await AppLoader.hideLoadingDialog();
          }
        }
        if (isClicked) {
          if (showLoadingStyle.value == ApiCallLoadingTypeEnum.customLoading) {
            showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
            await AppLoader.hideLoadingDialog();
          }
          showDropDown(DropDownType.pincode);
        }
      } else {
        handleApiException('', 'Empty Pincode List');
      }
      loadingPincode.value = false;
    } catch (e) {
      handleApiException(e, 'Pincode List');
      loadingPincode.value = false;
    }
    isEnablePincode.value = true;
  }

  apiCallArea(bool isClicked) async {
    try {
      String payload = validString(selectedPincodeItem.pincodeId);
      areaList.clear();
      areaList = await useCase.executeArea(payload);
      if (areaList.isNotEmpty) {
        if (areaList.length == 1) {
          if (await delayNavigation(50)) {
            selectedAreaItem = areaList.first;
            areaController.text = validString(areaList.first.areaName);
          }
        } else {
          if (showLoadingStyle.value == ApiCallLoadingTypeEnum.customLoading) {
            showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
            await AppLoader.hideLoadingDialog();
          }
        }
        if (isClicked) {
          if (showLoadingStyle.value == ApiCallLoadingTypeEnum.customLoading) {
            showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
            await AppLoader.hideLoadingDialog();
          }
          showDropDown(DropDownType.area);
        }
      } else {
        handleApiException('', 'Empty Area List');
      }
      loadingArea.value = false;
    } catch (e) {
      handleApiException(e, 'Area List');
      loadingArea.value = false;
    }
    isEnableArea.value = true;
  }

  handleApiException(dynamic error, String tag) async {
    showToast(validString(error), toastType: ToastType.error);
  }

  validator() {
    var isValid = registerFormKey.currentState!.validate();
    if (isValid &&
        (isFieldEmpty(selectedStateItem.stateName) ||
            validInt(selectedStateItem.stateId) <= 0)) {
      isValid = false;
    } else if (isValid &&
        (isFieldEmpty(selectedDistrictItem.districtName) ||
            validInt(selectedDistrictItem.districtId) <= 0)) {
      isValid = false;
    } else if (isValid &&
        (isFieldEmpty(selectedPincodeItem.pincode) ||
            validInt(selectedPincodeItem.pincodeId) <= 0)) {
      isValid = false;
    } else if (isValid &&
        (isFieldEmpty(selectedAreaItem.areaName) ||
            validInt(selectedAreaItem.areaId) <= 0)) {
      isValid = false;
    }
    return isBtnEnable.value = isValid;
  }

  submitAction() async {
    hideKeyBoardFocus();
    showLoadingStyle.value = ApiCallLoadingTypeEnum.customLoading;
    AppLoader.showLoadingDialog();

    return apiDebounce(() async {
      if (await checkInternetConnection()) {
        apiCallRegistration();
      } else {
        showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
        await AppLoader.hideLoadingDialog();
      }
    });
  }

  apiCallRegistration() async {
    String rFireId = await getStorageValue(UserKeys.firebaseIdStr);
    String rMob = await getStorageValue(UserKeys.userMobileStr);
    String rFn = validString(fnController.text);
    String rLn = validString(lnController.text);
    String rNo = validString(houseController.text);
    String rStr = validString(streetController.text);
    String rStateId = validString(selectedStateItem.stateId);
    String rDistrictId = validString(selectedDistrictItem.districtId);
    String rPincodeId = validString(selectedPincodeItem.pincodeId);
    String rAreaId = validString(selectedAreaItem.areaId);
    String rLand = validString(landController.text);
    try {
      var payload = {
        'firebaseId': rFireId,
        'first_name': rFn,
        'last_name': rLn,
        'mobile': rMob,
        'email': 'nil',
        'house_no': rNo,
        'street': rStr,
        'stateId': rStateId,
        'districtId': rDistrictId,
        'pincodeId': rPincodeId,
        'areaId': rAreaId,
        'landmark': rLand,
        'is_active': 'Y',
        'createdBy': 'User'
      };

      var response = await useCase.executeRegistration(payload);
      showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
      await AppLoader.hideLoadingDialog();
      showToast(validString(response.message));
      if (validInt(response.status) == 1) {
        UserResponse resUser = UserResponse();
        resUser.firstName = rFn;
        resUser.lastName = rLn;
        resUser.mobile = rMob;
        resUser.houseNo = rNo;
        resUser.street = rStr;
        resUser.stateName = validString(selectedStateItem.stateName);
        resUser.districtName = validString(selectedDistrictItem.districtName);
        resUser.pincode = validString(selectedPincodeItem.pincode);
        resUser.areaName = validString(selectedAreaItem.areaName);
        await saveStorageValue(
            UserKeys.userModel, userResponseSingleToJson(resUser));
        await saveStorageValue(UserKeys.userLoggedInInt, 1);
        await setUserValueForCrashlytics();
        await navigatePage(AppConstants.homePage);
      }
    } catch (e) {
      handleApiException(e, 'New Registration');
      showLoadingStyle.value = ApiCallLoadingTypeEnum.none;
      await AppLoader.hideLoadingDialog();
    }
  }
}
