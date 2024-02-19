import '../../app/utils/app_export.dart';

class SpaceHeight extends StatelessWidget {
  final double mHeight;

  const SpaceHeight({
    super.key,
    required this.mHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getVerticalSize(mHeight),
    );
  }
}
