import '../../app/utils/app_export.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? weight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final int? maxLine;
  final double? size;
  final double? decorationThickness;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? letterSpacing;

  const AppText({
    super.key,
    required this.text,
    required this.size,
    this.color,
    this.weight,
    this.fontFamily,
    this.textAlign,
    this.maxLine,
    this.overflow,
    this.decoration,
    this.decorationThickness,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        overflow: overflow ?? TextOverflow.visible,
        style: TextStyle(
            color: color ?? Colors.black,
            fontSize: getFontSize(size!),
            fontWeight: weight ?? FontWeight.normal,
            fontFamily: fontFamily ?? 'inter',
            decoration: decoration,
            decorationThickness: decorationThickness,
            letterSpacing: letterSpacing),
        textAlign: textAlign ?? TextAlign.left,
        maxLines: maxLine,
      );
}
