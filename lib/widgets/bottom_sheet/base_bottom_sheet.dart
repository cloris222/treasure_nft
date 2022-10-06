import 'package:flutter/material.dart';

abstract class BaseBottomSheet {
  BaseBottomSheet(this.context,
      {this.percentage = 0.75,
      this.controller,
      this.isShowBottom = true,
      this.needPercentage = true});

  double titleTop = 30;
  double titleBottom = 20;
  BuildContext context;
  double percentage;
  AnimationController? controller;
  bool isShowBottom;
  bool needPercentage; //判斷是否需要%比

  void show() {
    init();
    if (needPercentage) {
      _showPercentage();
    } else {
      _showNoPercentage();
    }
  }

  void _showPercentage() {
    showModalBottomSheet(
        transitionAnimationController: controller,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * percentage +
                  (isShowBottom ? MediaQuery.of(context).viewInsets.bottom : 0),
              child: StatefulBuilder(builder: buildSheetWidget));
        });
  }

  void _showNoPercentage() {
    showModalBottomSheet(
        transitionAnimationController: controller,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(child: StatefulBuilder(builder: buildSheetWidget));
        });
  }

  void closeBottomSheet() {
    dispose();
    Navigator.pop(context);
  }

  void init();
  void dispose();

  Widget buildSheetWidget(BuildContext context, StateSetter setState);

  Widget createLine({double height = 3, Color color = Colors.grey}) {
    return Divider(height: height, color: color);
  }

  Widget createTitle(Widget title, {bool needLine = true}) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(height: titleTop),
      title,
      SizedBox(height: titleBottom),
      needLine ? createLine() : const SizedBox()
    ]);
  }

  void clearFocus() {
    FocusScope.of(context).unfocus();
  }
}
