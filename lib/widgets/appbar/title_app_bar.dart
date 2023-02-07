import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar(
      {Key? key,
      required this.title,
      this.needArrowIcon = true,
      this.needCloseIcon = false})
      : super(key: key);
  final String title;
  final bool needArrowIcon;
  final bool needCloseIcon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: UIDefine.getWidth(),
          height: UIDefine.getPixelWidth(50),
          alignment: Alignment.center,
          child: Text(title,
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w600)),
        ),
        Positioned(
          left: -UIDefine.getPixelWidth(10),
          top: 0,
          bottom: 0,
          child: Visibility(
            visible: needArrowIcon,
            child: IconButton(
                onPressed: () => BaseViewModel().popPage(context),
                icon: Icon(Icons.arrow_back_ios_new,
                    color: Colors.black, size: UIDefine.fontSize20)),
          ),
        ),
        Positioned(
          right: -UIDefine.getPixelWidth(10),
          top: 0,
          child: Visibility(
            visible: needCloseIcon,
            child: IconButton(
                onPressed: () => BaseViewModel().popPage(context),
                icon: Image.asset(AppImagePath.closeIcon,
                    height: UIDefine.fontSize20,
                    width: UIDefine.fontSize20,
                    fit: BoxFit.contain)),
          ),
        ),
      ],
    );
  }
}
