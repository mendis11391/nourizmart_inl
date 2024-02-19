import '../../app/utils/app_export.dart';

class AppNoDataFound extends StatelessWidget {
  const AppNoDataFound({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppImage(
            assetName: AppResource.icNoData,
            width: getHorizontalSize(150),
            height: getVerticalSize(100),
          ),
          const SpaceHeight(mHeight: 20),
          const AppText(
            text: 'No Data Found',
            size: 16,
            color: Colors.grey,
          ),
        ],
      );
}
