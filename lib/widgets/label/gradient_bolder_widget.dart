import 'package:flutter/material.dart';

import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';

class GradientBolderWidget extends StatelessWidget {
  const GradientBolderWidget(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      this.radius = 10,
      this.bolderWith = 2,
      this.autoHeight = false,
      this.padding})
      : super(key: key);
  final double? width;
  final double? height;
  final Widget child;
  final double radius;
  final double bolderWith;
  final bool autoHeight;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return autoHeight ? _buildAutoHeight() : _buildSetHeight();
  }

  ///MARK: 固定高度
  Widget _buildSetHeight() {
    return Stack(children: [
      Container(
          alignment: Alignment.center,
          decoration: AppStyle().baseGradient(radius: radius),
          width: width ?? UIDefine.getWidth(),
          height: height ?? 50,
          child: const Text('')),
      Positioned(
          top: bolderWith,
          bottom: bolderWith,
          left: bolderWith,
          right: bolderWith,
          child: Container(
              padding: padding,
              alignment: Alignment.center,
              decoration: AppStyle().styleColorsRadiusBackground(
                  color: Colors.white, radius: radius),
              child: child))
    ]);
  }

  ///MARK: 自適應高度
  Widget _buildAutoHeight() {
    return Container(
      decoration: AppStyle().baseGradient(radius: radius),
      padding: EdgeInsets.all(bolderWith),
      child: Container(
        padding: padding,
        decoration: AppStyle()
            .styleColorsRadiusBackground(color: Colors.white, radius: radius),
        child: child,
      ),
    );
  }
}
