import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/label/personal_param_item.dart';
import 'common/user_create_page.dart';
import 'common/user_novice_page.dart';
import 'common/user_setting_page.dart';

class PersonalNewSubCommonView extends StatelessWidget {
  const PersonalNewSubCommonView({super.key, required this.onViewUpdate});
  final onClickFunction onViewUpdate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.textWhite,
      child: Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(3.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr('usualFun'), // 標題 常用功能
                style: AppTextStyle.getBaseStyle(color: AppColors.textBlack,
                    fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w600)),

            _getLine(),

            Row(
              children: [
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
            ])
          ],
        ),
      )
    );
  }

  Widget _getLine() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getScreenWidth(2.7)),
        width: double.infinity,
        height: 1,
        color: AppColors.personalBar
    );
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