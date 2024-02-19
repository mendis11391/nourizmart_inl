import '../../app/utils/app_export.dart';

class AppImage extends StatelessWidget {
  final String? assetName;
  final Color? color;
  final BoxFit? boxFit;
  final double? height, width;
  final dynamic pictureUrl;
  final String? errorUrl;
  final bool isNetworkUrl;

  const AppImage({
    super.key,
    this.assetName = 'assets/icons/ic_avatar.jpeg',
    this.height = 50,
    this.width = 50,
    this.color,
    this.boxFit = BoxFit.fill,
    this.pictureUrl,
    this.errorUrl,
    this.isNetworkUrl = false,
  });

  @override
  Widget build(BuildContext context) => buildImageView();

  Widget buildImageView() {
    String errorImg = validString(errorUrl);
    String mimeType = assetName!.split('.').last;
    if (isNetworkUrl) {
      if (!isFieldEmpty(pictureUrl)) {
        String imageUrl = validString(pictureUrl).toLowerCase();

        if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
          return FadeInImage.assetNetwork(
            height: height,
            width: width,
            placeholder: AppResource.icGifPlaceHolder,
            image: pictureUrl,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppResource.bgNoImage,
                fit: BoxFit.contain,
                height: height,
                width: width,
              );
            },
          );
        } else {
          return AppImage(
            assetName: errorImg,
            height: height,
            isNetworkUrl: false,
            width: width,
          );
        }
      } else {
        return AppImage(
          assetName: errorImg,
          height: height,
          isNetworkUrl: false,
          width: width,
        );
      }
    } else {
      switch (mimeType) {
        case 'svg':
          return MySVG(
            height: height,
            width: width,
            fit: BoxFit.fitWidth,
            color: color,
            image: assetName!,
          );
        case 'png':
        case 'jpg':
        case 'jpeg':
        case 'gif':
          return Image(
            height: height,
            width: width,
            fit: boxFit,
            color: color,
            image: AssetImage(assetName!),
          );
        case 'zip':
          return Lottie.asset(
            assetName!,
            height: height,
            width: width,
            repeat: true,
            reverse: false,
            animate: true,
            frameRate: FrameRate.max,
          );
        default:
          return Icon(
            Icons.image_not_supported_outlined,
            size: width,
            color: Colors.red,
          );
      }
    }
  }
}
