
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';

class SponsorRowWidget extends StatelessWidget {
  const SponsorRowWidget({super.key, required this.leftLogo, required this.rightLogo});

  final String leftLogo;
  final String rightLogo;

  @override
  Widget build(BuildContext context) {
    HomeMainViewModel vm = HomeMainViewModel();
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
      child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(leftLogo),
        vm.buildSpace(width: 5),
        Image.asset(rightLogo),
      ],));
  }
}