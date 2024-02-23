import '../../app/utils/app_export.dart';

class AppDivider extends StatelessWidget {
  final double? thickness;
  final double? height;
  final Color color;
  final bool isVertical;
  final double verticalWidth;

  const AppDivider({
    super.key,
    this.thickness = 1,
    this.height = 12,
    this.color = AppColors.appDividerGray,
    this.isVertical = false,
    this.verticalWidth = 10,
  });

  @override
  Widget build(BuildContext context) {
    final double dividerHeight = getSize(height!);
    final double dividerThickness = getSize(thickness!);
    return isVertical
        ? SizedBox(
            width: getSize(verticalWidth),
            height: getSize(dividerHeight),
            child: buildDivider(dividerHeight, dividerThickness),
          )
        : SizedBox(
            height: dividerHeight,
            child: buildDivider(dividerThickness, double.infinity),
          );
  }

  Widget buildDivider(double height, double width) => Center(
        child: SizedBox(
          height: getSize(height),
          width: width,
          child: ColoredBox(color: color),
        ),
      );
}
