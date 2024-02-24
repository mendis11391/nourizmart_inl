import '../../../../../app/utils/app_export.dart';
import 'order_list_controller.dart';

class OrderListPage extends GetView<OrderListController> {
  const OrderListPage({super.key});
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
          padding: getPadding(left: 6, right: 6, top: 15, bottom: 20),
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

  Widget buildListElements(String item, int idx) => InkWell(
        onTap: () => controller.submitAction(idx),
        child: Card(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getSize(10)),
              side: BorderSide(color: Colors.grey.shade400)),
          child: Padding(
            padding: getPadding(all: 10),
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
                          size: 13,
                          color: Colors.grey.shade700,
                        ),
                        const SpaceHeight(mHeight: 3),
                        AppText(
                          text: idx == 0
                              ? '12/02/2024'
                              : idx == 1
                                  ? '08/01/2024'
                                  : '06/12/2023',
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
                          text: 'Amount',
                          size: 13,
                          color: Colors.grey.shade700,
                        ),
                        const SpaceHeight(mHeight: 3),
                        AppText(
                          text: idx == 0
                              ? '₹1,040'
                              : idx == 1
                                  ? '₹680'
                                  : '₹842',
                          size: 13,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
                const SpaceHeight(mHeight: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          text: 'Order Number',
                          size: 13,
                          color: Colors.grey.shade700,
                        ),
                        const SpaceHeight(mHeight: 3),
                        AppText(
                          text: idx == 0
                              ? 'ASF545MJ89'
                              : idx == 1
                                  ? 'GDF385MJY7'
                                  : 'QCF245UI95',
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
                          text: 'Status',
                          size: 13,
                          color: Colors.grey.shade700,
                        ),
                        const SpaceHeight(mHeight: 3),
                        AppText(
                          text: idx == 0
                              ? 'Delivered'
                              : idx == 1
                                  ? 'Pending'
                                  : 'Cancelled',
                          size: 13,
                          weight: FontWeight.bold,
                          color: getOrderStatusColor(idx == 0
                              ? 'Delivered'
                              : idx == 1
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
      );
}
