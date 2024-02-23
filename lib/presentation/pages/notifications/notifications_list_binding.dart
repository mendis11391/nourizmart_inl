import 'package:get/get.dart';

import 'notifications_list_controller.dart';

class NotificationsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsListController());
  }
}
