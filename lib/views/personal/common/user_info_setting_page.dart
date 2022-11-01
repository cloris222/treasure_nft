import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/national_flag_util.dart';
import 'package:treasure_nft_project/views/personal/common/phone_param_view.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../view_models/personal/common/user_info_setting_view_model.dart';
import '../../../widgets/app_bottom_center_button.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/appbar/custom_app_bar.dart';
import '../../../widgets/button/login_button_widget.dart';
import '../../../widgets/date_picker/date_picker_one.dart';
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
    return Scaffold(
      /// AppBar
      appBar: CustomAppBar.getCornerAppBar(
            () {
          BaseViewModel().popPage(context);
        },
        tr("userInfo"),
        fontSize: UIDefine.fontSize24,
        arrowFontSize: UIDefine.fontSize34,
        circular: 40,
        appBarHeight: UIDefine.getScreenWidth(20),
      ),

      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(tr('nationality'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14))),
              _getNationalityForm(),
              SizedBox(height: UIDefine.getScreenWidth(4.16)),

              _getUnEditFormView(tr('account'), GlobalData.userInfo.name),
              SizedBox(height: UIDefine.getScreenWidth(4.16)),

              LoginParamView(
                  titleText: tr('nickname'),
                  hintText: tr("placeholder-nickname'"),
                  controller: viewModel.nickNameController,
                  data: viewModel.nickNameData,
                  onTap: viewModel.onTap,
                  onChanged: viewModel.onNicknameChanged),
              SizedBox(height: UIDefine.getScreenWidth(4.16)),

              PhoneParamView(
                titleText: tr('phone'),
                hintText: tr("placeholder-phone'"),
                controller: viewModel.phoneController,
                data: viewModel.phoneData,
                onTap: viewModel.onTap,
                getDropDownValue: (String value) {
                  viewModel.setPhoneCountry(value);
                }),
              SizedBox(height: UIDefine.getScreenWidth(4.16)),

              _getUnEditFormView(tr('email'), GlobalData.userInfo.email),
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
                          fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14))),
              DatePickerOne(
                  onTap: viewModel.onTap,
                  getValue: (String value) { viewModel.setBirthday(value); },
                  data: viewModel.birthdayData,
                  enabledColor: viewModel.birthdayData.result ? AppColors.bolderGrey : AppColors.textRed,),

              SizedBox(height: UIDefine.getScreenWidth(6)),
              LoginButtonWidget( // Save按鈕
                  isGradient: false,
                  btnText: tr('save'),
                  onPressed: () => viewModel.onPressSave(context)
              )
            ],
          )
        ),
      ),

      bottomNavigationBar: const AppBottomNavigationBar(initType: AppNavigationBarType.typePersonal),
      floatingActionButton: const AppBottomCenterButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _getNationalityForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(NationalFlagUtil().getNationalFlag(GlobalData.userInfo.country),
        width: UIDefine.getScreenWidth(11.11), height: UIDefine.getScreenWidth(11.11)),

        SizedBox(width: UIDefine.getScreenWidth(2.7)),

        Text(
          GlobalData.userInfo.country + ' (' + GlobalData.userInfo.zone + ')',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: UIDefine.fontSize14)),
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
                    fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14))),

        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5.5), UIDefine.getScreenWidth(4.16),
            0, UIDefine.getScreenWidth(4.16)),
          decoration: const BoxDecoration(
            color: AppColors.datePickerBorder,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Text(content,
              style: TextStyle(color: AppColors.dialogGrey,
                  fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize14))
        ),


      ],
    );
  }

}