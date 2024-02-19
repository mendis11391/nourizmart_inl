import '../../../../../app/utils/app_export.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});
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

  AppToolBar buildAppBar() => AppToolBar(
        title: controller.title.value,
        hideBack: true,
        isCenterTitle: true,
        onToolBackPressed: () => controller.backValidationAction(),
      );

  Widget buildBody() => SafeArea(
        child: Form(
          key: controller.loginFormKey,
          onChanged: () => controller.isBtnEnable.value =
              controller.loginFormKey.currentState!.validate(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: getPadding(left: 16, right: 16, bottom: 20, top: 30),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SpaceHeight(mHeight: 30),
                  CircleAvatar(
                    backgroundColor: AppColors.appThemeColor.shade400,
                    radius: getSize(90),
                    child: AppImage(
                      assetName: AppResource.icLoginUser,
                      width: getSize(150),
                      height: getSize(130),
                    ),
                  ),
                  const SpaceHeight(mHeight: 16),
                  const AppText(
                    text: 'Nourish Mart',
                    size: 25,
                    weight: FontWeight.bold,
                  ),
                  const SpaceHeight(mHeight: 16),
                  AppText(
                    text:
                        'Add your phone number, We will send you a verification code',
                    size: 16,
                    textAlign: TextAlign.center,
                    color: Colors.grey.shade700,
                  ),
                  const SpaceHeight(mHeight: 20),
                  AppTextField(
                    isDense: true,
                    verticalPadding: getSize(13),
                    keyboardType: TextInputType.phone,
                    inputAction: TextInputAction.done,
                    focusNode: controller.mobFocusNode,
                    maxLength: 10,
                    prefix: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: '+91',
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    suffix: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (isFieldEmpty(controller.getMobile) ||
                                controller.mobController.text.length == 10)
                            ? const SizedBox.shrink()
                            : IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: getPrimaryColor(),
                                ),
                                onPressed: () => controller.clearText(),
                              ),
                        (controller.mobController.text.length != 10)
                            ? const SizedBox.shrink()
                            : CircleAvatar(
                                radius: getSize(13),
                                backgroundColor: getPrimaryColor(),
                                child: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                        const SpaceWidth(mWidth: 8)
                      ],
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    enabledBorderColor: getPrimaryColor(),
                    controller: controller.mobController,
                    onChanged: (value) => controller.onChangedMobile(value),
                    validator: (value) =>
                        isFieldEmpty(controller.mobController.text)
                            ? null
                            : isValidateMobile(controller.mobController.text),
                  ),
                  const SpaceHeight(mHeight: 70),
                  AppButton(
                    isEnable: controller.isBtnEnable.isTrue,
                    borderRadius: getSize(5),
                    onTap: () => controller.submitAction(),
                    buttonText: 'Login',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
