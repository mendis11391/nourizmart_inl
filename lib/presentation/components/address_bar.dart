import '../../app/utils/app_export.dart';

class AddressToolBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTapToolBack,
      onTapToolUser,
      onTapToolAddress,
      onTapToolCart,
      onTapToolNotification;
  final bool hideBack, hideCart, hideNotification;
  final RxInt? cartCount, notificationCount;
  final String userName, address;

  const AddressToolBar({
    super.key,
    this.onTapToolBack,
    this.onTapToolUser,
    this.onTapToolAddress,
    this.onTapToolCart,
    this.onTapToolNotification,
    this.hideBack = true,
    this.hideCart = true,
    this.hideNotification = true,
    this.cartCount,
    this.notificationCount,
    this.userName = '',
    this.address = '',
  });

  @override
  PreferredSize build(BuildContext context) => PreferredSize(
      preferredSize: Size.fromHeight(height!),
      child: AppBar(
        backgroundColor: getPrimaryColor(),
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: preferredSize.height,
        elevation: 2,
        centerTitle: false,
        title: InkWell(
          onTap: onTapToolAddress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: validString(userName),
                size: 14,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      text: validString(address),
                      size: 12,
                      color: Colors.white,
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded)
                ],
              ),
            ],
          ),
        ),
        titleSpacing: getHorizontalSize(5),
        leading: hideBack
            ? InkWell(
                onTap: onTapToolUser,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(getSize(35))),
                      child: AppImage(
                        assetName: AppResource.icAvatar,
                        width: getSize(35),
                        height: getSize(35),
                      ),
                    ),
                  ],
                ),
              )
            : IconButton(
                onPressed: onTapToolBack,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: (hideCart && hideNotification)
            ? [const SpaceWidth(mWidth: 10)]
            : [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!hideCart && validInt(cartCount?.value) > 0) ...[
                      IconButton(
                        onPressed: onTapToolCart,
                        icon: AppImage(
                          assetName: AppResource.icCart,
                          width: getSize(22),
                          height: getSize(22),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 8,
                        child: Container(
                          padding: getPadding(all: 1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          child: AppText(
                            text: validString(cartCount?.value),
                            size: 8,
                            textAlign: TextAlign.center,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                const SpaceWidth(mWidth: 5),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!hideNotification) ...[
                      IconButton(
                        onPressed: onTapToolNotification,
                        icon: AppImage(
                          assetName: AppResource.icNotification,
                          width: getSize(22),
                          height: getSize(22),
                        ),
                      ),
                      if (validInt(notificationCount?.value) > 0) ...[
                        Positioned(
                          right: 10,
                          top: 8,
                          child: Container(
                            padding: getPadding(all: 1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 15,
                              minHeight: 15,
                            ),
                            child: AppText(
                              text: validString(notificationCount?.value),
                              size: 8,
                              textAlign: TextAlign.center,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]
                    ]
                  ],
                ),
              ],
      ));

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
