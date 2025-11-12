import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../enums/assets/app_images.dart';

extension AppImagesExt on AppImages {
  Widget toSvg({
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  Widget toImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
    );
  }
}