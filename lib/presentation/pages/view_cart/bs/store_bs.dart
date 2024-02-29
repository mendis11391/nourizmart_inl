import '../../../../../../app/utils/app_export.dart';
import 'store_bs_controller.dart';

class StoreBottomSheet extends StatelessWidget {
  const StoreBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
        init: StoreController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            child: Obx(
              () => SizedBox(
                height: getDeviceHeight() * 0.86,
                child: DecoratedBox(
                  decoration: const ShapeDecoration(
                    color: AppColors.appBgGray,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            color: AppColors.appBgGray,
                            shadowColor: Colors.orange,
                            elevation:
                                validDouble(controller.scrollPos.value) > 0.0
                                    ? 2
                                    : 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: getPadding(all: 12),
                                  child: const AppText(
                                    text: 'Select your near store',
                                    size: 16,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                // SpaceHeight(mHeight: 16),
                              ],
                            ),
                          ),
                          // Visibility(
                          //   visible:
                          //       validDouble(controller.scrollPos.value) > 0.0,
                          //   child: const AppDivider(height: 1),
                          // ),
                          buildListSection(controller),
                        ],
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: InkWell(
                          onTap: () => backAction(),
                          child: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Colors.green.shade100,
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: getPrimaryColor(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildListSection(StoreController controller) =>
      controller.responseList.isEmpty
          ? loadingNoData(controller)
          : buildListBuilder(controller);

  Widget loadingNoData(StoreController controller) => Visibility(
        visible: (controller.showLoadingStyle.value ==
                ApiCallLoadingTypeEnum.circularProgress ||
            controller.showLoadingStyle.value == ApiCallLoadingTypeEnum.search),
        replacement: controller.isLoading.isFalse
            ? const AppNoDataFound()
            : const SizedBox.shrink(),
        child: const AppCircularProgress(),
      );

  Widget buildListBuilder(StoreController controller) => Expanded(
        child: ListView.separated(
          controller: controller.scrollController,
          padding: getPadding(left: 12, right: 12, bottom: 20),
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
              return buildListElements(controller, item, idx);
            }
          },
          separatorBuilder: (BuildContext context, int index) => AppDivider(
            color: Colors.transparent,
            height: getSize(5),
            // thickness: getSize(1),
          ),
        ),
      );

  Widget buildListElements(StoreController controller, String item, int idx) =>
      Card(
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
        child: InkWell(
          onTap: () => controller.selectAction(item),
          child: Padding(
            padding: getPadding(all: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.store,
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
                        text: 'Store Name $idx',
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
                      // const SpaceHeight(mHeight: 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
