import '../../../../../../app/utils/app_export.dart';
import '../view_cart_controller.dart';

class PincodeBottomSheet extends StatelessWidget {
  final ViewCartController controller;
  final List<String> listItem;
  final VoidCallback onTapClose;
  final String previousSelect;

  const PincodeBottomSheet({
    super.key,
    required this.controller,
    required this.listItem,
    required this.onTapClose,
    required this.previousSelect,
  });

  @override
  Widget build(BuildContext context) {
    controller.tempPincode.value = previousSelect;
    return PopScope(
      canPop: false,
      child:/*  Obx(
        () => */ SizedBox(
          height: getDeviceHeight() *
              (listItem.length < 3
                  ? 0.40
                  : listItem.length < 5
                      ? 0.50
                      : 0.70),
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
                        text: 'Select your pincode',
                        size: 16,
                        weight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                      buildListBuilder(),
                      const SpaceHeight(mHeight: 20),
                      // buildBtn(),
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
      // ),
    );
  }

  Widget buildListBuilder() => Expanded(
        child: ListView.separated(
          controller: controller.pincodeScrollController,
          padding: getPadding(left: 6, top: 6, right: 10, bottom: 20),
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          itemCount: listItem.length,
          itemBuilder: (context, idx) {
            final String item = listItem[idx];
            return buildListElements(item, idx);
          },
          separatorBuilder: (BuildContext context, int index) => AppDivider(
            // color: Colors.transparent,
            height: getSize(1),
            // thickness: getSize(1),
          ),
        ),
      );

  Widget buildListElements(String item, int idx) => RadioListTile(
        title: Text(validString(item)),
        value: validString(item),
        groupValue: controller.tempPincode.value,
        selected: controller.tempPincode.value == validString(item),
        onChanged: (value) {
          if (!isFieldEmpty(value)) {
            controller.tempPincode.value = validString(value);
            Get.back(result: controller.tempPincode.value);
          }
        },
      );

  // Widget buildBtn() => AppButton(

  //       onTap: () => Get.back(result: controller.selectedCurrentItem.value),
  //       isEnable: previousSelect !=
  //           controller.selectedCurrentItem.value, // checkEnableBtn(),
  //       buttonText: 'Select',
  //       buttonHeight: getVerticalSize(35),
  //       textSize: getFontSize(14),
  //       borderRadius: getSize(5),
  //       borderColor: getPrimaryColor(),
  //       buttonColor: getPrimaryColor(),
  //     );
}
