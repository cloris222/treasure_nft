import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../gradient_third_text.dart';

class CustomDropButton extends StatefulWidget {
  const CustomDropButton(
      {Key? key,
      required this.listLength,
      required this.itemString,
      this.itemIcon,
      required this.onChanged,
      this.initIndex,
      this.needBorderBackground = true,
      this.needBackgroundOpacity = false,
      this.height,
      this.buildCustomDropItem,
      this.buildCustomSelectHintItem,
      this.buildCustomDropCurrentItem,
      this.padding,
      this.hintSelect,
      this.dropdownWidth,
      this.needShowEmpty = true,
      this.dropdownDecoration,
      this.itemHeight,
      this.needGradient = true,
      this.needHorizontalPadding = true,
      this.showClearButton = false,
      this.onPressClear,
      this.needArrow = true,
      })
      : super(key: key);
  final int listLength;
  final int? initIndex;
  final Widget Function(int index, bool needGradientText, bool needArrow)?
      buildCustomDropItem;
  final Widget Function(int? currentIndex)? buildCustomDropCurrentItem;
  final String Function(int index, bool needArrow) itemString;
  final Widget Function(int index)? itemIcon;
  final void Function(int index) onChanged;
  final double? height;
  final bool needBorderBackground;
  final bool needBackgroundOpacity;
  final EdgeInsetsGeometry? padding;
  final String? hintSelect;
  final double? dropdownWidth;
  final Widget Function()? buildCustomSelectHintItem;
  final bool needShowEmpty;
  final BoxDecoration? dropdownDecoration;
  final double? itemHeight;
  final bool needGradient;
  final bool needHorizontalPadding;
  final bool showClearButton;
  final onClickFunction? onPressClear;
  final bool needArrow;

  @override
  State<CustomDropButton> createState() => _CustomDropButtonState();
}

class _CustomDropButtonState extends State<CustomDropButton> {
  int? currentIndex;

  @override
  void didUpdateWidget(covariant CustomDropButton oldWidget) {
    if (widget.initIndex != null) {
      setState(() {
        currentIndex = widget.initIndex;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

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
              color: AppColors.bolderGrey,
              backgroundColor: widget.needBackgroundOpacity
                  ? AppColors.textWhite.withOpacity(0.5)
                  : AppColors.textWhite,
              radius: 8,
              borderLine: 1)
          : null,
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(10),
          vertical: UIDefine.getPixelWidth(3)),
      child: Stack(children: [
        DropdownButtonHideUnderline(
            child: DropdownButton2(
              buttonPadding:const EdgeInsets.all(0),
              itemPadding: widget.needHorizontalPadding
                  ? const EdgeInsets.all(0)
                  : EdgeInsets.only(right: UIDefine.getPixelHeight(1)),
              dropdownDecoration: widget.dropdownDecoration,
              offset: Offset(0, -UIDefine.getPixelWidth(20)),
              customButton: widget.buildCustomDropCurrentItem != null
                  ? widget.buildCustomDropCurrentItem!(currentIndex)
                  : currentIndex != null
                  ? _buildDropItem(currentIndex!, false, widget.needArrow)
                  : _buildSelectHintItem(),
              isExpanded: true,
              items: List<DropdownMenuItem<int>>.generate(_getListLength(), (index) {
                return DropdownMenuItem<int>(
                    enabled: !(widget.listLength == 0 && widget.needShowEmpty),
                    value: index,
                    child: _buildDropItem(index, widget.needGradient, false));
              }),
              value: widget.listLength == 0 ? null : currentIndex,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    currentIndex = value;
                  });
                  widget.onChanged(currentIndex!);
                }
              },
              dropdownWidth: widget.dropdownWidth,
              itemHeight: widget.itemHeight ?? UIDefine.getPixelWidth(40),

            )),

        Visibility(
            visible: widget.showClearButton,
            child:Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: const Icon(Icons.clear),
                  onTap: () => {widget.onPressClear!()},
                )
            )),

      ])

    );
  }

  Widget _buildSelectHintItem() {
    if (widget.buildCustomSelectHintItem != null) {
      return widget.buildCustomSelectHintItem!();
    }

    return _buildItem(
        textColor: AppColors.textHintGrey,
        context: widget.hintSelect ?? tr('hintSelect'),
        index: -1,
        needGradientText: false,
        needArrow: true);
  }

  Widget _buildDropItem(int index, bool needGradientText, bool needArrow) {
    if (widget.listLength == 0 && widget.needShowEmpty) {
      return _buildItem(
          context: tr('rechargeMaintain'),
          index: index,
          needGradientText: needGradientText,
          needArrow: needArrow);
    }

    if (widget.buildCustomDropItem != null) {
      return widget.buildCustomDropItem!(index, needGradientText, needArrow);
    }

    return _buildItem(
        index: index, needGradientText: needGradientText, needArrow: needArrow);
  }

  Widget _buildItem(
      {String? context,
      required int index,
      required bool needGradientText,
      required bool needArrow,
      Color? textColor}) {
    bool isCurrent = (currentIndex == index);
    String itemContext = '';
    if (context != null) {
      isCurrent = false;
      itemContext = context;
    } else {
      itemContext = _getItemString(index, needArrow);
    }
    return Container(
      alignment: Alignment.centerLeft,
      height: widget.height ?? UIDefine.getPixelWidth(40),
      padding: widget.needHorizontalPadding
          ? const EdgeInsets.symmetric(horizontal: 8.0)
          : const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///MARK: 未選擇時 index=-1
          widget.itemIcon != null && widget.listLength > 0 && index >= 0
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: UIDefine.getPixelWidth(5)),
                  child: widget.itemIcon!(index))
              : const SizedBox(),
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
                      itemContext,
                      maxLines: needArrow ? 1 : null,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.getBaseStyle(
                          color: textColor ?? AppColors.textBlack,
                          fontSize: UIDefine.fontSize14),
                    ),
            ),
          ),
          Visibility(
              visible: needArrow,
              child: Image.asset(AppImagePath.arrowDownGrey))
        ],
      ),
    );
  }

  String _getItemString(int index, bool needArrow) {
    if (widget.listLength == 0) {
      return widget.hintSelect ?? tr('hintSelect');
    }
    return widget.itemString(index, needArrow);
  }

  int _getListLength() {
    return widget.listLength > 0
        ? widget.listLength
        : widget.needShowEmpty
            ? 1
            : 0;
  }
}
