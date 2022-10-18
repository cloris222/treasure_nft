import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../widgets/label/personal_param_item.dart';

class PersonalSubCommonView extends StatelessWidget {
  const PersonalSubCommonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 25,
      children: [
        const SizedBox(width: 1),
        _buildTitle(),
        _buildButton(),
        const SizedBox(width: 1),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(children: [
      Image.asset(AppImagePath.userCommonIcon),
      const SizedBox(width: 5),
      Text(tr('usualFun'),
          style: TextStyle(
              fontSize: UIDefine.fontSize20,
              fontWeight: FontWeight.bold,
              color: AppColors.dialogBlack))
    ]);
  }

  Widget _buildButton() {
    return Container(
        width: UIDefine.getWidth(),
        child: Row(children: [
          Flexible(
              child: PersonalParamItem(
                  title: tr('uc_novice'),
                  assetImagePath: AppImagePath.userNoviceIcon,
                  onPress: _showUserNovicePage)),
          Flexible(
              child: PersonalParamItem(
                  title: tr('paymentSetting'),
                  assetImagePath: AppImagePath.userSettingIcon,
                  onPress: _showUserSettingPage)),
          Flexible(
              child: PersonalParamItem(
                  title: tr('create'),
                  assetImagePath: AppImagePath.userCreateIcon,
                  onPress: _showUserCreatePage))
        ]));
  }

  void _showUserNovicePage() {}

  void _showUserSettingPage() {}

  void _showUserCreatePage() {}
}
