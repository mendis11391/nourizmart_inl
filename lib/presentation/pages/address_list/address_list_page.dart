import '../../../../../app/utils/app_export.dart';
import 'address_list_controller.dart';

class AddressListPage extends GetView<AddressListController> {
  const AddressListPage({super.key});
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
        appBarActions: [
          IconButton(
            onPressed: () => controller.addAction(),
            icon: const Icon(
              Icons.add,
            ),
          ),
          const SpaceWidth(mWidth: 10)
        ],
      );

  Widget buildBody() => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            color: Colors.transparent,
            height: getSize(5),
            // thickness: getSize(1),
          ),
        ),
      );

  Widget buildListElements(String item, int idx) => Card(
        elevation: 0,
        color: idx == 0 ? AppColors.appThemeColor.shade50 : Colors.white,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(12)),
          side: BorderSide(
            color: idx == 0 ? getPrimaryColor() : Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: getPadding(left: 8, right: 8, top: 8, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_rounded,
                color: getPrimaryColor(),
                size: getSize(30),
              ),
              const SpaceWidth(mWidth: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: 'User Name $idx',
                      size: 14,
                      weight: FontWeight.bold,
                    ),
                    const SpaceHeight(mHeight: 3),
                    AppText(
                      text: '+91 999999999',
                      size: 12,
                      color: Colors.grey.shade700,
                    ),
                    const SpaceHeight(mHeight: 3),
                    const AppText(
                      text:
                          '3rd Floor, Sector 6, HSR Layout, Bangalore, Karnataka - 560102',
                      size: 12,
                    ),
                    const SpaceHeight(mHeight: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: idx == 0,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Chip(
                            backgroundColor: Colors.white,
                            side:
                                BorderSide(color: getPrimaryColor(), width: 1),
                            label: AppText(
                              text: 'Default',
                              size: getFontSize(12),
                              color: getPrimaryColor(),
                              weight: FontWeight.w600,
                            ),
                            labelPadding: getPadding(left: 10, right: 10),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onPressed: () => controller.editAction(item, idx),
                          icon: const AppImage(
                            assetName: AppResource.icEdit,
                            // size: getSize(20),
                          ),
                        ),
                        const SpaceWidth(mWidth: 10),
                        IconButton(
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onPressed: () => controller.deleteAction(item, idx),
                          icon: const AppImage(
                            assetName: AppResource.icDelete,
                            // size: getSize(20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
