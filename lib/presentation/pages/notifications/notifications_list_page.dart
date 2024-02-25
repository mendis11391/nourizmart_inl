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

  Widget buildBody() => SafeArea(
        child: Column(
          children: [
            buildListSection(),
          ],
        ),
      );

  Widget buildListSection() =>
      controller.responseList.isEmpty ? loadingNoData() : buildListBuilder();

  Widget loadingNoData() => Visibility(
        visible: (controller.showLoadingStyle.value ==
                ApiCallLoadingTypeEnum.circularProgress ||
            controller.showLoadingStyle.value == ApiCallLoadingTypeEnum.search),
        replacement: controller.isLoading.isFalse
            ? const AppNoDataFound()
            : const SizedBox.shrink(),
        child: const AppCircularProgress(),
      );

  Widget buildListBuilder() => Expanded(
        child: ListView.separated(
          controller: controller.scrollController,
          padding: getPadding(left: 12, right: 12, top: 15, bottom: 20),
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          itemCount: controller.responseList.length,
          itemBuilder: (context, idx) {
            if (idx == (controller.responseList.length - 1) &&
                controller.isLoadMoreApi.isTrue) {
              return const AppLoadMore();
            } else {
              final String item = controller.responseList[idx];
              return buildListElements(item, idx);
            }
          },
          separatorBuilder: (BuildContext context, int index) => AppDivider(
            // color: Colors.transparent,
            height: getSize(5),
            // thickness: getSize(1),
          ),
        ),
      );

  Widget buildListElements(String item, int idx) => ListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        leading: Container(
          height: getSize(40),
          width: getSize(40),
          padding: getPadding(all: 5),
          decoration: BoxDecoration(
            color: getBgColor(idx),
            borderRadius: BorderRadius.circular(getSize(5)),
          ),
          child: AppImage(
            assetName: getImage(idx),
          ),
        ),
        title: AppText(
          text: getName(idx),
          size: 14,
        ),
        subtitle: Padding(
          padding: getPadding(top: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.access_time,
                size: getSize(15),
                color: Colors.grey.shade700,
              ),
              const SpaceWidth(mWidth: 3),
              AppText(
                text: getTime(idx),
                size: 13,
                color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
      );

  String getName(int idx) {
    return idx == 0
        ? 'Your order #[Order ID] has been confirmed.'
        : idx == 1
            ? 'Payment confirmation for your order #[Order ID]'
            : idx == 2
                ? 'Your order has been successfully placed.'
                : 'Your new address has been added successfully.';
  }

  String getTime(int idx) {
    return idx == 0
        ? 'Just now'
        : idx == 1
            ? '1 minutes ago'
            : idx == 2
                ? '2 day ago'
                : '3 weeks ago';
  }

  String getImage(int idx) {
    return idx == 0
        ? AppResource.icShopping
        : idx == 1
            ? AppResource.icVisa
            : idx == 2
                ? AppResource.icOrderPlaced
                : AppResource.icResidential;
  }

  Color getBgColor(int idx) {
    return idx == 0
        ? const Color(0xffCAFDD1)
        : idx == 1
            ? const Color(0xffFFDEEC)
            : idx == 2
                ? const Color(0xffFFF6AD)
                : const Color(0xffE4CCFD);
  }
}
