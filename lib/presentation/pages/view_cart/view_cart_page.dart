import '../../../../../app/utils/app_export.dart';
import 'view_cart_controller.dart';

class ViewCartPage extends GetView<ViewCartController> {
  const ViewCartPage({super.key});
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

  AppToolBar buildAppBar() => AppToolBar(
        title: controller.title.value,
        onToolBackPressed: () => controller.backValidationAction(),
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

  Widget buildDeliveryOptionSection() => Visibility(
        visible: !controller.isInstantDelivery,
        replacement: const SpaceHeight(mHeight: 15),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RadioListTile<int>(
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  title: AppText(
                    text: 'Home Delivery',
                    size: 13,
                    weight: (controller.selectedPick.value == 0)
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: (controller.selectedPick.value == 0)
                        ? getPrimaryColor()
                        : Colors.grey,
                  ),
                  value: 0,
                  groupValue: controller.selectedPick.value,
                  onChanged: (int? value) =>
                      controller.selectedPick.value = validInt(value),
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return getPrimaryColor();
                    }
                    return Colors.grey;
                  }),
                ),
              ),
              const SpaceWidth(mWidth: 10),
              Expanded(
                child: RadioListTile<int>(
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: 0),
                  title: AppText(
                    text: 'Self Picking',
                    size: 13,
                    weight: (controller.selectedPick.value == 1)
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: (controller.selectedPick.value == 1)
                        ? getPrimaryColor()
                        : Colors.grey,
                  ),
                  value: 1,
                  groupValue: controller.selectedPick.value,
                  onChanged: (int? value) =>
                      controller.selectedPick.value = validInt(value),
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return getPrimaryColor();
                    }
                    return Colors.grey;
                  }),
                ),
              ),
              const SpaceWidth(mWidth: 50),
            ],
          ),
        ),
      );

  Widget buildDeliveryAddressSection() => Visibility(
        visible: controller.selectedPick.value == 0,
        child: Card(
          elevation: 0,
          margin: getMargin(left: 10, right: 10, bottom: 10),
          color: AppColors.appThemeColor.shade50,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: getPrimaryColor(), width: 1),
            borderRadius: BorderRadius.circular(
              getSize(10),
            ),
          ),
          child: Padding(
            padding: getPadding(all: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  text: 'Delivery Address',
                  size: 15,
                  weight: FontWeight.bold,
                ),
                Card(
                  elevation: 0,
                  margin: getMargin(top: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      getSize(6),
                    ),
                  ),
                  child: Padding(
                    padding: getPadding(all: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: AppText(
                            text:
                                'No: 26, 3rd Floor, Sector 16, HSR Layout, Bangalore, Karnataka - 560105',
                            size: 13,
                          ),
                        ),
                        const SpaceWidth(mWidth: 5),
                        AppButton(
                            buttonText: 'Change',
                            buttonHeight: getVerticalSize(24),
                            buttonWidth: getHorizontalSize(65),
                            borderRadius: getSize(6),
                            weight: FontWeight.normal,
                            textSize: getFontSize(13),
                            onTap: () => controller.changeAddressAction())
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildStoreAddressSection() => Visibility(
        visible: controller.selectedPick.value == 1,
        child: Card(
          elevation: 0,
          margin: getMargin(left: 10, right: 10, bottom: 10),
          color: const Color(0xFFE7F6EF),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: getPrimaryColor(), width: 1),
            borderRadius: BorderRadius.circular(
              getSize(10),
            ),
          ),
          child: Padding(
            padding: getPadding(all: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  text: 'Picking Address',
                  size: 15,
                  weight: FontWeight.bold,
                ),
                Card(
                  elevation: 0,
                  margin: getMargin(top: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      getSize(6),
                    ),
                  ),
                  child: Padding(
                    padding: getPadding(all: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => controller.storePincodeAction(),
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
                                    left: 5, right: 5, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: controller.storePincode.value,
                                      size: 11,
                                      color: controller.storePincode.value ==
                                              'Select Pincode'
                                          ? Colors.grey.shade600
                                          : Colors.black,
                                      weight: controller.storePincode.value ==
                                              'Select Pincode'
                                          ? FontWeight.normal
                                          : FontWeight.bold,
                                    ),
                                    controller.loadingPincode.isTrue
                                        ? dropLoader()
                                        : dropArrow()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SpaceHeight(mHeight: 5),
                        const AppText(
                          text:
                              '* If change pin code product price might be change',
                          size: 13,
                          color: Colors.pink,
                        ),
                        const SpaceHeight(mHeight: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: AppText(
                                text:
                                    'No: 26, 3rd Floor, Sector 16, HSR Layout, Bangalore, Karnataka - 560105',
                                size: 13,
                              ),
                            ),
                            const SpaceWidth(mWidth: 5),
                            AppButton(
                                buttonText: 'Change',
                                buttonHeight: getVerticalSize(24),
                                buttonWidth: getHorizontalSize(65),
                                borderRadius: getSize(6),
                                weight: FontWeight.normal,
                                textSize: getFontSize(13),
                                onTap: () =>
                                    controller.changeStoreAddressAction())
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildEditCartSection() => Padding(
        padding: getPadding(left: 10, right: 10, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Expanded(
              child: AppText(
                text: 'Cart Products',
                size: 15,
                weight: FontWeight.bold,
              ),
            ),
            const SpaceWidth(mWidth: 10),
            AppButton(
                buttonText: 'Save',
                isEnable: controller.isAllowEditing.isFalse,
                buttonHeight: getVerticalSize(22),
                buttonWidth: getHorizontalSize(50),
                borderRadius: getSize(5),
                weight: FontWeight.normal,
                textSize: getFontSize(13),
                onTap: () => controller.saveAction()),
            const SpaceWidth(mWidth: 10),
            AppButton(
                buttonText: 'Edit',
                isEnable: controller.isAllowEditing.isTrue,
                buttonHeight: getVerticalSize(22),
                buttonWidth: getHorizontalSize(50),
                borderRadius: getSize(5),
                weight: FontWeight.normal,
                textSize: getFontSize(13),
                onTap: () => controller.editAction()),
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
          padding: getPadding(right: 5, bottom: 20),
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
              if (idx == 0) {
                return Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildDeliveryOptionSection(),
                      buildDeliveryAddressSection(),
                      buildStoreAddressSection(),
                      buildEditCartSection(),
                      buildListElements(item, idx),
                    ],
                  ),
                );
              } else {
                return buildListElements(item, idx);
              }
            }
          },
          separatorBuilder: (BuildContext context, int index) => AppDivider(
            color: Colors.transparent,
            height: getSize(5),
            // thickness: getSize(1),
          ),
        ),
      );

  Widget buildListElements(String item, int idx) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: getVerticalSize(38),
            child: InkWell(
              onTap: () => controller.deleteAction(item, idx),
              child: Padding(
                padding: getPadding(all: 5),
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.pink,
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              elevation: 0,
              clipBehavior: Clip.hardEdge,
              margin: getMargin(right: 4, top: 3, bottom: 3),
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
                                    name: 'Last Price: ',
                                    amount: 180,
                                    unit: 'ltr'),
                                const SpaceHeight(mHeight: 3),
                                buildPriceText(
                                    name: 'Today Price: ',
                                    amount: 65,
                                    unit: 'ltr'),
                              ],
                            ),
                            child: buildPriceText(
                                name: 'Price: ', amount: 100, unit: 'kg'),
                          ),
                          const SpaceHeight(mHeight: 5),
                          InkWell(
                            onTap: controller.isAllowEditing.isFalse
                                ? () => controller.unitAction(item, idx)
                                : null,
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 0,
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(getSize(4)),
                                side: BorderSide(
                                  color: controller.isAllowEditing.isFalse
                                      ? AppColors.appDividerGray
                                      : Colors.grey.shade200,
                                  width: 1.0,
                                ),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: getPadding(
                                      left: 5, right: 5, top: 2, bottom: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: controller.singleItemQty[idx],
                                        size: 11,
                                        color: controller.singleItemQty[idx] ==
                                                'Select unit'
                                            ? Colors.grey.shade600
                                            : Colors.black,
                                      ),
                                      Visibility(
                                        visible:
                                            controller.isAllowEditing.isFalse,
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        child: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: getPrimaryColor(),
                                        ),
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
            ),
          ),
        ],
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

  Widget buildBottomNavigation() => Obx(
        () => DecoratedBox(
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(getSize(40))),
              ),
              shadows: [
                BoxShadow(
                  color: Colors.black.withAlpha(55),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -3),
                ),
              ]),
          child: Padding(
            padding: getPadding(all: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: 0),
                  title: AppText(
                    text: validString(controller.userName.value),
                    size: 12,
                    weight: FontWeight.bold,
                  ),
                  subtitle: AppText(
                    text: validString(controller.mobile.value),
                    size: 12,
                    color: Colors.grey.shade700,
                  ),
                  trailing: Visibility(
                    visible: (controller.isInstantDelivery ||
                        (validDouble(controller.confirmationAmt.value) > 0 &&
                            validDouble(controller.allProductAmt.value) > 0)),
                    child: RotatedBox(
                      quarterTurns: (controller.isVisibleAmt.isTrue ? 90 : 0),
                      child: CircleAvatar(
                        radius: getSize(14),
                        backgroundColor: Colors.green.shade100,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: getSize(20),
                          color: getPrimaryColor(),
                        ),
                      ),
                    ),
                  ),
                  onTap: (!controller.isInstantDelivery &&
                          validDouble(controller.allProductAmt.value) <= 0)
                      ? null
                      : () => controller.visibleAmountDetails(),
                ),
                Visibility(
                  visible: (!controller.isInstantDelivery &&
                      validDouble(controller.confirmationAmt.value) > 0 &&
                      validDouble(controller.allProductAmt.value) > 0),
                  child: amountRow(getVerticalSize(2), 'Confirmation charge',
                      controller.confirmationAmt.value),
                ),
                Visibility(
                    visible: (controller.isVisibleAmt.isTrue &&
                        validDouble(controller.allProductAmt.value) > 0),
                    child: amountRow(getVerticalSize(2), 'Total',
                        controller.allProductAmt.value)),
                Visibility(
                    visible: (controller.isVisibleAmt.isTrue &&
                        validDouble(controller.deliveryAmt.value) > 0),
                    child: amountRow(getVerticalSize(2), 'Delivery charge',
                        controller.deliveryAmt.value)),
                Visibility(
                    visible: (controller.isVisibleAmt.isTrue &&
                        validDouble(controller.tax.value) > 0),
                    child: amountRow(
                        getVerticalSize(2), 'Tax', controller.tax.value)),
                Visibility(
                    visible: controller.isVisibleAmt.isTrue,
                    child: SizedBox(height: getVerticalSize(2))),
                AppDivider(
                  height: getSize(1),
                  thickness: getSize(1),
                ),
                Visibility(
                  visible: controller.isInstantDelivery,
                  replacement: validDouble(controller.allProductAmt.value) > 0
                      ? amountRow(getVerticalSize(8), 'Invoice Value',
                          controller.totalAmt.value,
                          weight: FontWeight.bold, size: 14)
                      : amountRow(getVerticalSize(8), 'Confirmation charge',
                          controller.confirmationAmt.value,
                          weight: FontWeight.bold, size: 14),
                  child: amountRow(getVerticalSize(8), 'Invoice Value',
                      controller.totalAmt.value,
                      weight: FontWeight.bold, size: 14),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppButton(
                        textSize: getFontSize(14),
                        buttonText: 'Order More',
                        borderRadius: getSize(5),
                        buttonColor: Colors.transparent,
                        borderColor: getPrimaryColor(),
                        isTransparentButtonColor: true,
                        textColor: getPrimaryColor(),
                        weight: FontWeight.bold,
                        onTap: () => controller.backValidationAction(),
                      ),
                    ),
                    SizedBox(width: getHorizontalSize(8)),
                    Expanded(
                      child: AppButton(
                        isEnable: controller.isBtnEnable.isTrue,
                        textSize: getFontSize(14),
                        buttonText: 'Submit',
                        borderRadius: getSize(5),
                        weight: FontWeight.bold,
                        onTap: () => controller.submitAction(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget amountRow(double pad, String name, double amt,
          {FontWeight weight = FontWeight.normal, double size = 12}) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: pad),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: name,
              size: size,
            ),
            AppText(
              text: makeCurrencyFormat(amt, isRupee: true),
              size: size,
              weight: weight,
            ),
          ],
        ),
      );

  Widget dropArrow() => Icon(
        Icons.keyboard_arrow_down_rounded,
        color: getPrimaryColor(),
        // size: getSize(25),
      );

  Widget dropLoader() => SizedBox(
        width: getSize(21),
        height: getSize(21),
        child: CircularProgressIndicator(
          color: getPrimaryColor(),
          strokeWidth: getSize(2),
        ),
      );

  /* Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: getSize(15),
            height: getSize(15),
            child: CircularProgressIndicator(
              color: getPrimaryColor(),
              strokeWidth: getSize(2),
            ),
          ),
        ],
      ); */
}
