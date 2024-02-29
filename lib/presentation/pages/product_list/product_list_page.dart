import '../../../../../app/utils/app_export.dart';
import 'product_list_controller.dart';

class ProductListPage extends GetView<ProductListController> {
  const ProductListPage({super.key});
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
          bottomNavigationBar: buildBottomNavigation(),
        ),
      );

  // AppToolBar buildAppBar() => AppToolBar(
  //       title: controller.title.value,
  //       onToolBackPressed: () => controller.backValidationAction(),
  //     );
  AddressToolBar buildAppBar() => AddressToolBar(
        onTapToolAddress: () => controller.addressAction(),
        onTapToolBack: () => controller.backValidationAction(),
        userName: controller.userName.value,
        address: controller.userAddress.value,
        hideBack: false,
        hideCart: true,
        hideNotification: true,
      );

  Widget buildBody() => SafeArea(
        child: Form(
          key: controller.productFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSearchSection(),
                buildNoteSection(),
                buildFilterLabelSection(),
                buildListSection(),
              ],
            ),
          ),
        ),
      );

  Widget buildSearchSection() => Stack(
        children: [
          Card(
            color: Colors.white,
            margin: getMargin(bottom: 2),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(getSize(5)),
                bottomRight: Radius.circular((getSize(5))),
                topLeft: const Radius.circular(0),
                topRight: const Radius.circular(0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: AppSearchField(
                      textEditingController: controller.searchController,
                      helpText: 'Product name',
                      removeCardShape: true,
                      marginAll: 8,
                      // marginBottom: 8,
                      suffix: isFieldEmpty(controller.getSearchText)
                          ? const SizedBox.shrink()
                          : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => controller.clearSearchText(),
                            ),
                      onChanged: (value) =>
                          controller.onChangedSearchText(value)),
                ),
                InkWell(
                  onTap: () => controller.filterAction(),
                  child: AppImage(
                    assetName: (controller.selectedFilterList.isEmpty == true)
                        ? AppResource.icFilter
                        : AppResource.icFilterProduct,
                    height: getSize(45),
                    width: getSize(40),
                  ),
                ),
                const SpaceWidth(mWidth: 5),
              ],
            ),
          ),
          if (controller.selectedFilterList.isNotEmpty) ...[
            Positioned(
              right: 4,
              top: 5,
              child: CircleAvatar(
                backgroundColor: Colors.orange,
                radius: getSize(10),
                child: AppText(
                    text: '${controller.selectedFilterList.length}',
                    color: Colors.white,
                    size: getFontSize(11)),
              ),
            ),
          ]
        ],
      );

  Widget buildFilterLabelSection() => Visibility(
        visible: controller.selectedFilterList.isNotEmpty,
        replacement: SpaceHeight(mHeight: getSize(6)),
        child: ColoredBox(
          color: Colors.white,
          child: SizedBox(
            width: double.infinity,
            height: getVerticalSize(40),
            child: ListView.separated(
                padding: getPadding(left: 10, right: 10),
                controller: controller.chipScrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.selectedFilterList.length,
                itemBuilder: (context, idx) {
                  final item = controller.selectedFilterList[idx];
                  return buildFilterLabelElements(item);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: getHorizontalSize(6))),
          ),
        ),
      );

  Widget buildFilterLabelElements(String item) => Chip(
        backgroundColor: AppColors.appThemeColor.shade50,
        side: BorderSide(color: getPrimaryColor(), width: 1),
        label: AppText(
          text: validString(item),
          size: getFontSize(12),
          color: getPrimaryColor(),
        ),
        deleteIcon: Icon(
          Icons.close,
          size: getSize(16),
          color: Colors.black54,
        ),
        onDeleted: () => controller.removeFilteredAction(item),
      );

  Widget buildNoteSection() => Visibility(
        visible: !controller.isInstantDelivery,
        replacement: const SizedBox.shrink(),
        child: ColoredBox(
          color: AppColors.appThemeColor.shade50,
          child: Padding(
            padding: getPadding(left: 10, right: 10, top: 5, bottom: 5),
            child: RichText(
              text: TextSpan(
                text: 'Note: ',
                style: TextStyle(
                  fontSize: getFontSize(11),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        'For next day delivery, price might differ. Actual product price will be disclosed tomorrow upon order creation.',
                    style: TextStyle(
                      fontSize: getFontSize(11),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          padding: getPadding(left: 6, right: 6, bottom: 20),
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
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(6)),
          // side: const BorderSide(
          //   color: AppColors.appDividerGray,
          //   width: 1.0,
          // ),
        ),
        child: Padding(
          padding: getPadding(left: 8, right: 8, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AppImage(
                assetName: AppResource.icUser,
                width: 75,
                height: 75,
              ),
              const SpaceWidth(mWidth: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: 'Product Name $idx',
                      size: 14,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SpaceHeight(mHeight: 3),
                    Visibility(
                      visible: controller.isInstantDelivery,
                      replacement: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildPriceText(
                              name: 'Last Price: ', amount: 180, unit: 'ltr'),
                          const SpaceHeight(mHeight: 3),
                          buildPriceText(
                              name: 'Today Price: ', amount: 65, unit: 'ltr'),
                        ],
                      ),
                      child: buildPriceText(
                          name: 'Price: ', amount: 100, unit: 'kg'),
                    ),
                    const SpaceHeight(mHeight: 5),
                    InkWell(
                      onTap: () => controller.unitAction(item, idx),
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getSize(4)),
                          side: const BorderSide(
                            color: AppColors.appDividerGray,
                            width: 1.0,
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: getPadding(
                                left: 5, right: 5, top: 2, bottom: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: controller.singleItemQty[idx],
                                  size: 11,
                                  color: controller.singleItemQty[idx] ==
                                          'Select unit'
                                      ? Colors.grey.shade600
                                      : Colors.black,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: getPrimaryColor(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (controller.isInstantDelivery) ...[
                      const SpaceHeight(mHeight: 3),
                      RichText(
                        text: TextSpan(
                          text: 'Selected Price: ',
                          style: TextStyle(
                            fontSize: getFontSize(12),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade800,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: makeCurrencyFormat(0, isRupee: true),
                              style: TextStyle(
                                fontSize: getFontSize(13),
                                fontWeight: FontWeight.bold,
                                color: getPrimaryColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  RichText buildPriceText(
      {required String name, required int amount, required String unit}) {
    return RichText(
      text: TextSpan(
        text: name,
        style: TextStyle(
          fontSize: getFontSize(12),
          fontWeight: FontWeight.normal,
          color: Colors.grey.shade800,
        ),
        children: <TextSpan>[
          TextSpan(
            text: makeCurrencyFormat(amount, isRupee: true),
            style: TextStyle(
              fontSize: getFontSize(13),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: '/$unit',
            style: TextStyle(
              fontSize: getFontSize(12),
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavigation() => Visibility(
        visible: true, //controller.totalItem.value > 0,
        child: Card(
          color: Colors.black,
          margin: getPadding(left: 10, top: 1, right: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SpaceWidth(mWidth: 10),
              AppText(
                // text: controller.totalItem.value > 1
                //     ? '${controller.totalItem.value} Items'
                //     : controller.totalItem.value == 1
                //         ? '${controller.totalItem.value} Item'
                //         : '0 Item',
                text: '0 Item',
                size: getFontSize(13),
                color: Colors.white,
              ),
              const SpaceWidth(mWidth: 15),
              const AppDivider(
                isVertical: true,
                height: 16,
              ),
              const SpaceWidth(mWidth: 15),
              AppText(
                text: makeCurrencyFormat(100, //controller.totalAmt.value,
                    isRupee: true),
                size: getFontSize(13),
                color: Colors.white,
              ),
              const Spacer(),
              AppButton(
                buttonIcon: AppResource.icCart,
                isShowLeftBtnIcon: true,
                buttonText: 'Add Cart',
                onTap: () => controller.addCartAction(),
                //isEnable: controller.isBtnEnable.isTrue,
                textSize: getFontSize(13),
                weight: FontWeight.normal,
                buttonWidth: getHorizontalSize(100),
                textColor: Colors.white,
                buttonColor: Colors.transparent,
                borderColor: Colors.transparent,
                isTransparentBorderColor: true,
                isTransparentButtonColor: true,
              )
            ],
          ),
        ),
      );
}
