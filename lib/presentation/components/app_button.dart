import 'dart:ui';

import '../../app/utils/app_export.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;
  final String? buttonIcon;
  final Color? buttonColor, textColor, borderColor, buttonIconColor;
  final double? borderRadius, borderWidth, elevation, iconWidth;
  final double? buttonHeight, buttonWidth, textSize, iconHeight;
  final IconData? buttonIconData;
  final bool? isEnable,
      isShowLeftBtnIcon,
      isShowRightBtnIcon,
      isShowPngIcon,
      isTransparentButtonColor,
      isTransparentBorderColor;
  final FontWeight? weight;

  const AppButton({
    required this.buttonText,
    required this.onTap,
    this.borderRadius,
    this.elevation,
    this.buttonColor,
    this.textColor,
    this.buttonIconColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.buttonHeight,
    this.buttonWidth,
    this.textSize,
    this.isEnable = true,
    this.weight,
    // this.paddingLeft,
    // this.paddingTop,
    // this.paddingRight,
    // this.paddingBottom,
    // this.paddingAll,
    this.buttonIcon,
    this.isShowLeftBtnIcon,
    this.isShowRightBtnIcon,
    this.isShowPngIcon,
    this.iconWidth,
    this.iconHeight,
    this.isTransparentButtonColor = false,
    this.isTransparentBorderColor = false,
    this.buttonIconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isEnable!
            ? buttonColor ?? getPrimaryColor()
            : buttonColor != null
                ? isTransparentButtonColor!
                    ? buttonColor!
                    : buttonColor!.withOpacity(0.2)
                : Theme.of(applicationContext)
                    .disabledColor, // appDisablePrimary
        border: Border.all(
          width: borderWidth!,
          color: isEnable!
              ? borderColor ?? Colors.transparent
              : borderColor != null
                  ? isTransparentBorderColor!
                      ? borderColor!
                      : borderColor!.withOpacity(0.2)
                  : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: Material(
        color: Colors.transparent,
        elevation: elevation ?? 0.0,
        child: InkWell(
          onTap: isEnable! ? onTap : null,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          child: Container(
            constraints: BoxConstraints(
                maxHeight: buttonHeight ?? getVerticalSize(40),
                maxWidth: buttonWidth ?? double.infinity),
            child: Center(
              child: Padding(
                padding: getPadding(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: (isShowLeftBtnIcon ?? false),
                      child: isEnable!
                          ? buildBtnIcon()
                          : ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: buildBtnIcon(),
                              ),
                            ),
                    ),
                    Visibility(
                      visible: (isShowLeftBtnIcon ?? false),
                      child: SizedBox(width: getHorizontalSize(5)),
                    ),
                    Text(
                      buttonText,
                      style: TextStyle(
                          color: isEnable!
                              ? textColor ?? Colors.white
                              : textColor != null
                                  ? textColor!.withOpacity(0.5)
                                  : Colors.white.withOpacity(0.5),
                          fontSize: textSize ?? getFontSize(16),
                          fontWeight: weight ?? FontWeight.bold),
                    ),
                    Visibility(
                      visible: (isShowRightBtnIcon ?? false),
                      child: SizedBox(width: getHorizontalSize(5)),
                    ),
                    Visibility(
                      visible: (isShowRightBtnIcon ?? false),
                      child: isEnable!
                          ? buildBtnIcon()
                          : ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: buildBtnIcon(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBtnIcon() => buttonIconData != null
      ? Icon(
          buttonIconData,
          size: getSize(15),
          color: buttonIconColor,
        )
      : AppImage(
          assetName: validString(buttonIcon),
          height: iconWidth ?? getSize(15),
          width: iconHeight ?? getSize(15),
          boxFit: BoxFit.cover,
          color: buttonIconColor);
}
