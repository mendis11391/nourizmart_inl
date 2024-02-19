import '../../app/utils/app_export.dart';

class SpaceWidth extends StatelessWidget {
  final double mWidth;

  const SpaceWidth({
    super.key,
    required this.mWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getHorizontalSize(mWidth),
    );
  }
}
