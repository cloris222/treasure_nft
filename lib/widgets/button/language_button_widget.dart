import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/language_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';

class LanguageButtonWidget extends StatefulWidget {
  const LanguageButtonWidget({Key? key, required this.iconSize})
      : super(key: key);
  final double iconSize;

  @override
  State<LanguageButtonWidget> createState() => _LanguageButtonWidgetState();
}

class _LanguageButtonWidgetState extends State<LanguageButtonWidget> {
  late LanguageType currentLanguage;

  @override
  void initState() {
    super.initState();
    currentLanguage = LanguageUtil.getSettingLanguageType();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: Image.asset(AppImagePath.globalImage,
              width: widget.iconSize,
              height: widget.iconSize,
              fit: BoxFit.cover),
          items: [
            ...LanguageType.values
                .map((LanguageType type) => DropdownMenuItem<LanguageType>(
                      value: type,
                      child: _buildCell(type),
                    ))
          ],
          onChanged: (type) {
            if (type != null) {
              if (type != currentLanguage) {
                currentLanguage = type;
                LanguageUtil.setLanguageUtil(context, type).then((value) {
                  BaseViewModel().pushAndRemoveUntil(
                      context, MainPage(type: GlobalData.mainBottomType));
                });
              }
            }
          },
          barrierColor: const Color(0x78000000),
          itemHeight: 48,
          itemPadding: const EdgeInsets.only(left: 16, right: 16),
          dropdownWidth: UIDefine.getPixelWidth(240),
          dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          dropdownElevation: 8,
          offset: const Offset(40, -4),
        ),
      ),
    );
  }

  Widget _buildCell(LanguageType type) {
    String imageCountry;
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
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        LanguageUtil.getLanguageName(type),
        maxLines: 1,
        style: AppTextStyle.getBaseStyle(
            fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
