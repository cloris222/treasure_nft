import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../models/http/parameter/country_phone_data.dart';
import '../../../widgets/label/error_text_widget.dart';
import '../../../widgets/text_field/login_text_widget.dart';

/// 區碼選擇 + 電話號碼輸入框
class PhoneParamView extends StatelessWidget {
  const PhoneParamView(
      {Key? key,
      this.initCountry,
      required this.titleText,
      required this.hintText,
      required this.controller,
      required this.data,
      required this.getDropDownValue,
      this.isSecure = false,
      this.onChanged,
      this.onTap})
      : super(key: key);
  final String? initCountry;
  final String titleText;
  final String hintText;
  final TextEditingController controller;
  final bool isSecure;
  final ValidateResultData data;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final onGetStringFunction getDropDownValue;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildTextTitle(titleText),
      Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
              padding: EdgeInsets.only(left: UIDefine.getScreenWidth(36)),
              child: LoginTextWidget(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"\d"))
                ],
                keyboardType: TextInputType.number,
                hintText: hintText,
                controller: controller,
                initColor:
                    data.result ? AppColors.bolderGrey : AppColors.textRed,
                enabledColor:
                    data.result ? AppColors.bolderGrey : AppColors.textRed,
                focusedColor: AppColors.mainThemeButton,
                isSecure: isSecure,
                onChanged: onChanged,
                onTap: onTap,
              )),
          Positioned(
            left: 0,
            child: Container(
              alignment: Alignment.center,
              height: UIDefine.getPixelHeight(60),
              margin:
                  EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(5)),
              child: Container(
                  width: UIDefine.getScreenWidth(38),
                  decoration: const BoxDecoration(
                      color: AppColors.mainThemeButton,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: _dropDownBar()),
            ),
          )
        ],
      ),
      ErrorTextWidget(data: data, alignment: Alignment.centerRight)
    ]);
  }

  Widget _buildTextTitle(String text) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)));
  }

  Widget _dropDownBar() {
    return DropdownButtonFormField(
      dropdownColor: AppColors.mainThemeButton,
      icon: Image.asset('assets/icon/btn/btn_arrow_03_down.png'),
      onChanged: (newValue) {
        // 將選擇的傳至外部 ex: +65 (只有區碼)
        getDropDownValue(newValue!);
      },
      value: initCountry ??
          (GlobalData.country.isNotEmpty
              ? GlobalData.country.first.country
              : ''),
      decoration: InputDecoration(
        iconColor: AppColors.mainThemeButton,
        contentPadding: EdgeInsets.fromLTRB(
            UIDefine.getScreenWidth(2.5), 0, UIDefine.getScreenWidth(1), 0),
        border: InputBorder.none,
      ),
      items: GlobalData.country.map((CountryPhoneData data) {
        return DropdownMenuItem(
            value: data.country,
            child: Row(
              children: <Widget>[
                Text('+${data.areaCode} ${_getSubString(tr(data.country))}',
                    style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: UIDefine.fontSize12)),
              ],
            ));
      }).toList(),
    );
  }

  String _getSubString(String value) {
    return value.length >= 10 ? '${value.substring(0, 10)}...' : value;
  }

  String _getCategoryText(String value) {
    // 下拉選單 多國
    switch (value) {
      case '+1':
        return tr('America') + ' ' + tr('Canada');
      case '+966':
        return tr('SaudiArabia');
      case '+962':
        return tr('Jordan');
      case '+34':
        return tr('Spain');
      case '+55':
        return tr('Brazil');
      case '+65':
        return tr('Singapore');
      case '+965':
        return tr('Kuwait');
      case '+98':
        return tr('Iran');
      case '+886':
        return tr('Taiwan');
      case '+63':
        return tr('Philippines');
      case '+90':
        return tr('Turkey');
      case '+44':
        return 'Britain';
      case '+243':
        return 'Congo';
      case '+20':
        return 'Egypt';
      case '+56':
        return 'Chile';
    }
    return '';
  }
}
