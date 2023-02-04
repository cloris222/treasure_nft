import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(1),
          vertical: UIDefine.getPixelWidth(3)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        customButton: _buildDropItem(currentIndex, false, true),
        isExpanded: true,
        items: List<DropdownMenuItem<int>>.generate(GlobalData.country.length,
            (index) {
          return DropdownMenuItem<int>(
              value: index, child: _buildDropItem(index, true, false));
        }),
        value: currentIndex,
        onChanged: (value) {
          if (value != null) {
            currentIndex = value;
            widget.getDropDownValue(GlobalData.country[value].country);
            setState(() {
              currentCountry = GlobalData.country[value].country;
            });
          }
        },
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      )),
    );
  }

  Widget _buildDropItem(int index, bool needGradientText, bool needArrow) {
    CountryPhoneData data = GlobalData.country[index];
    bool isCurrent = (currentCountry == data.country);
    String countryText = '+${data.areaCode} ${_getSubString(tr(data.country))}';
    return Container(
      alignment: Alignment.centerLeft,
      height: UIDefine.getPixelWidth(40),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: isCurrent && needGradientText
                ? GradientThirdText(
                    countryText,
                    maxLines: needArrow ? 1 : null,
                    size: UIDefine.fontSize14,
                  )
                : Text(
                    countryText,
                    maxLines: needArrow ? 1 : null,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize14,
                        color: AppColors.textSixBlack),
                  ),
          ),
          Visibility(
              visible: needArrow,
              child: BaseIconWidget(
                  imageAssetPath: AppImagePath.arrowDownGrey,
                  size: UIDefine.getPixelWidth(8)))
        ],
      ),
    );
  }

  String _getSubString(String value) {
    return value.length >= 10 ? '${value.substring(0, 10)}...' : value;
  }
}
