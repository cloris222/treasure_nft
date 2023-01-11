import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

///共用 有圓角的UI
class LoginCommonView extends StatelessWidget {
  const LoginCommonView(
      {Key? key, this.pageHeight, required this.title, required this.body})
      : super(key: key);
  final double? pageHeight;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Stack(children: [
          SizedBox(
            width: UIDefine.getWidth(),
            height: pageHeight ?? UIDefine.getPixelWidth(600),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(AppImagePath.backgroundLand,
                  height: UIDefine.getPixelWidth(280), fit: BoxFit.fill)),
          Positioned(
              top: UIDefine.getPixelWidth(30),
              bottom: 0,
              left: UIDefine.getPixelWidth(20),
              right: UIDefine.getPixelWidth(20),
              child: Text(title,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize18,
                      color: AppColors.textThreeBlack,
                      fontWeight: FontWeight.w600))),
          Positioned(
              top: UIDefine.getPixelWidth(80),
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12)),
                    color: Colors.white),
              )),
          Positioned(
              top: UIDefine.getPixelWidth(95), left: 0, right: 0, child: body)
        ]));
  }
}
