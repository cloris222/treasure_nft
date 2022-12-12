import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/views/personal/common/phone_param_view.dart';

import '../../../constant/theme/app_image_path.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/personal/common/user_info_setting_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/button/login_button_widget.dart';
import '../../../widgets/date_picker/date_picker_one.dart';
import '../../custom_appbar_view.dart';
import '../../login/login_param_view.dart';
import 'gender_selector_drop_down_bar.dart';

/// 使用者設定
class UserInfoSettingPage extends StatefulWidget {
  const UserInfoSettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserInfoSettingPage();
}

class _UserInfoSettingPage extends State<UserInfoSettingPage> {
  late UserInfoSettingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = UserInfoSettingViewModel(setState: setState);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        needScrollView: false,
        title: tr("userInfo"),
        type: AppNavigationBarType.typePersonal,
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(tr('nationality'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: UIDefine.fontSize14))),
                      _getNationalityForm(),
                      SizedBox(height: UIDefine.getScreenWidth(4.16)),
                      _getUnEditFormView(
                          tr('account'), GlobalData.userInfo.account),
                      SizedBox(height: UIDefine.getScreenWidth(4.16)),
                      LoginParamView(
                          titleText: tr('nickname'),
                          hintText: tr("placeholder-nickname'"),
                          controller: viewModel.nickNameController,
                          data: viewModel.nickNameData,
                          onChanged: viewModel.onNicknameChanged),
                      SizedBox(height: UIDefine.getScreenWidth(4.16)),
                      PhoneParamView(
                          initCountry:
                              GlobalData.userInfo.phoneCountry.isNotEmpty
                                  ? GlobalData.userInfo.phoneCountry
                                  : null,
                          titleText: tr('phone'),
                          hintText: tr("placeholder-phone'"),
                          controller: viewModel.phoneController,
                          data: viewModel.phoneData,
                          getDropDownValue: (String value) {
                            viewModel.setPhoneCountry(value);
                          }),
                      SizedBox(height: UIDefine.getScreenWidth(4.16)),
                      _getUnEditFormView(
                          tr('email'), GlobalData.userInfo.email),
                      SizedBox(height: UIDefine.getScreenWidth(4.16)),
                      GenderSelectorDropDownBar(
                          getDropDownValue: (String value) {
                        viewModel.setGender(value);
                      }),
                      SizedBox(height: UIDefine.getScreenWidth(4.16)),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(tr('birthday'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: UIDefine.fontSize14))),
                      DatePickerOne(
                        initDate: GlobalData.userInfo.birthday.isNotEmpty
                            ? GlobalData.userInfo.birthday
                            : null,
                        getValue: (String value) {
                          viewModel.setBirthday(value);
                        },
                        data: viewModel.birthdayData,
                        enabledColor: viewModel.birthdayData.result
                            ? AppColors.bolderGrey
                            : AppColors.textRed,
                      ),
                      SizedBox(height: UIDefine.getScreenWidth(6)),
                      LoginButtonWidget(
                          // Save按鈕
                          isGradient: false,
                          btnText: tr('save'),
                          onPressed: () => viewModel.onPressSave(context))
                    ]))));
  }

  Widget _getNationalityForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image.asset( // 拿掉國旗 20221212
        //     format(AppImagePath.languageIcon,
        //         {'country': GlobalData.userInfo.country}),
        //     width: UIDefine.getScreenWidth(11.11),
        //     height: UIDefine.getScreenWidth(11.11)),
        // SizedBox(width: UIDefine.getScreenWidth(2.7)),
        Text('${tr(GlobalData.userInfo.country)} (${GlobalData.userInfo.zone})',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize14)),
      ],
    );
  }

  Widget _getUnEditFormView(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: UIDefine.fontSize14))),
        Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(
                UIDefine.getScreenWidth(5.5),
                UIDefine.getScreenWidth(4.16),
                0,
                UIDefine.getScreenWidth(4.16)),
            decoration: const BoxDecoration(
                color: AppColors.datePickerBorder,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(content,
                style: TextStyle(
                    color: AppColors.dialogGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: UIDefine.fontSize14))),
      ],
    );
  }
}
