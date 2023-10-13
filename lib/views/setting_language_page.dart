// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import '../constant/enum/setting_enum.dart';

import '../constant/subject_key.dart';
import '../constant/theme/app_colors.dart';

import '../utils/language_util.dart';
import '../utils/observer_pattern/notification_data.dart';

class SettingLanguagePage extends StatefulWidget {
  const SettingLanguagePage({Key? key, required this.isMainPage})
      : super(key: key);
  final bool isMainPage;

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
    return GestureDetector(
      onTap: () => BaseViewModel().popPage(context),
      child: Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: Container(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: Container(
                margin: EdgeInsets.all(MediaQuery.of(context).padding.top),
                color: Colors.white,
                width: UIDefine.getPixelWidth(240),
                child: _buildLanguageView(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageView(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          // return const Divider(color: AppColors.searchBar);
          return const SizedBox();
        },
        itemBuilder: (context, index) {
          String imageCountry;
          var type = LanguageType.values[index];
          switch (type) {
            case LanguageType.English:
              {
                imageCountry = 'America';
              }
              break;
            case LanguageType.Mandarin:
              {
                imageCountry = 'Taiwan';
              }
              break;
            case LanguageType.Arabic:
              {
                imageCountry = 'SaudiArabia';
              }
              break;
            case LanguageType.Farsi:
              {
                imageCountry = 'Iran';
              }
              break;
            case LanguageType.Spanish:
              {
                imageCountry = 'Spain';
              }
              break;
            case LanguageType.Russian:
              {
                imageCountry = 'Russia';
              }
              break;
            case LanguageType.Portuguese:
              {
                imageCountry = 'Portugal';
              }
              break;
            case LanguageType.Korean:
              {
                imageCountry = 'Korea';
              }
              break;
            case LanguageType.Vietnamese:
              {
                imageCountry = 'VietNam';
              }
              break;
            case LanguageType.Thai:
              {
                imageCountry = 'Thailand';
              }
              break;
            case LanguageType.Turkish:
              {
                imageCountry = 'Turkey';
              }
              break;
            case LanguageType.Malaysia:
              {
                imageCountry = 'Malaysia';
              }
              break;
            case LanguageType.Indonesia:
              {
                imageCountry = 'Indonesia';
              }
              break;
            case LanguageType.Chinese:
              {
                imageCountry = 'China';
              }
              break;
            case LanguageType.Japan:
              {
                imageCountry = 'Japan';
              }
              break;
            case LanguageType.Francais:
              {
                imageCountry = "Francais";
              }
              break;
            case LanguageType.Bulgaria:
              {
                imageCountry = "Bulgaria";
              }
              break;
          }
          return InkWell(
            onTap: () => _onChangeLang(context, type),
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: UIDefine.getPixelWidth(40),
                child: Text(
                  LanguageUtil.getLanguageName(type),
                  maxLines: 1,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize16,
                      fontWeight: FontWeight.w400),
                )),
          );
        },
        itemCount: LanguageType.values.length);
  }

  _onChangeLang(BuildContext context, LanguageType currentLanguage) async {
    BaseViewModel().popPage(context);
    LanguageUtil.setLanguageUtil(context, currentLanguage).then((value) {
      GlobalData.languageSubject.notifyObservers(NotificationData(
          key: SubjectKey.keyChangeLanguage, data: widget.isMainPage));
    });
  }
}
