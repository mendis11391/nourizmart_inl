import '../../../../../../app/utils/app_export.dart';
import 'product_list_controller.dart';

class FilterBottomSheet extends StatelessWidget {
  final ProductListController controller;
  final List<String> filterItem;
  final VoidCallback onTapClose, onTapClear, onTapApply;

  const FilterBottomSheet({
    super.key,
    required this.controller,
    required this.filterItem,
    required this.onTapClose,
    required this.onTapClear,
    required this.onTapApply,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Obx(
        () => SizedBox(
          height: getDeviceHeight() * 0.40,
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
                      const AppText(
                        text: 'Select Filters',
                        size: 16,
                        weight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                      buildListBuilder(),
                      const SpaceHeight(mHeight: 20),
                      buildBtn(),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: onTapClose,
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
      ),
    );
  }

  Widget buildListBuilder() => Expanded(
        child: RawScrollbar(
          controller: controller.unitsController,
          thumbColor: AppColors.appThemeColor.shade400,
          trackColor: AppColors.appThemeColor.shade100,
          thumbVisibility: true,
          trackVisibility: true,
          radius: Radius.circular(getSize(10)),
          trackRadius: Radius.circular(getSize(10)),
          child: ListView.separated(
            controller: controller.unitsController,
            padding: getPadding(left: 6, top: 6, right: 10, bottom: 20),
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            itemCount: filterItem.length,
            itemBuilder: (context, idx) {
              final String item = filterItem[idx];
              return buildListElements(item, idx);
            },
            separatorBuilder: (BuildContext context, int index) => AppDivider(
              // color: Colors.transparent,
              height: getSize(1),
              // thickness: getSize(1),
            ),
          ),
        ),
      );

  Widget buildListElements(String item, int idx) => Container(
        padding: EdgeInsets.zero,
        child: AppCheckboxListTile(
          contentPadding: getPadding(left: 5, right: 5),
          title: Text(item),
          item: item,
          selectedItems: controller.selectedFilterList,
          onChanged: (value) => controller.selectOrUnSelectFilterItem(item),
        ),
      );

  Widget buildBtn() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap:
                  controller.selectedFilterList.isNotEmpty ? onTapClear : null,
              child: Padding(
                padding: getPadding(left: 8),
                child: AppText(
                    text: 'Clear Filter',
                    size: getFontSize(14),
                    weight: FontWeight.bold,
                    color: controller.selectedFilterList.isNotEmpty
                        ? getPrimaryColor()
                        : getPrimaryColor().withOpacity(0.4)),
              ),
            ),
          ),
          Expanded(
            child: AppButton(
              onTap: onTapApply,
              isEnable: controller.isChangedFilterItem.isTrue,
              buttonText: 'Apply',
              buttonHeight: getVerticalSize(35),
              textSize: getFontSize(14),
              borderRadius: getSize(5),
              borderColor: getPrimaryColor(),
              buttonColor: getPrimaryColor(),
            ),
          ),
        ],
      );
}
