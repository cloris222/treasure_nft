import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/home/home_main_style.dart';

class SponsorRowWidget extends StatelessWidget with HomeMainStyle {
  const SponsorRowWidget(
      {super.key,
      required this.leftLogo,
      required this.rightLogo,
      required this.viewModel});

  final String leftLogo;
  final String rightLogo;
  final HomeMainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(leftLogo),
            buildSpace(width: 5),
            Image.asset(rightLogo),
          ],
        ));
  }
}
