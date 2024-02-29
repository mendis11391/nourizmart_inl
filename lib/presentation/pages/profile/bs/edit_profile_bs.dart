import '../../../../../../app/utils/app_export.dart';
import 'edit_profile_bs_controller.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
        init: EditProfileController(),
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
                      Form(
                        key: controller.editProfileFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: getPadding(bottom: 30),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Align(
                                alignment: Alignment.topCenter,
                                child: AppText(
                                  text: 'Update Profile',
                                  size: 16,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              const SpaceHeight(mHeight: 20),
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
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                                        onPressed: () =>
                                            controller.clearLnText(),
                                      ),
                                onChanged: (value) =>
                                    controller.onChangedLn(value),
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
                                focusNode: controller.lnFocusNode,
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                                        onPressed: () =>
                                            controller.clearFnText(),
                                      ),
                                onChanged: (value) =>
                                    controller.onChangedFn(value),
                                validator: (value) =>
                                    isFieldEmpty(controller.fnController.text)
                                        ? 'Enter last name'
                                        : null,
                              ),
                              const SpaceHeight(mHeight: 60),
                              AppButton(
                                buttonText: 'Update',
                                borderRadius: getSize(5),
                                onTap: () => controller.submitAction(),
                              ),
                            ],
                          ),
                        ),
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
}
