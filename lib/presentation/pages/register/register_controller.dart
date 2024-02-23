import '../../../../../app/utils/app_export.dart';

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
  late AppRepo appRepo;
  late ScrollController scrollController;
  final registerFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    appRepo = AppRepoImpl();
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
  }

  backValidationAction() {
    backAction();
  }

  getSharedValue() async {
    if (await delayNavigation(AppConstants.appShortDelayDuration)) {
      // Api Call
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
    showToast('State Action');
  }

  districtAction() {
    showToast('district Action');
  }

  pincodeAction() {
    showToast('pincode Action');
  }

  areaAction() {
    showToast('area Action');
  }

  submitAction() async => apiDebounce(() async {
        hideKeyBoardFocus();
        navigatePage(AppConstants.homePage);
      });
}
