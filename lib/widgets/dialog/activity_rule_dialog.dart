import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/widgets/dialog/base_close_dialog.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';

class ActivityRuleDialog extends BaseCloseDialog {
  ActivityRuleDialog(super.context,
      {super.backgroundColor = Colors.transparent});

  @override
  Widget buildBody() {
    TextStyle ruleStyle =
        AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, color: AppColors.dialogBlack);
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      runAlignment: WrapAlignment.start,
      children: [
        Text('1. ${tr('activity-info-1')}', style: ruleStyle),
        Text('2. ${tr('activity-info-2')}', style: ruleStyle),
        Text('3. ${tr('activity-info-3')}', style: ruleStyle),
        Text('4. ${tr('activity-info-4')}', style: ruleStyle),
      ],
    );
  }
}
