import 'package:flutter/material.dart';

import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';

class GradientBolderWidget extends StatelessWidget {
  const GradientBolderWidget(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      this.radius = 10})
      : super(key: key);
  final double? width;
  final double? height;
  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: AppStyle().baseGradient(radius: radius),
          width: width ?? UIDefine.getWidth(),
          height: height??50,
          child: const Text('')),
      Positioned(
          top: 12,
          bottom: 12,
          left: 2,
          right: 2,
          child: Container(
              alignment: Alignment.center,
              decoration: AppStyle().styleColorsRadiusBackground(
                  color: Colors.white, radius: radius),
              child: child))
    ]);
  }
}
