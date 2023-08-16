import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../models/data/validate_result_data.dart';
import '../label/error_text_widget.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

/// 單日日期選擇器
class DatePickerOne extends StatefulWidget {
  const DatePickerOne(
      {super.key,
      this.onTap,
      required this.getValue,
      required this.data,
      required this.enabledColor,
      this.initDate});

  final GestureTapCallback? onTap;
  final onGetStringFunction getValue;
  final ValidateResultData data;
  final Color enabledColor; //可用狀態
  final String? initDate;

  @override
  State<StatefulWidget> createState() => _DatePickerOne();
}

class _DatePickerOne extends State<DatePickerOne> {
  String date = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await _showDatePicker(context).then((value) => {
                date = dateTimeFormat(value),
                widget.getValue(date),
                setState(() {})
              });
        },
        child: Column(
          children: [
            Container(
              width: UIDefine.getWidth(),
              height: UIDefine.getPixelWidth(40),
              decoration: _setBoxDecoration(),
              child: Row(
                children: [
                  _getPadding(1),
                  Text(
                    widget.initDate ?? (date.isEmpty ? tr("placeholder-date'") : date),
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textGrey,
                        fontSize: UIDefine.fontSize14),
                  ),
                  const Spacer(),
                  Image.asset(AppImagePath.dateIcon),
                  _getPadding(1),
                ],
              ),
            ),
            const SizedBox(height: 5),
            ErrorTextWidget(data: widget.data, alignment: Alignment.centerRight)
          ],
        ));
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 01),
        lastDate: DateTime.now());
  }

  BoxDecoration _setBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: widget.enabledColor),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _getPadding(double val) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)));
  }

  String dateTimeFormat(DateTime? time) {
    return DateFormat('yyyy-MM-dd',"en_US").format(time ?? DateTime.now());
  }
}
