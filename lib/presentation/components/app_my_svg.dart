import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySVG extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  const MySVG({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: color == null ? svg() : coloredSvg(),
      );

  Widget svg() => SvgPicture.asset(
        image,
        fit: fit!,
        semanticsLabel: 'mart',
        placeholderBuilder: (BuildContext context) =>
            const CircularProgressIndicator(),
      );

  Widget coloredSvg() => SvgPicture.asset(
        image,
        fit: fit!,
        colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
        semanticsLabel: 'mart',
        placeholderBuilder: (BuildContext context) =>
            const CircularProgressIndicator(),
      );
}
