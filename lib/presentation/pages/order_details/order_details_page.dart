import '../../../../../app/utils/app_export.dart';
import 'order_details_controller.dart';

class OrderDetailsPage extends GetView<OrderDetailsController> {
  const OrderDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(() => buildScreen());
  }

  Widget buildScreen() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => hideKeyBoardFocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
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
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          slivers: <Widget>[
            buildHeader(),
            buildListSection(),
          ],
        ),
      );

  Widget buildHeader() => SliverToBoxAdapter(
        child: SizedBox(
          height: getSize(220),
          child: Padding(
            padding: getPadding(left: 14, right: 14, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                customRowText(
                    'OrderNumber', 'ASF545MJ89', 'Status', 'Delivered'),
                const SpaceHeight(mHeight: 12),
                customRowText(
                    'Order Date', '06/01/2024', 'Delivered Date', '06/01/2024'),
                const SpaceHeight(mHeight: 12),
                buildAddress(),
                buildPayment(),
                const Spacer(),
                const AppDivider(height: 1),
              ],
            ),
          ),
        ),
      );

  Widget buildListSection() =>
      controller.responseList.isEmpty ? loadingNoData() : buildListBuilder();

  Widget loadingNoData() => SliverFillRemaining(
        child: Visibility(
          visible: (controller.showLoadingStyle.value ==
                  ApiCallLoadingTypeEnum.circularProgress ||
              controller.showLoadingStyle.value ==
                  ApiCallLoadingTypeEnum.search),
          replacement: controller.isLoading.isFalse
              ? const AppNoDataFound()
              : const SizedBox.shrink(),
          child: const AppCircularProgress(),
        ),
      );

  Widget buildListBuilder() => SliverPadding(
        padding: getPadding(left: 14, right: 14, bottom: 20),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: controller.responseList.length,
            (BuildContext context, int idx) {
              if (idx == (controller.responseList.length - 1) &&
                  controller.isLoadMoreApi.isTrue) {
                return const AppLoadMore();
              } else {
                final String item = controller.responseList[idx];
                return buildListElements(item, idx);
              }
            },
          ),
        ),
      );

  Widget buildListElements(String item, int idx) => ListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        title: AppText(
          text: 'Product Name $idx',
          size: 13,
        ),
        subtitle: AppText(
          text: '(1.2kg X ₹45)',
          size: 13,
          color: Colors.grey.shade700,
        ),
        trailing: AppText(
          text: '₹45$idx',
          size: 13,
        ),
      );

  Widget customRowText(
          String key1, String value1, String key2, String value2) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: key1,
                size: 13,
                color: Colors.grey.shade700,
              ),
              const SpaceHeight(mHeight: 3),
              AppText(
                text: value1,
                size: 13,
                weight: FontWeight.bold,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: key2,
                size: 13,
                color: Colors.grey.shade700,
              ),
              const SpaceHeight(mHeight: 3),
              AppText(
                text: value2,
                size: 13,
                weight: FontWeight.bold,
              ),
            ],
          ),
        ],
      );

  Widget buildAddress() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            text: 'Delivered to',
            size: 13,
            color: Colors.grey.shade700,
          ),
          const SpaceHeight(mHeight: 3),
          const AppText(
            text:
                '3rd Floor, Sector 6, HSR Layout, Bangalore, Karnataka - 560102',
            size: 13,
            weight: FontWeight.bold,
          ),
        ],
      );

  Widget buildPayment() => ListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        title: AppText(
          text: 'Payment Method',
          size: 13,
          color: Colors.grey.shade700,
        ),
        subtitle: const AppText(
          text: 'G Pay',
          size: 13,
          weight: FontWeight.bold,
        ),
        trailing: const AppText(
          text: '8 Items',
          size: 13,
          weight: FontWeight.bold,
        ),
      );

  Widget buildBottomNavigation() => DecoratedBox(
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
          padding: getPadding(left: 10, right: 10, top: 5, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: getPrimaryColor(),
                  highlightColor: AppColors.appThemeColor.shade100,
                  onTap: () => controller.visibleAmountDetails(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: getSize(25),
                        width: getSize(25),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1, color: Colors.green.shade100),
                        ),
                        child: RotatedBox(
                          quarterTurns:
                              (controller.isShowAmtDetails.isTrue ? 90 : 0),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            // size: getSize(20),
                            color: getPrimaryColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: getPadding(top: 2, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      text: 'Paid',
                      size: 14,
                      weight: FontWeight.bold,
                    ),
                    AppText(
                      text: makeCurrencyFormat(controller.totalAmt.value,
                          isRupee: true),
                      size: 14,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: (controller.isShowAmtDetails.isTrue &&
                      validDouble(controller.allProductAmt.value) > 0),
                  child: amountRow(getVerticalSize(2), 'Item Total',
                      controller.allProductAmt.value)),
              Visibility(
                  visible: (controller.isShowAmtDetails.isTrue &&
                      validDouble(controller.deliveryAmt.value) > 0),
                  child: amountRow(getVerticalSize(2), 'Delivery charge',
                      controller.deliveryAmt.value)),
              Visibility(
                  visible: (controller.isShowAmtDetails.isTrue &&
                      validDouble(controller.tax.value) > 0),
                  child: amountRow(
                      getVerticalSize(2), 'Tax', controller.tax.value)),
              Visibility(
                  visible: (controller.isShowAmtDetails.isTrue &&
                      validDouble(controller.confirmationAmt.value) > 0),
                  child: amountRow(getVerticalSize(2), 'Confirmation charge',
                      controller.confirmationAmt.value)),
              Visibility(
                  visible: controller.isShowAmtDetails.isTrue,
                  child: SizedBox(height: getVerticalSize(2))),
              Visibility(
                visible: controller.isShowAmtDetails.isTrue,
                child: AppDivider(height: getSize(16)),
              ),
              Visibility(
                visible: (controller.isShowAmtDetails.isTrue),
                child: AppText(
                  text: '*TBD - To Be Decided',
                  size: 13,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
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
}
