import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/common/phone_param_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';

import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/user_info_data.dart';
import '../../../view_models/personal/common/user_info_setting_view_model.dart';
import '../../../widgets/button/login_button_widget.dart';
import '../../../widgets/date_picker/date_picker_one.dart';
import '../../login/login_param_view.dart';
import 'gender_selector_drop_down_bar.dart';

/// 使用者設定
class UserInfoSettingPage extends ConsumerStatefulWidget {
  const UserInfoSettingPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserInfoSettingPageState();
}

class _UserInfoSettingPageState extends ConsumerState<UserInfoSettingPage> {
  late UserInfoSettingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = UserInfoSettingViewModel(
        setState: setState, userInfo: ref.read(userInfoProvider));
    viewModel.init();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserInfoData userInfo =ref.watch(userInfoProvider);
    return CustomAppbarView(
        needScrollView: false,
        onLanguageChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        type: AppNavigationBarType.typePersonal,
        body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleAppBar(title: tr('userInfo'), needCloseIcon: false),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //     margin: const EdgeInsets.symmetric(vertical: 5),
                      //     child: Text(tr('nationality'),
                      //         style: AppTextStyle.getBaseStyle(
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: UIDefine.fontSize14))),
                      // _getNationalityForm(),
                      _getUnEditFormView(tr('nationality'),
                          '${tr(userInfo.country)} (${userInfo.zone})'),
                      SizedBox(height: UIDefine.getScreenWidth(4.16)),
                      _getUnEditFormView(
                          tr('account'), userInfo.account),
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
                              userInfo.phoneCountry.isNotEmpty
                                  ? userInfo.phoneCountry
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
                          tr('email'), userInfo.email),
                      SizedBox(height: UIDefine.getScreenWidth(4.16)),
                      GenderSelectorDropDownBar(
                          getDropDownValue: (String value) {
                        viewModel.setGender(value);
                      }),
                      SizedBox(height: UIDefine.getScreenWidth(4.16)),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(tr('birthday'),
                              style: AppTextStyle.getBaseStyle(
                                  fontSize: UIDefine.fontSize14))),
                      DatePickerOne(
                        initDate: userInfo.birthday.isNotEmpty
                            ? userInfo.birthday
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
                      Container(
                          width: double.infinity,
                          height: UIDefine.getPixelWidth(1),
                          color: AppColors.personalBar),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LoginButtonWidget(
                              // Save按鈕
                              padding: EdgeInsets.symmetric(
                                  vertical: UIDefine.getPixelWidth(10),
                                  horizontal: UIDefine.getPixelWidth(20)),
                              margin: EdgeInsets.symmetric(
                                  vertical: UIDefine.getPixelWidth(15)),
                              isFillWidth: false,
                              radius: 17,
                              btnText: tr('save'),
                              onPressed: () => viewModel.onPressSave(context)),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: UIDefine.navigationBarPadding,
                      ),
                    ],
                  ),
                ),
              ),
            ])));
  }

  Widget _getUnEditFormView(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(title,
                style: AppTextStyle.getBaseStyle(
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
                color: AppColors.defaultBackgroundSpace,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(content,
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.dialogGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: UIDefine.fontSize14))),
      ],
    );
  }
}
