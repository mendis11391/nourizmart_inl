import '../../app/utils/app_export.dart';

class AppToolBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onToolBackPressed;
  final List<Widget>? appBarActions;
  // final double? elevation;
  final Color? bgColor;
  final Color? textIconColor;
  final String? svgIcon;
  final double? height;
  final double? textSize;
  final bool hideBack;
  final bool isNeedShadow;
  final bool isCenterTitle;

  const AppToolBar({
    super.key,
    required this.title,
    required this.onToolBackPressed,
    this.appBarActions,
    // this.elevation,
    this.bgColor = AppColors.appThemeColor,
    this.textIconColor = Colors.white,
    this.svgIcon = AppResource.icBack,
    this.height = kToolbarHeight,
    this.hideBack = false,
    this.isNeedShadow = true,
    this.textSize,
    this.isCenterTitle = false,
  });

  @override
  PreferredSize build(BuildContext context) => PreferredSize(
        preferredSize: Size.fromHeight(height!),
        child: Container(
          decoration: isNeedShadow
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 8.0,
                    ),
                  ],
                )
              : null,
          child: AppBar(
            backgroundColor: bgColor ?? getPrimaryColor(),
            iconTheme: IconThemeData(color: textIconColor),
            toolbarHeight: preferredSize.height,
            actions: appBarActions,
            elevation: 0,
            centerTitle: isCenterTitle,
            title: Text(
              title,
              style: TextStyle(
                fontSize: textSize ?? getFontSize(18),
                color: textIconColor,
              ),
            ),
            leading: hideBack
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: onToolBackPressed,
                    icon: !isFieldEmpty(svgIcon)
                        ? AppImage(
                            assetName: svgIcon,
                            width: getSize(18),
                            height: getSize(14),
                          )
                        : Icon(
                            Icons.arrow_back,
                            color: textIconColor,
                          ),
                  ),
            systemOverlayStyle:
                SystemUiOverlayStyle.light, // StatusBar icon color
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
