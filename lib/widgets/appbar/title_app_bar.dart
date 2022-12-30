import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: UIDefine.getWidth(),
          height: UIDefine.getPixelWidth(50),
          alignment: Alignment.center,
          child: Text(title,
              style: TextStyle(
                  fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w500)),
        ),
        Positioned(
          left: -UIDefine.getPixelWidth(10),
          top: 0,
          bottom: 0,
          child: IconButton(
              onPressed: () => BaseViewModel().popPage(context),
              icon: Icon(Icons.arrow_back_ios_new,
                  color: Colors.black, size: UIDefine.fontSize20)),
        ),
      ],
    );
  }
}
