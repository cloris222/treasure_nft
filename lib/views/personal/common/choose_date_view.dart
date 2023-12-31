import 'package:flutter/material.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_theme.dart';
import '../../../constant/ui_define.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../widgets/label/error_text_widget.dart';

class ChooseDateView extends StatelessWidget {
  const ChooseDateView({
    Key? key,
    required this.titleText,
    required this.hintText,
    required this.controller,
    required this.data,
    this.isSecure = false,
    this.onChanged,
    this.onTap,
    this.bShowRed = false,
  }) : super(key: key);
  final String titleText;
  final String hintText;
  final TextEditingController controller;
  final bool isSecure;
  final ValidateResultData data;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool bShowRed;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildTextTitle(titleText),
      _buildEdit(),
      ErrorTextWidget(data: data, alignment: Alignment.centerRight)
    ]);
  }

  Widget _buildEdit() {
    Color color = data.result ? AppColors.bolderGrey : AppColors.textRed;
    return Container(
        alignment: Alignment.center,
        // height: UIDefine.getPixelWidth(60),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: GestureDetector(
          onTap: onTap,
          child: TextField(
              enabled: false,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              style: AppTextStyle.getBaseStyle(color: Colors.black),
              decoration: InputDecoration(
                isCollapsed: true,
                hintText: hintText,
                hintStyle: AppTextStyle.getBaseStyle(height: 1.1),
                labelStyle: AppTextStyle.getBaseStyle(color: Colors.black),
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.only(
                    top: UIDefine.getPixelWidth(15),
                    bottom: UIDefine.getPixelWidth(15),
                    left: 20),
                disabledBorder: AppTheme.style
                    .styleTextEditBorderBackground(color: color, radius: 10),
                enabledBorder: AppTheme.style
                    .styleTextEditBorderBackground(color: color, radius: 10),
                focusedBorder: AppTheme.style
                    .styleTextEditBorderBackground(color: color, radius: 10),
                border: AppTheme.style
                    .styleTextEditBorderBackground(color: color, radius: 10),
                suffixIcon: _buildSecureView(),
              )),
        ));
  }

  Widget _buildTextTitle(String text) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(text,
                style: AppTextStyle.getBaseStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: UIDefine.fontSize14)),
            bShowRed
                ? Text('*',
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textRed,
                        fontSize: UIDefine.fontSize20))
                : const SizedBox()
          ],
        ));
  }

  Widget _buildSecureView() {
    return Image.asset(AppImagePath.dateIcon);
  }
}
