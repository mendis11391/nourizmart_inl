import '../../../../../../app/utils/app_export.dart';
import 'units_bs_controller.dart';

class UnitsBottomSheet extends StatelessWidget {
  final RxList<String> listItem;

  const UnitsBottomSheet({
    super.key,
    required this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitsController>(
        init: UnitsController(),
        builder: (controller) {
          // controller.setList(listItem);
          return PopScope(
            canPop: false,
            child: SizedBox(
              height: getDeviceHeight() * 0.45,
              child: DecoratedBox(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
                child: Padding(
                  padding: getPadding(all: 16),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppImage(
                                assetName: AppResource.icUser,
                                width: 45,
                                height: 45,
                              ),
                              SpaceWidth(mWidth: 10),
                              Expanded(
                                child: AppText(
                                  text: 'Product Name',
                                  size: 14,
                                  maxLine: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SpaceWidth(mWidth: 22),
                            ],
                          ),
                          const SpaceHeight(mHeight: 20),
                          const AppText(
                            text: 'Add Units',
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          buildListBuilder(controller),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
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

  Widget buildListBuilder(UnitsController controller) => Expanded(
        child: RawScrollbar(
          controller: controller.scrollController,
          thumbColor: AppColors.appThemeColor.shade400,
          trackColor: AppColors.appThemeColor.shade100,
          thumbVisibility: true,
          trackVisibility: true,
          radius: Radius.circular(getSize(10)),
          trackRadius: Radius.circular(getSize(10)),
          child: ListView.separated(
            controller: controller.scrollController,
            padding: getPadding(left: 6, top: 6, right: 10, bottom: 20),
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            itemCount: listItem.length,
            itemBuilder: (context, idx) {
              final String item = listItem[idx];
              return buildListElements(controller, item, idx);
            },
            separatorBuilder: (BuildContext context, int index) => AppDivider(
              color: Colors.transparent,
              height: getSize(10),
              // thickness: getSize(1),
            ),
          ),
        ),
      );

  Widget buildListElements(UnitsController controller, String item, int idx) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppText(
            text: item,
            size: 16,
          ),
          const Spacer(),
          SizedBox(
            height: getVerticalSize(30),
            width: getHorizontalSize(145),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => controller.decreaseQty(item, idx, listItem),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.editFillColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(getSize(3)),
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: SizedBox(
                      width: getHorizontalSize(30),
                      height: getVerticalSize(30),
                      child: Icon(
                        Icons.remove,
                        color: Colors.black87,
                        size: getSize(16),
                      ),
                    ),
                  ),
                ),
                const SpaceWidth(mWidth: 5),
                Expanded(
                  child: SizedBox(
                    height: getVerticalSize(30),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.editFillColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(getSize(3)),
                        border: Border.all(width: 1, color: Colors.transparent),
                      ),
                      child: Padding(
                        padding: getPadding(left: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: /* Obx(
                            () =>  */
                              AppText(
                                  text: validInt(item) > 0
                                      ? item
                                      : controller.empty.value,
                                  size: 14),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SpaceWidth(mWidth: 5),
                InkWell(
                  onTap: () => controller.increaseQty(item, idx, listItem),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.editFillColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(getSize(3)),
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: SizedBox(
                      width: getHorizontalSize(30),
                      height: getVerticalSize(30),
                      child: Icon(
                        Icons.add,
                        color: Colors.black87,
                        size: getSize(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
