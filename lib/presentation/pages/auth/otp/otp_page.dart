import 'package:pinput/pinput.dart';

import '../../../../../app/utils/app_export.dart';
import 'otp_controller.dart';

class OtpPage extends GetView<OtpController> {
  const OtpPage({super.key});
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
        child: SingleChildScrollView(
          padding: getPadding(left: 16, right: 16, bottom: 20, top: 30),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  text: 'Verification',
                  size: 25,
                  weight: FontWeight.bold,
                ),
                const SpaceHeight(mHeight: 16),
                AppText(
                  text:
                      'Enter the OTP sent to your phone number ${controller.mobile.value}',
                  size: 16,
                  textAlign: TextAlign.center,
                  color: Colors.grey.shade700,
                ),
                const SpaceHeight(mHeight: 20),
                Pinput(
                  controller: controller.otpController,
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: getSize(50),
                      height: getSize(50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(getSize(10)),
                        border: Border.all(
                          color: AppColors.appThemeColor.shade200,
                        ),
                      ),
                      textStyle: TextStyle(
                        fontSize: getFontSize(15),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onCompleted: (code) {
                      if (controller.isResentBtnEnable.isFalse) {
                        controller.otpCode.value = validString(code);
                        controller.isBtnEnable.value = true;
                      }
                    }),
                const SpaceHeight(mHeight: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const AppText(
                      text: 'This code will expired in',
                      size: 12,
                    ),
                    AppText(
                      text: ' ${controller.getTimerText} ',
                      size: 12,
                    ),
                    Icon(
                      Icons.timer,
                      size: getSize(15),
                      color: getPrimaryColor(),
                    ),
                  ],
                ),
                const SpaceHeight(mHeight: 20),
                AppButton(
                  isEnable: controller.isBtnEnable.isTrue,
                  borderRadius: getSize(5),
                  onTap: () => controller.submitAction(),
                  buttonText: 'Verify',
                ),
                const SpaceHeight(mHeight: 20),
                AppButton(
                  buttonText: 'Resend',
                  borderRadius: getSize(5),
                  buttonColor: Colors.transparent,
                  borderColor: getPrimaryColor(),
                  textColor: getPrimaryColor(),
                  isTransparentButtonColor: true,
                  isEnable: controller.isResentBtnEnable.isTrue,
                  onTap: () => controller.resendAction(),
                ),
              ],
            ),
          ),
        ),
      );
}
