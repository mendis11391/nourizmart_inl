import '../../../../../app/utils/app_export.dart';
import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});
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
        hideBack: true,
        isCenterTitle: true,
        onToolBackPressed: () => controller.backValidationAction(),
      );

  Widget buildBody() => SafeArea(
        child: Form(
          onChanged: () => controller.validator(),
          key: controller.registerFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: getPadding(left: 7, right: 7, top: 10, bottom: 30),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      getSize(10),
                    ),
                  ),
                  child: Padding(
                    padding: getPadding(all: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const AppText(
                            text: 'Contact Details',
                            size: 17,
                            weight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            controller: controller.lnController,
                            label: '*First Name',
                            isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.name,
                            inputAction: TextInputAction.next,
                            onFieldSubmitted: (_) =>
                                FocusScope.of(navigatorKey.currentContext!)
                                    .requestFocus(controller.lnFocusNode),
                            focusNode: controller.fnFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icUser,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: isFieldEmpty(controller.getLn)
                                ? const SizedBox.shrink()
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => controller.clearLnText(),
                                  ),
                            onChanged: (value) => controller.onChangedLn(value),
                            validator: (value) =>
                                isFieldEmpty(controller.lnController.text)
                                    ? 'Enter first name'
                                    : null,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            controller: controller.fnController,
                            label: '*Last Name',
                            isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.name,
                            inputAction: TextInputAction.next,
                            onFieldSubmitted: (_) =>
                                FocusScope.of(navigatorKey.currentContext!)
                                    .requestFocus(controller.houseFocusNode),
                            focusNode: controller.lnFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icUser,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: isFieldEmpty(controller.getFn)
                                ? const SizedBox.shrink()
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => controller.clearFnText(),
                                  ),
                            onChanged: (value) => controller.onChangedFn(value),
                            validator: (value) =>
                                isFieldEmpty(controller.fnController.text)
                                    ? 'Enter last name'
                                    : null,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            enabled: false,
                            showCursor: false,
                            controller: controller.mobController,
                            label: '*Mobile', isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.phone,
                            inputAction: TextInputAction.next,
                            // onFieldSubmitted: (_) =>
                            //     FocusScope.of(navigatorKey.currentContext!)
                            //         .requestFocus(controller.houseFocusNode),
                            focusNode: controller.mobFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icMobile,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: isFieldEmpty(controller.getMob)
                                ? const SizedBox.shrink()
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => controller.clearMobText(),
                                  ),
                            onChanged: (value) =>
                                controller.onChangedMob(value),
                            validator: (value) =>
                                isFieldEmpty(controller.mobController.text)
                                    ? 'Enter mobile number'
                                    : null,
                          ),
                        ]),
                  ),
                ),
                const SpaceHeight(mHeight: 15),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      getSize(10),
                    ),
                  ),
                  child: Padding(
                    padding: getPadding(all: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const AppText(
                            text: 'Address Details',
                            size: 17,
                            weight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            controller: controller.houseController,
                            label: '*House No',
                            isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.streetAddress,
                            inputAction: TextInputAction.next,
                            onFieldSubmitted: (_) =>
                                FocusScope.of(navigatorKey.currentContext!)
                                    .requestFocus(controller.streetFocusNode),
                            focusNode: controller.houseFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icHouse,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: isFieldEmpty(controller.getHouseNo)
                                ? const SizedBox.shrink()
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () =>
                                        controller.clearHouseNoText(),
                                  ),
                            onChanged: (value) =>
                                controller.onChangedHouseNo(value),
                            validator: (value) =>
                                isFieldEmpty(controller.houseController.text)
                                    ? 'Enter house no'
                                    : null,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            controller: controller.streetController,
                            label: '*Street',
                            isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.streetAddress,
                            inputAction: TextInputAction.next,
                            onFieldSubmitted: (_) =>
                                FocusScope.of(navigatorKey.currentContext!)
                                    .requestFocus(controller.stateFocusNode),
                            focusNode: controller.streetFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icStreet,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: isFieldEmpty(controller.getStreet)
                                ? const SizedBox.shrink()
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => controller.clearStreet(),
                                  ),
                            onChanged: (value) =>
                                controller.onChangedStreet(value),
                            validator: (value) =>
                                isFieldEmpty(controller.streetController.text)
                                    ? 'Enter street'
                                    : null,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            controller: controller.stateController,
                            enabled: controller.isEnableState.isTrue,
                            label: '*State',
                            isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.name,
                            inputAction: TextInputAction.done,
                            // onFieldSubmitted: (_) =>
                            //     FocusScope.of(navigatorKey.currentContext!)
                            //         .requestFocus(controller.districtFocusNode),
                            focusNode: controller.stateFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icState,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: controller.loadingState.isTrue
                                ? dropLoader()
                                : dropArrow(),
                            // onChanged: (value) => controller.onChangedState(value),
                            showCursor: false,
                            readOnly: true,
                            onTap: () => controller.stateAction(),
                            validator: (value) =>
                                isFieldEmpty(controller.stateController.text)
                                    ? 'Enter State'
                                    : null,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            controller: controller.districtController,
                            enabled: controller.isEnableDistrict.isTrue,
                            label: '*District',
                            isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.name,
                            inputAction: TextInputAction.done,
                            // onFieldSubmitted: (_) =>
                            //     FocusScope.of(navigatorKey.currentContext!)
                            //         .requestFocus(controller.districtFocusNode),
                            focusNode: controller.districtFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icDistrict,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: controller.loadingDistrict.isTrue
                                ? dropLoader()
                                : dropArrow(),
                            // onChanged: (value) => controller.onChangedDistrict(value),
                            showCursor: false,
                            readOnly: true,
                            onTap: () => controller.districtAction(),
                            validator: (value) =>
                                isFieldEmpty(controller.districtController.text)
                                    ? 'Enter district'
                                    : null,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            controller: controller.pincodeController,
                            enabled: controller.isEnablePincode.isTrue,
                            label: '*Pincode',
                            isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.name,
                            inputAction: TextInputAction.done,
                            // onFieldSubmitted: (_) =>
                            //     FocusScope.of(navigatorKey.currentContext!)
                            //         .requestFocus(controller.districtFocusNode),
                            focusNode: controller.pincodeFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icPincode,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: controller.loadingPincode.isTrue
                                ? dropLoader()
                                : dropArrow(),
                            // onChanged: (value) => controller.onChangedPincode(value),
                            showCursor: false,
                            readOnly: true,
                            onTap: () => controller.pincodeAction(),
                            validator: (value) =>
                                isFieldEmpty(controller.pincodeController.text)
                                    ? 'Enter Pincode'
                                    : null,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            controller: controller.areaController,
                            enabled: controller.isEnableArea.isTrue,
                            label: '*Area',
                            isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.name,
                            inputAction: TextInputAction.done,
                            // onFieldSubmitted: (_) =>
                            //     FocusScope.of(navigatorKey.currentContext!)
                            //         .requestFocus(controller.districtFocusNode),
                            focusNode: controller.areaFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icArea,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: controller.loadingArea.isTrue
                                ? dropLoader()
                                : dropArrow(),
                            // onChanged: (value) => controller.onChangedArea(value),
                            showCursor: false,
                            readOnly: true,
                            onTap: () => controller.areaAction(),
                            validator: (value) =>
                                isFieldEmpty(controller.areaController.text)
                                    ? 'Enter Area'
                                    : null,
                          ),
                          const SpaceHeight(mHeight: 10),
                          AppTextField(
                            controller: controller.landController,
                            label: 'Landmark',
                            isDense: true,
                            verticalPadding: getSize(10),
                            fillColor: AppColors.appThemeColor.shade50,
                            enabledBorderColor: getPrimaryColor(),
                            keyboardType: TextInputType.streetAddress,
                            inputAction: TextInputAction.done,
                            focusNode: controller.landFocusNode,
                            textCapitalization: TextCapitalization.sentences,
                            prefix: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage(
                                  assetName: AppResource.icLand,
                                  width: getSize(26),
                                  height: getSize(27),
                                ),
                              ],
                            ),
                            suffix: isFieldEmpty(controller.getLand)
                                ? const SizedBox.shrink()
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => controller.clearLand(),
                                  ),
                            onChanged: (value) =>
                                controller.onChangedLand(value),
                            // validator: (value) =>
                            //     isFieldEmpty(controller.landController.text)
                            //         ? 'Enter Landmark'
                            //         : null,
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget dropArrow() => Icon(
        Icons.keyboard_arrow_down_rounded,
        color: getPrimaryColor(),
        size: getSize(25),
      );

  Widget dropLoader() => Row(
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
      );

  Widget buildBottomNavigation() => ColoredBox(
        color: AppColors.appThemeColor.shade50,
        child: Padding(
          padding: getPadding(left: 15, top: 8, right: 15, bottom: 8),
          child: AppButton(
            isEnable: controller.isBtnEnable.isTrue,
            buttonText: 'Submit',
            borderRadius: getSize(5),
            onTap: () => controller.submitAction(),
          ),
        ),
      );
}
