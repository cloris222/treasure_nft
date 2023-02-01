import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../constant/theme/app_colors.dart';
import 'base_close_dialog.dart';

class TradeRuleDialog extends BaseCloseDialog {
  TradeRuleDialog(super.context, {super.backgroundColor = Colors.transparent});

  @override
  Widget buildBody() {
    TextStyle ruleStyle =
    AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12, color: AppColors.dialogBlack);
   return Wrap(
     spacing: 10,
     runSpacing: 10,
     runAlignment: WrapAlignment.start,
     children: [
       Text('1. ${tr('defi-info-1')}', style: ruleStyle),
       Text('2. ${tr('defi-info-2')}', style: ruleStyle),
       Text('3. ${tr('defi-info-3')}', style: ruleStyle),
       Text('4. ${tr('defi-info-4')}', style: ruleStyle),
       Text('5. ${tr('defi-info-5')}', style: ruleStyle),
       Text('6. ${tr('defi-info-6')}', style: ruleStyle),
       Text('7. ${tr('defi-info-7')}', style: ruleStyle),
     ],
   );
  }
}
