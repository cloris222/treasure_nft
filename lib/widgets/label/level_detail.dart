import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';

class LevelDetailLabel extends StatelessWidget {
  LevelDetailLabel(
      {Key? key,
      required this.title,
      required this.content,
      this.leftFontWeight = FontWeight.normal,
      this.rightFontWeight = FontWeight.normal,
      this.showCoins = false})
      : super(key: key);

  final String title;
  final String content;
  FontWeight leftFontWeight;
  FontWeight rightFontWeight;
  bool showCoins;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  color: AppColors.dialogGrey,
                  fontSize: UIDefine.fontSize14,
                  fontWeight: leftFontWeight)),
          Row(
            children: [
              Visibility(
                  visible: showCoins,
                  child: Image.asset(
                    AppImagePath.tetherImg,
                    width: 20,
                    height: 20,
                  )),
              const SizedBox(
                width: 5,
              ),
              Text(content,
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: UIDefine.fontSize14,
                      fontWeight: rightFontWeight)),
            ],
          ),
        ],
      ),
    );
  }
}
