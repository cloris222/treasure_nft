import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../models/http/parameter/country_phone_data.dart';
import '../../../widgets/label/error_text_widget.dart';
import '../../../widgets/text_field/login_text_widget.dart';

/// 區碼選擇 + 電話號碼輸入框
class PhoneParamView extends StatefulWidget {
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
  State<PhoneParamView> createState() => _PhoneParamViewState();
}

class _PhoneParamViewState extends State<PhoneParamView> {
  String currentCountry = '';

  @override
  void initState() {
    currentCountry = widget.initCountry ??
        (GlobalData.country.isNotEmpty ? GlobalData.country.first.country : '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildTextTitle(widget.titleText),
      Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
              padding: EdgeInsets.only(left: UIDefine.getScreenWidth(37)),
              child: LoginTextWidget(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"\d"))
                ],
                keyboardType: TextInputType.number,
                hintText: widget.hintText,
                controller: widget.controller,
                initColor: widget.data.result
                    ? AppColors.bolderGrey
                    : AppColors.textRed,
                enabledColor: widget.data.result
                    ? AppColors.bolderGrey
                    : AppColors.textRed,
                bFocusedGradientBolder: true,
                isSecure: widget.isSecure,
                onChanged: widget.onChanged,
                onTap: widget.onTap,
              )),
          Positioned(
            left: 0,
            child: Container(
              alignment: Alignment.center,
              height: UIDefine.getPixelHeight(60),
              width: UIDefine.getScreenWidth(40),
              padding:
                  EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(8.7)),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.bolderGrey, width: 1.5),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: _dropDownBar()),
            ),
          )
        ],
      ),
      ErrorTextWidget(data: widget.data, alignment: Alignment.centerRight)
    ]);
  }

  Widget _buildTextTitle(String text) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Text(text,
            style: AppTextStyle.getBaseStyle(
                fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize14)));
  }

  Widget _dropDownBar() {
    return DropdownButtonFormField(
      // dropdownColor: AppColors.mainThemeButton,
      icon: Image.asset(AppImagePath.arrowDownGrey),
      onChanged: (newValue) {
        // 將選擇的傳至外部 ex: +65 (只有區碼)
        widget.getDropDownValue(newValue!);
        setState(() {
          currentCountry = newValue;
        });
      },
      value: currentCountry,
      decoration: InputDecoration(
        iconColor: AppColors.mainThemeButton,
        contentPadding:
            EdgeInsets.fromLTRB(UIDefine.getScreenWidth(2.5), 0, 0, 0),
        border: InputBorder.none,
      ),
      items: GlobalData.country.map((CountryPhoneData data) {
        bool isCurrent = (currentCountry == data.country);
        String countryText =
            '+${data.areaCode} ${_getSubString(tr(data.country))}';
        return DropdownMenuItem(
            value: data.country,
            child: SizedBox(
              width: UIDefine.getScreenWidth(30),
              child: isCurrent
                  ? GradientThirdText(
                      countryText,
                      size: UIDefine.fontSize14,
                    )
                  : Text(countryText,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textBlack,
                          fontSize: UIDefine.fontSize14)),
            ));
      }).toList(),
    );
  }

  String _getSubString(String value) {
    return value.length >= 10 ? '${value.substring(0, 10)}...' : value;
  }
}
