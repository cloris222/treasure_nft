import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../collection/deposit/deposit_nft_main_view.dart';

class FinanceComingSoonView extends StatelessWidget {
  const FinanceComingSoonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Platform.isAndroid? 
        IconTextButtonWidget(
        height: UIDefine.getScreenWidth(10),
        btnText: tr("depositNFT"),
        iconPath: 'assets/icon/btn/btn_card_01_nor.png',
        onPressed: () {
        BaseViewModel().pushPage(context, const DepositNftMainView());
        }):Container(),
        SizedBox(height: UIDefine.getPixelWidth(66),),
        Image.asset(AppImagePath.financeComingSoonImg,width: UIDefine.getPixelWidth(150),fit: BoxFit.fitWidth,),
        SizedBox(height: UIDefine.getPixelWidth(24),),
        Text(tr('comingSoon'),style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w700,fontSize: UIDefine.fontSize24),),
        SizedBox(height: UIDefine.getPixelWidth(5),),
        Text(tr('comingSoonText'),style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w400,fontSize: UIDefine.fontSize12),),
      ],
    );
  }
}
