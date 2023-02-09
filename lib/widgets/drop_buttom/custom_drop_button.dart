import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

class CustomDropButton extends StatefulWidget {
  const CustomDropButton(
      {Key? key,
      required this.listLength,
      required this.itemString,
      required this.onChanged,
      this.initIndex = 0,
      this.needBorderBackground = true,
      this.height,
      this.buildCustomDropItem,
      this.padding})
      : super(key: key);
  final int listLength;
  final int initIndex;
  final Widget Function(int index, bool needGradientText, bool needArrow)?
      buildCustomDropItem;
  final String Function(int index, bool needArrow) itemString;
  final void Function(int index) onChanged;
  final double? height;
  final bool needBorderBackground;
  final EdgeInsetsGeometry? padding;

  @override
  State<CustomDropButton> createState() => _CustomDropButtonState();
}

class _CustomDropButtonState extends State<CustomDropButton> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget.initIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownBar();
  }

  Widget _dropDownBar() {
    return Container(
      decoration: widget.needBorderBackground
          ? AppStyle().styleColorBorderBackground(
              color: AppColors.bolderGrey, radius: 8, borderLine: 1)
          : null,
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(10),
          vertical: UIDefine.getPixelWidth(3)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        customButton: _buildDropItem(currentIndex, false, true),
        isExpanded: true,
        items: List<DropdownMenuItem<int>>.generate(widget.listLength, (index) {
          return DropdownMenuItem<int>(
              value: index, child: _buildDropItem(index, true, false));
        }),
        value: widget.listLength == 0 ? null : currentIndex,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              currentIndex = value;
            });
            widget.onChanged(currentIndex);
          }
        },
        dropdownWidth: UIDefine.getWidth() / 2,
        itemHeight: UIDefine.getPixelWidth(40),
      )),
    );
  }

  Widget _buildDropItem(int index, bool needGradientText, bool needArrow) {
    if (widget.buildCustomDropItem != null) {
      return widget.buildCustomDropItem!(index, needGradientText, needArrow);
    }

    bool isCurrent = (currentIndex == index);
    return Container(
      alignment: Alignment.centerLeft,
      height: widget.height ?? UIDefine.getPixelWidth(40),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: isCurrent && needGradientText
                  ? GradientThirdText(
                      widget.itemString(index, needArrow),
                      maxLines: needArrow ? 1 : null,
                      overflow: TextOverflow.ellipsis,
                      size: UIDefine.fontSize14,
                    )
                  : Text(
                      widget.itemString(index, needArrow),
                      maxLines: needArrow ? 1 : null,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize14,
                          color: AppColors.textSixBlack),
                    ),
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
}
