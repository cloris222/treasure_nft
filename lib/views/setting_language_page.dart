// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import '../constant/enum/setting_enum.dart';

import '../constant/theme/app_colors.dart';

import '../utils/language_util.dart';
import 'custom_appbar_view.dart';
import 'main_page.dart';

class SettingLanguagePage extends StatefulWidget {
  const SettingLanguagePage({Key? key}) : super(key: key);

  @override
  State<SettingLanguagePage> createState() => _SettingLanguagePageState();
}

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  late LanguageType currentLanguage;

  @override
  void initState() {
    super.initState();
    currentLanguage = LanguageUtil.getSettingLanguageType();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      needCover: false,
      title: tr('language'),
      type: GlobalData.mainBottomType,
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: _buildLanguageView(context)),
    );
  }

  Widget _buildLanguageView(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider(color: AppColors.searchBar);
        },
        itemBuilder: (context, index) {
          String imageCountry;
          var type = LanguageType.values[index];
          switch (type) {
            case LanguageType.English:
              {
                imageCountry = 'en';
              }
              break;
            case LanguageType.Mandarin:
              {
                imageCountry = 'tc';
              }
              break;
            case LanguageType.Arabic:
              {
                imageCountry = 'sa';
              }
              break;
            case LanguageType.Farsi:
              {
                imageCountry = 'ir';
              }
              break;
            case LanguageType.Spanish:
              {
                imageCountry = 'es';
              }
              break;
            case LanguageType.Russian:
              {
                imageCountry = 'ru';
              }
              break;
            case LanguageType.Portuguese:
              {
                imageCountry = 'pt';
              }
              break;
            case LanguageType.Korean:
              {
                imageCountry = 'kr';
              }
              break;
            case LanguageType.Vietnamese:
              {
                imageCountry = 'vn';
              }
              break;
            case LanguageType.Thai:
              {
                imageCountry = 'th';
              }
              break;
            case LanguageType.Turkish:
              {
                imageCountry = 'tr';
              }
              break;
          }
          return InkWell(
            onTap: () => _onChangeLang(context, type),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Image.asset(format(
                      AppImagePath.languageIcon, {'country': imageCountry})),
                  const SizedBox(width: 10),
                  Text(LanguageUtil.getLanguageName(type)),
                  Flexible(child: Container(width: UIDefine.getWidth())),
                  currentLanguage == type
                      ? Image.asset(AppImagePath.languageCheckIcon)
                      : Container(),
                ],
              ),
            ),
          );
        },
        itemCount: LanguageType.values.length);
  }

  _onChangeLang(BuildContext context, LanguageType currentLanguage) async {
    await LanguageUtil.setLanguageUtil(context, currentLanguage);
    // BaseViewModel().popPage(context);
    BaseViewModel()
        .pushAndRemoveUntil(context, MainPage(type: GlobalData.mainBottomType));
  }
}
