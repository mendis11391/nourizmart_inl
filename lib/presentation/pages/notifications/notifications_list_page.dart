import '../../../../../app/utils/app_export.dart';
import 'notifications_list_controller.dart';

class NotificationsListPage extends GetView<NotificationsListController> {
  const NotificationsListPage({super.key});
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(() => buildScreen());
  }

  Widget buildScreen() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => hideKeyBoardFocus(),
        child: Scaffold(
          appBar: buildAppBar(),
          body: buildBody(),
          // bottomNavigationBar: buildBottomNavigation(),
        ),
      );

  AppToolBar buildAppBar() => AppToolBar(
        title: controller.title.value,
        onToolBackPressed: () => controller.backValidationAction(),
      );

  Widget buildBody() =>  SafeArea(
        child: Column(
          children: [
            // buildNote(),
            // buildListData(),

            AppText(text: controller.title.value, size: 25),
          ],
        ),
      );

  //  Widget buildListData() =>
  // controller.responseList.isEmpty ? loadingNoData() : buildListBuilder();

  // Widget loadingNoData() => Visibility(
  //   visible: (controller.showLoadingStyle.value ==
  //           ApiCallLoadingTypeEnum.circularProgress ||
  //       controller.showLoadingStyle.value == ApiCallLoadingTypeEnum.search),
  //   replacement: controller.isLoading.isFalse
  //       ? const AppNoDataFound()
  //       : const SizedBox.shrink(),
  //   child: AppCircularProgress(loadingText: 'lbl_please_wait'.tr),
  // );

  // Widget buildBottomNavigation() => ColoredBox(
  //       color: AppColors.commonThemeShade50,
  //       child: Padding(
  //         padding: getPadding(
  //           top: 10,
  //           bottom: 10,
  //           left: 15,
  //           right: 15,
  //         ),
  //         child: AppButton(
  //           textSize: getFontSize(14),
  //           buttonText: 'Continue',
  //           borderRadius: getSize(5),
  //           weight: FontWeight.bold,
  //           onTap: () => controller.submitAction(),
  //         ),
  //       ),
  //     );
}
