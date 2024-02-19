import '../../../app/utils/app_export.dart';
import 'app_loader_controller.dart';

class AppLoader extends StatelessWidget {
  // final String? imageStr;
  final String? message;
  // final Color? imgColor;

  const AppLoader({
    super.key,
    // this.imageStr,
    this.message,
    // this.imgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLoaderController>(
        init: AppLoaderController(),
        builder: (controller) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getSize(10)),
            ),
            elevation: 0,
            insetPadding: EdgeInsets.all(getSize(15)),
            backgroundColor: Colors.transparent,
            child: loadingBox(controller),
          );
        });
  }

  Widget loadingBox(AppLoaderController controller) {
    if (!isFieldEmpty(message)) {
      controller.defMsg.value = validString(message);
    }

    return Card(
      color: Colors.white,
      elevation: getSize(2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Padding(
        padding: getPadding(all: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // const SizedBox(width: 5.0),
            AppImage(
              // assetName: !isFieldEmpty(imageStr)
              //     ? validString(imageStr)
              //     : AppResource.icGifLoader,
              assetName: AppResource.icGifLoader,
              height: getSize(50),
              width: getSize(50),
              boxFit: BoxFit.contain,
              // color: imgColor ?? getPrimaryColor(),
            ),
            const SizedBox(width: 20.0),
            Obx(
              () => Expanded(
                child: AppText(
                  text: controller.defMsg.value,
                  size: 20,
                  // weight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(width: getHorizontalSize(6)),
          ],
        ),
      ),
    );
  }

  static showLoadingDialog(
      {/* String? imageStr, */ String? message /* , Color? imgColor */}) {
    AppLoaderController lic = Get.put(AppLoaderController());
    if (!lic.isLoading) {
      lic.isLoading = true;
      checkLoadingDialog(/* imageStr, */ message /* , imgColor */);
    } else {
      appLog('Already app loader dialog is showing');
    }
  }

  static void checkLoadingDialog(
    // String? imageStr,
    String? message,
    // Color? imgColor,
  ) async {
    appLog('Show app loader dialog');
    showGeneralDialog(
      context: applicationContext,
      barrierDismissible: false,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, a1, a2, widget) {
        return PopScope(
          canPop: false,
          child: Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AppLoader(
                  /* imageStr: imageStr, */ message:
                      message /* , imgColor: imgColor */),
            ),
          ),
        );
      },
    );
  }

  static hideLoadingDialog() {
    AppLoaderController lic = Get.find<AppLoaderController>();
    if (lic.isLoading) {
      appLog('Close app loader dialog');
      lic.isLoading = false;
      Get.back();
    } else {
      appLog('App loader: isLoading bool is false');
    }
  }

  static updateMessageLoadingDialog(String message) {
    appLog('Change Message Loading Indicator');
    AppLoaderController lic = Get.find<AppLoaderController>();
    lic.defMsg.value = validString(message);
  }
}
