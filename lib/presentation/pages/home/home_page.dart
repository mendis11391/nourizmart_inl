import '../../../../../app/utils/app_export.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
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
        ),
      );

  AddressToolBar buildAppBar() => AddressToolBar(
        onTapToolAddress: () => controller.addressAction(),
        onTapToolUser: () => controller.profileAction(),
        onTapToolCart: () => controller.cardAction(),
        onTapToolNotification: () => controller.notificationAction(),
        userName: 'User Name',
        address: 'Sector 6, HSR Layout, Bengaluru, 560102 560102 560102',
        notificationCount: controller.notificationCount,
        cartCount: controller.cartCount,
        hideCart: false,
        hideNotification: false,
      );

  Widget buildBody() => SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              buildOfferListData(),
              buildIndicator(),
              buildDiscountCard(),
              buildInstantCard(),
              if (controller.orderList.isNotEmpty) ...[
                buildOrderLabel(),
                buildOrderListBuilder(),
              ] else ...[
                orderNoData(),
              ]
            ],
          ),
        ),
      );

  Widget buildOfferListData() =>
      controller.offerList.isEmpty ? offerNoData() : buildOfferListBuilder();

  Widget offerNoData() => Visibility(
        visible: (controller.isOfferLoading.isTrue),
        replacement: const SizedBox.shrink(),
        child: buildOfferLoader(),
      );

  Widget buildOfferLoader() => Padding(
        padding: getPadding(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Card(
                  elevation: 1,
                  color: AppColors.appThemeColor.shade50,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(getSize(10)),
                      side: BorderSide(color: getPrimaryColor())),
                  child: SizedBox(
                    height: getSize(160),
                    width: getSize(290),
                  ),
                ),
                Positioned(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: getPrimaryColor(),
                        strokeWidth: getSize(2),
                      ),
                      const SpaceHeight(mHeight: 10),
                      const AppText(text: 'Please wait...', size: 16)
                    ],
                  ),
                ),
              ],
            ),
            Card(
              elevation: 1,
              color: AppColors.appThemeColor.shade50,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(getSize(10)),
                  side: BorderSide(color: getPrimaryColor())),
              child: SizedBox(
                height: getSize(160),
                width: getSize(30),
              ),
            ),
          ],
        ),
      );

  Widget buildOfferListBuilder() => Padding(
        padding: getPadding(top: 8),
        child: SizedBox(
          height: getSize(160),
          child: PageView.builder(
            controller: controller.pgController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) {
              controller.pageNo = value;
              controller.circleInx(value);
            },
            itemBuilder: ((context, index) => AnimatedBuilder(
                  animation: controller.pgController,
                  builder: (ctx, child) {
                    final String item = controller.offerList[index];
                    // return child!;
                    return buildOfferListElements(item, index);
                  },
                )),
            itemCount: controller.offerList.length,
          ),
        ),
      );

  Widget buildOfferListElements(String item, int index) => Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(getSize(10)),
            side: const BorderSide(color: Colors.orange)),
        child: AppImage(
          pictureUrl: item,
          isNetworkUrl: true,
        ),
      );

  Widget buildIndicator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.offerList.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.all(3),
            width: getSize(controller.circleInx.value == index ? 20 : 10),
            height: getSize(10),
            decoration: BoxDecoration(
                color: controller.circleInx.value == index
                    ? AppColors.appThemeColor.shade300
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(getSize(10)),
                shape: BoxShape.rectangle,
                border: Border.all(width: 1, color: getPrimaryColor())),
          ),
        ),
      );

  Widget buildDiscountCard() => Padding(
        padding: getPadding(left: 12, right: 12, top: 15),
        child: InkWell(
          onTap: () => controller.discountAction(),
          child: SizedBox(
            width: double.infinity,
            height: getSize(150),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 97, 217, 248),
                      Color(0xFF2DE48D),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(getSize(5)),
              ),
              child: Padding(
                padding: getPadding(left: 16, right: 16, top: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(getSize(40))),
                        child: AppImage(
                          assetName: AppResource.icAvatar,
                          width: getSize(45),
                          height: getSize(45),
                        ),
                      ),
                    ),
                    const SpaceHeight(mHeight: 6),
                    const AppText(
                      text: 'Discount Delivery',
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    const SpaceHeight(mHeight: 6),
                    const AppText(
                      text:
                          'Lorem ipsum dolor sit amet, consecteturadipiscing elit do eiusmod tempor.',
                      size: 13,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildInstantCard() => Padding(
        padding: getPadding(left: 12, right: 12, top: 15),
        child: InkWell(
          onTap: () => controller.instantAction(),
          child: SizedBox(
            width: double.infinity,
            height: getSize(150),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00CCFF),
                      Color(0xFF3366FF),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(getSize(5)),
              ),
              child: Padding(
                padding: getPadding(left: 16, right: 16, top: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(getSize(40))),
                        child: AppImage(
                          assetName: AppResource.icAvatar,
                          width: getSize(45),
                          height: getSize(45),
                        ),
                      ),
                    ),
                    const SpaceHeight(mHeight: 6),
                    const AppText(
                      text: 'Instant Delivery',
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    const SpaceHeight(mHeight: 6),
                    const AppText(
                      text:
                          'Lorem ipsum dolor sit amet, consecteturadipiscing elit do eiusmod tempor.',
                      size: 13,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildOrderLabel() => Padding(
        padding: getPadding(left: 12, right: 12, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText(
              text: 'My Orders',
              size: 20,
              weight: FontWeight.bold,
            ),
            AppButton(
              buttonHeight: getSize(28),
              buttonWidth: getSize(75),
              buttonText: 'See More',
              borderColor: getPrimaryColor(),
              textColor: getPrimaryColor(),
              buttonColor: Colors.white,
              borderRadius: getSize(5),
              textSize: getFontSize(12),
              onTap: () => controller.seeMoreAction(),
            ),
          ],
        ),
      );

  // Widget buildOrderListData() =>
  //     controller.orderList.isEmpty ? orderNoData() : buildOrderListBuilder();

  Widget orderNoData() => Visibility(
        visible: (controller.isOrderLoading.isTrue),
        replacement: const SizedBox.shrink(),
        child: const AppCircularProgress(),
      );

  Widget buildOrderListBuilder() => Padding(
        padding: getPadding(top: 8, bottom: 30),
        child: SizedBox(
          height: getSize(120),
          child: ListView.builder(
            controller: controller.orderScrollController,
            // padding: getPadding(top: 10, bottom: 10),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            itemCount: controller.orderList.length,
            itemBuilder: (context, idx) {
              final String item = controller.orderList[idx];
              return buildOrderListElements(item, idx);
            },
          ),
        ),
      );

  Widget buildOrderListElements(String item, int index) => SizedBox(
        width: getSize(300),
        child: Padding(
          padding: getPadding(left: 6, right: (index != 2) ? 2 : 0),
          child: InkWell(
            onTap: () => controller.orderAction(index),
            child: Card(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(getSize(10)),
                  side: BorderSide(color: Colors.grey.shade600)),
              child: Padding(
                padding: getPadding(all: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              text: 'Date',
                              size: 14,
                              color: Colors.grey.shade700,
                            ),
                            const SpaceHeight(mHeight: 3),
                            AppText(
                              text: index == 0
                                  ? '12/02/2024'
                                  : index == 1
                                      ? '08/01/2024'
                                      : '06/12/2023',
                              size: 14,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              text: 'Amount',
                              size: 14,
                              color: Colors.grey.shade700,
                            ),
                            const SpaceHeight(mHeight: 3),
                            AppText(
                              text: index == 0
                                  ? '₹1,040'
                                  : index == 1
                                      ? '₹680'
                                      : '₹842',
                              size: 14,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SpaceHeight(mHeight: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              text: 'Order Number',
                              size: 14,
                              color: Colors.grey.shade700,
                            ),
                            const SpaceHeight(mHeight: 3),
                            AppText(
                              text: index == 0
                                  ? 'ASF545MJ89'
                                  : index == 1
                                      ? 'GDF385MJY7'
                                      : 'QCF245UI95',
                              size: 14,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              text: 'Status',
                              size: 14,
                              color: Colors.grey.shade700,
                            ),
                            const SpaceHeight(mHeight: 3),
                            AppText(
                              text: index == 0
                                  ? 'Delivered'
                                  : index == 1
                                      ? 'Pending'
                                      : 'Cancelled',
                              size: 14,
                              weight: FontWeight.bold,
                              color: getOrderStatusColor(index == 0
                                  ? 'Delivered'
                                  : index == 1
                                      ? 'Pending'
                                      : 'Cancelled'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
