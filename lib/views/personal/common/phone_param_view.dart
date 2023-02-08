import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/drop_buttom/custom_drop_button.dart';

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
  int currentIndex = 0;

  @override
  void initState() {
    currentCountry = widget.initCountry ??
        (GlobalData.country.isNotEmpty ? GlobalData.country.first.country : '');
    for (int i = 0; i < GlobalData.country.length; i++) {
      if (GlobalData.country[i].country == currentCountry) {
        currentIndex = i;
      }
    }
    widget.getDropDownValue(currentCountry);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildTextTitle(widget.titleText),
      Stack(
        alignment: Alignment.centerLeft,
        children: [
          LoginTextWidget(
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"\d"))],
            contentPaddingLeft: UIDefine.getScreenWidth(38),
            keyboardType: TextInputType.number,
            hintText: widget.hintText,
            controller: widget.controller,
            initColor:
                widget.data.result ? AppColors.bolderGrey : AppColors.textRed,
            enabledColor:
                widget.data.result ? AppColors.bolderGrey : AppColors.textRed,
            bFocusedGradientBolder: true,
            isSecure: widget.isSecure,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
          ),
          Positioned(
              left: UIDefine.getScreenWidth(37),
              child: Container(
                width: 1,
                height: UIDefine.getPixelHeight(35),
                decoration: AppStyle()
                    .styleColorsRadiusBackground(color: AppColors.bolderGrey),
              )),
          Positioned(
            left: 0,
            top: UIDefine.getPixelHeight(5),
            bottom: UIDefine.getPixelHeight(5),
            child: Container(
              alignment: Alignment.center,
              width: UIDefine.getScreenWidth(37),
              height: UIDefine.getPixelHeight(50),
              child: _dropDownBar(),
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
    return CustomDropButton(
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(1),
          vertical: UIDefine.getPixelWidth(3)),
      needBorderBackground: false,
      initIndex: currentIndex,
      listLength: GlobalData.country.length,
      itemString: _buildItemString,
      onChanged: (int index) {
        currentIndex = index;
        widget.getDropDownValue(GlobalData.country[index].country);
        currentCountry = GlobalData.country[index].country;
      },
    );
  }

  String _getSubString(String value) {
    return value.length >= 10 ? '${value.substring(0, 10)}...' : value;
  }

  String _buildItemString(int index) {
    CountryPhoneData data = GlobalData.country[index];
    return '+${data.areaCode} ${_getSubString(tr(data.country))}';
  }
}
