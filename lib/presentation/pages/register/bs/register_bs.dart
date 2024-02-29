import '../../../../../../app/utils/app_export.dart';
import '../register_controller.dart';

class RegisterBottomSheet extends StatelessWidget {
  final RegisterController controller;
  final List<String> listItem;
  final VoidCallback onTapClose;
  // final Function(String item) onTapSelect;
  final DropDownType dropDownType;
  final String previousSelect;

  const RegisterBottomSheet({
    super.key,
    required this.controller,
    required this.listItem,
    required this.onTapClose,
    // required this.onTapSelect,
    required this.dropDownType,
    required this.previousSelect,
  });

  @override
  Widget build(BuildContext context) {
    controller.selectedCurrentItem.value = previousSelect;
    return PopScope(
      canPop: false,
      child: Obx(
        () => SizedBox(
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
                      AppText(
                        text: getTitle(),
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
        child: ListView.separated(
          controller: controller.dropdownScrollController,
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
        groupValue: controller.selectedCurrentItem.value, //getGroupValue(),
        selected: controller.selectedCurrentItem.value ==
            validString(item), //getGroupValue() == validString(item),
        onChanged: (value) {
          controller.selectedCurrentItem.value = validString(value);
          // if (dropDownType == DropDownType.state) {
          //   selectedItem = validString(value);
          // } else if (dropDownType == DropDownType.district) {
          //   controller.selectedDistrict.value = validString(value);
          // } else if (dropDownType == DropDownType.pincode) {
          //   controller.selectedPincode.value = validString(value);
          // } else {
          //   controller.selectedArea.value = validString(value);
          // }
        },
      );

  Widget buildBtn() => AppButton(
        //onTap: onTapSelect(getGroupValue()),
        // onTap: onTapSelect(controller.selectedCurrentItem.value),
        onTap: () => Get.back(result: controller.selectedCurrentItem.value),
        isEnable: previousSelect !=
            controller.selectedCurrentItem.value, // checkEnableBtn(),
        buttonText: 'Select',
        buttonHeight: getVerticalSize(35),
        textSize: getFontSize(14),
        borderRadius: getSize(5),
        borderColor: getPrimaryColor(),
        buttonColor: getPrimaryColor(),
      );

  String getTitle() {
    String name = dropDownType == DropDownType.state
        ? 'state'
        : dropDownType == DropDownType.district
            ? 'district'
            : dropDownType == DropDownType.pincode
                ? 'pincode'
                : 'area';
    return 'Select your $name';
  }

  // String getGroupValue() {
  //   return dropDownType == DropDownType.state
  //       ? controller.selectedState.value
  //       : dropDownType == DropDownType.district
  //           ? controller.selectedDistrict.value
  //           : dropDownType == DropDownType.pincode
  //               ? controller.selectedPincode.value
  //               : controller.selectedArea.value;
  // }

  // bool checkEnableBtn() {
  //   if (dropDownType == DropDownType.state) {
  //     return previousSelect != controller.selectedState.value;
  //   } else if (dropDownType == DropDownType.district) {
  //     return previousSelect != controller.selectedDistrict.value;
  //   } else if (dropDownType == DropDownType.pincode) {
  //     return previousSelect != controller.selectedPincode.value;
  //   } else {
  //     return previousSelect != controller.selectedArea.value;
  //   }
  // }
}
