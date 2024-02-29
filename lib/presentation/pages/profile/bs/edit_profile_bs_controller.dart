import '../../../../app/utils/app_export.dart';

class EditProfileController extends GetxController {
  var empty = ''.obs,
      fn = ''.obs,
      ln = ''.obs,
      isLoading = false.obs,
      isEnableBtn = false.obs;
  late TextEditingController fnController, lnController;
  late FocusNode fnFocusNode, lnFocusNode;
  late AppRepo appRepo;
  late ScrollController scrollController;
  final editProfileFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    appRepo = AppRepoImpl();
    fnController = TextEditingController();
    lnController = TextEditingController();
    fnFocusNode = FocusNode();
    lnFocusNode = FocusNode();
  }

  @override
  void onClose() {
    apiTimer?.cancel();
    scrollController.dispose();
    fnController.dispose();
    lnController.dispose();
    fnFocusNode.dispose();
    lnFocusNode.dispose();
  }

  get getFn => fn.value;
  get getLn => ln.value;

  onChangedFn(String input) => fn.value = input;
  onChangedLn(String input) => ln.value = input;

  clearFnText() {
    onChangedFn('');
    fnController.clear();
  }

  clearLnText() {
    onChangedLn('');
    lnController.clear();
  }

  submitAction() async => apiDebounce(() async {
        hideKeyBoardFocus();
        showToast('Update Profile');
      });
}
