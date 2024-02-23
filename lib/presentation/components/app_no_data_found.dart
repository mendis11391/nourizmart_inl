import '../../app/utils/app_export.dart';

class AppNoDataFound extends StatelessWidget {
  const AppNoDataFound({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SpaceHeight(mHeight: 50),
            AppImage(
              assetName: AppResource.gifNoData,
              width: getSize(100),
              height: getSize(100),
            ),
            const SpaceHeight(mHeight: 20),
            const AppText(
              text: 'No Data Found',
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      );
}
