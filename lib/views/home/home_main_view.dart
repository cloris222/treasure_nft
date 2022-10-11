import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';


class HomeMainView extends StatelessWidget {
  const HomeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
          const DomainBar(),

          Container(
            alignment: Alignment.bottomCenter,

            height: UIDefine.getScreenHeight(7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('使用',
                style: TextStyle(
                    fontSize: UIDefine.fontSize22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                ),
              ),

              GradientText(' Treasure ',
                  size:UIDefine.fontSize20,
                  weight: FontWeight.bold,
              ),

              Text('交易賺取收益',
                style: TextStyle(
                  fontSize: UIDefine.fontSize22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
            ],),

          ),
        ],),

    );
  }
}
