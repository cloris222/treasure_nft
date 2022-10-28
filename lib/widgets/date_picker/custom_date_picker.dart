import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/home/widget/search_action_button.dart';

class CustomDatePickerWidget extends StatefulWidget {
  const CustomDatePickerWidget({
    super.key,
    this.initType = Search.All,
    this.typeList = Search.values,
    required this.dateCallback,
  });

  final onDateFunction dateCallback;
  final Search initType;
  final List<Search> typeList;

  @override
  State<StatefulWidget> createState() {
    return CustomDatePickerState();
  }
}

class CustomDatePickerState extends State<CustomDatePickerWidget> {
  String startDate = '';
  String endDate = '';
  late Search currentType;

  @override
  void initState() {
    super.initState();
    // currentType = widget.initType;
    _onPressChoose(widget.initType);
  }

  Widget getPadding(double val) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      getPadding(3),

      /// 日期選擇器
      GestureDetector(
          onTap: () async {
            await _showDatePicker(context);
            setState(() {});
          },
          child: Container(
              width: UIDefine.getWidth(),
              height: UIDefine.getScreenHeight(8),
              decoration: TeamMemberViewModel().setBoxDecoration(),
              child: Row(children: [
                getPadding(1),
                Image.asset(AppImagePath.dateIcon),
                getPadding(1),
                Text(
                  startDate,
                  style: const TextStyle(color: AppColors.textGrey),
                ),
                getPadding(1),
                Visibility(
                    visible: endDate != '',
                    child: const Text(
                      '～',
                      style: TextStyle(color: AppColors.textGrey),
                    )),
                getPadding(1),
                Text(
                  endDate,
                  style: const TextStyle(color: AppColors.textGrey),
                )
              ]))),

      getPadding(2),
      SizedBox(
          height: UIDefine.getScreenHeight(8),
          width: UIDefine.getWidth(),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: _buildButton,
              separatorBuilder: _buildSpace,
              itemCount: widget.typeList.length)),
    ]);
  }

  Widget _buildButton(BuildContext context, int index) {
    return _buildChooseButton(widget.typeList[index]);
  }

  Widget _buildSpace(BuildContext context, int index) {
    return SizedBox(width: UIDefine.getScreenWidth(2));
  }

  _buildChooseButton(Search type) {
    return SearchActionButton(
      isSelect: currentType == type,
      btnText: '  ${getStrTypeButton(type)}  ',
      onPressed: () => _onPressChoose(type),
    );
  }

  String getStrTypeButton(Search type) {
    switch (type) {
      case Search.All:
        return tr('all');
      case Search.Today:
        return tr('today');
      case Search.Yesterday:
        return tr('yesterday');
      case Search.SevenDays:
        return tr('day7');
      case Search.ThirtyDays:
        return tr('day30');
    }
  }

  String setTypeCallback(Search type) {
    switch (type) {
      case Search.All:
        return tr('all');
      case Search.Today:
        return tr('today');
      case Search.Yesterday:
        return tr('yesterday');
      case Search.SevenDays:
        return tr('day7');
      case Search.ThirtyDays:
        return tr('day30');
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    await showDateRangePicker(
            context: context,
            firstDate: DateTime(2022, 10),
            lastDate: DateTime.now())
        .then((value) => {
              startDate =
                  DateFormatUtil().getTimeWithDayFormat(time: value?.start),
              endDate = DateFormatUtil().getTimeWithDayFormat(time: value?.end),
            })
        .then((value) async => {
              widget.dateCallback(startDate, endDate),
            });
  }

  void _onPressChoose(Search type) {
    setState(() {
      currentType = type;
      startDate = '';
      endDate = '';
      switch (type) {
        case Search.All:
          break;
        case Search.Today:
          startDate = DateFormatUtil().getTimeWithDayFormat();
          endDate = DateFormatUtil().getTimeWithDayFormat();
          break;
        case Search.Yesterday:
          startDate = DateFormatUtil().getBeforeDays(1);
          endDate = DateFormatUtil().getBeforeDays(1);
          break;
        case Search.SevenDays:
          startDate = DateFormatUtil().getBeforeDays(7);
          endDate = DateFormatUtil().getTimeWithDayFormat();
          break;
        case Search.ThirtyDays:
          startDate = DateFormatUtil().getBeforeDays(30);
          endDate = DateFormatUtil().getTimeWithDayFormat();
          break;
      }
      widget.dateCallback(startDate, endDate);
    });
  }
}