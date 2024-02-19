import '../../../app/utils/app_export.dart';

class AppAlertDialog extends StatelessWidget {
  final String? btn1Name, btn2Name;
  final VoidCallback onPressedBtn1;
  final VoidCallback? onPressedBtn2;
  final bool? isHideCloseIcon;
  final Widget? title, topIcon, descriptions;

  const AppAlertDialog({
    super.key,
    this.title,
    this.descriptions,
    this.isHideCloseIcon,
    required this.onPressedBtn1,
    this.onPressedBtn2,
    this.btn1Name,
    this.btn2Name,
    this.topIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getSize(8)),
      ),
      elevation: 5,
      insetPadding: EdgeInsets.all(getSize(15)),
      backgroundColor: Colors.white,
      child: dialogContentBox(),
    );
  }

  Widget dialogContentBox() => SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  topIcon ?? const SizedBox.shrink(),
                  title ?? const SizedBox.shrink(),
                  SizedBox(height: getVerticalSize(15)),
                  descriptions ?? const SizedBox.shrink(),
                  SizedBox(height: getVerticalSize(25)),
                  Row(
                    children: [
                      const Spacer(),
                      Visibility(
                        visible: !isFieldEmpty(btn2Name),
                        child: AppButton(
                          onTap: onPressedBtn2 ?? () {},
                          buttonText: btn2Name ?? 'Cancel',
                          buttonHeight: getVerticalSize(38),
                          buttonWidth: getHorizontalSize(105),
                          textSize: getFontSize(12),
                          weight: FontWeight.bold,
                          borderRadius: getSize(5),
                          borderColor: getPrimaryColor(),
                          textColor: getPrimaryColor(),
                          buttonColor: Colors.transparent,
                        ),
                      ),
                      if (!isFieldEmpty(btn2Name)) ...[
                        const Spacer(),
                        const SizedBox(height: 20),
                        const Spacer(),
                      ],
                      AppButton(
                        onTap: onPressedBtn1,
                        buttonText: btn1Name ?? 'OK',
                        buttonHeight: getVerticalSize(38),
                        buttonWidth: getHorizontalSize(105),
                        textSize: getFontSize(12),
                        weight: FontWeight.bold,
                        borderRadius: getSize(5),
                        borderColor: getPrimaryColor(),
                        buttonColor: getPrimaryColor(),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Visibility(
              visible: !(isHideCloseIcon ?? false),
              child: Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: 24,
                    color: getPrimaryColor(),
                  ),
                  onPressed: () => AppAlertDialog.hideAlertDialog(),
                ),
              ),
            ),
          ],
        ),
      );

  static showAlertDialog(
      {String? btn1Name,
      String? btn2Name,
      required VoidCallback onPressedBtn1,
      VoidCallback? onPressedBtn2,
      bool? isHideCloseIcon,
      Widget? title,
      Widget? topIcon,
      Widget? descriptions}) async {
    appLog('Show Alert Dialog');
    showGeneralDialog(
      context: applicationContext,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.65),
      pageBuilder: (context, animation1, animation2) => const SizedBox.shrink(),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, a1, a2, widget) {
        return PopScope(
          canPop: false,
          child: Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AppAlertDialog(
                title: title,
                descriptions: descriptions,
                onPressedBtn1: onPressedBtn1,
                onPressedBtn2: onPressedBtn2,
                btn1Name: btn1Name,
                btn2Name: btn2Name,
                isHideCloseIcon: isHideCloseIcon,
                topIcon: topIcon,
              ),
            ),
          ),
        );
      },
    );
  }

  static hideAlertDialog() {
    appLog('Close Alert Dialog');
    Get.back();
  }
}
