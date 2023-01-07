import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/common/user_create_page.dart';
import 'package:treasure_nft_project/views/personal/common/user_novice_page.dart';
import 'package:treasure_nft_project/views/personal/common/user_setting_page.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../widgets/label/personal_param_item.dart';

class PersonalSubCommonView extends StatelessWidget {
  const PersonalSubCommonView({Key? key, required this.onViewUpdate})
      : super(key: key);
  final onClickFunction onViewUpdate;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 25,
      children: [
        const SizedBox(width: 1),
        _buildTitle(),
        _buildButton(context),
        const SizedBox(width: 1),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Image.asset(AppImagePath.userCommonIcon,
          width: UIDefine.getScreenWidth(8), fit: BoxFit.fitWidth),
      const SizedBox(width: 5),
      Flexible(
        child: Text(tr('usualFun'),
            softWrap: false,
            style: CustomTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize20,
                fontWeight: FontWeight.w500,
                color: AppColors.dialogBlack)),
      )
    ]);
  }

  Widget _buildButton(BuildContext context) {
    return SizedBox(
        width: UIDefine.getWidth(),
        child: Row(children: [
          Flexible(
              child: PersonalParamItem(
                  title: tr('uc_novice'),
                  assetImagePath: AppImagePath.userNoviceIcon,
                  onPress: () => _showUserNovicePage(context))),
          Flexible(
              child: PersonalParamItem(
                  title: tr('paymentSetting'),
                  assetImagePath: AppImagePath.userSettingIcon,
                  onPress: () => _showUserSettingPage(context))),
          Platform.isIOS
              ? const SizedBox()
              : Flexible(
                  child: PersonalParamItem(
                      title: tr('create'),
                      assetImagePath: AppImagePath.userCreateIcon,
                      onPress: () => _showUserCreatePage(context)))
        ]));
  }

  void _showUserNovicePage(BuildContext context) {
    BaseViewModel().pushPage(context, const UserNovicePage());
  }

  void _showUserSettingPage(BuildContext context) async {
    await BaseViewModel().pushPage(context, const UserSettingPage());
    onViewUpdate();
  }

  void _showUserCreatePage(BuildContext context) {
    BaseViewModel().pushPage(context, const UserCreatePage());
  }
}
