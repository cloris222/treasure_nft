import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';


class DomainBar extends StatelessWidget {
  const DomainBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: UIDefine.getScreenHeight(7),
        width: UIDefine.getWidth(),
        decoration: AppStyle().baseGradient(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The only official domain for Treasure is ',
              style: TextStyle(
                  fontSize: UIDefine.fontSize12,
                  color: Colors.white,
                  fontWeight: FontWeight.w300
              ),
            ),
            Text('https://treasure.xyz',
              style: TextStyle(
                  fontSize: UIDefine.fontSize12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],)
    );
  }
}