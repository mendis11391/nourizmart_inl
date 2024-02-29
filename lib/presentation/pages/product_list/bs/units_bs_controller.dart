import '../../../../app/utils/app_export.dart';

class UnitsController extends GetxController {
  var empty = ''.obs;
  late ScrollController scrollController;
  late List<String> mListItem;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    mListItem = <String>[];
  }

  @override
  void onClose() {
    apiTimer?.cancel();
    scrollController.dispose();
  }

  setList(List<String> listItem) {
    mListItem.clear();
    mListItem.addAll(listItem);
  }

  decreaseQty(String item, int idx, RxList<String> listItem) {
    showToast('Decrease Action');
    // int nm = validInt(item);
    // if (nm > 0) {
    //   nm--;
    // }
    // listItem[idx] = validString(nm);
    // update();
  }

  increaseQty(String item, int idx, RxList<String> listItem) {
    showToast('Increase Action');
    // int nm = validInt(item);
    // nm++;
    // listItem[idx] = validString(nm);
    // update();
  }
}
