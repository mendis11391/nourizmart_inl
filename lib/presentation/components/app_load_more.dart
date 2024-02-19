import '../../app/utils/app_export.dart';

class AppLoadMore extends StatelessWidget {
  final bool isGrid;
  const AppLoadMore({
    super.key,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: getPadding(all: 15),
        margin: getMargin(all: isGrid ? 0 : 5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xff00b09b),
            Color(0xff96c93d),
          ]),
          borderRadius: BorderRadius.circular(getSize(5)),
        ),
        child: isGrid ? gridLoader() : listLoader(),
      );

  Widget listLoader() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: getSize(24),
            height: getSize(24),
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: getSize(2),
            ),
          ),
          SizedBox(width: getHorizontalSize(10)),
          const AppText(
            text: 'Load more...',
            size: 14,
            color: Colors.white,
          ),
        ],
      );

  Widget gridLoader() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: getSize(24),
            height: getSize(24),
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: getSize(2),
            ),
          ),
          SizedBox(height: getVerticalSize(10)),
          const AppText(
            text: 'Load more...',
            size: 14,
            color: Colors.white,
          ),
        ],
      );
}
