import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/home/widget/search_action_button.dart';

class DatePickerWidget extends StatefulWidget {

  String startDate;
  String endDate;
  final onDateFunction dateCallback;

  DatePickerWidget({super.key,
    this.startDate = 'Select date',
    this.endDate = '',
    required this.dateCallback,
  });

  @override
  State<StatefulWidget> createState() {
    return DatePickerState();
  }
}

class DatePickerState extends State<DatePickerWidget> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();
  Search buttonType = Search.All;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      viewModel.getPadding(3),
      /// 日期選擇器
      GestureDetector(
          onTap: () async{
            await _showDatePicker(context);
            setState(() {});
          },
          child: Container(
            width: UIDefine.getWidth(),
            height: UIDefine.getScreenHeight(10),
            decoration: viewModel.setBoxDecoration(),


            child:Row(children: [
              viewModel.getPadding(1),
              Image.asset(AppImagePath.dateIcon),
              viewModel.getPadding(1),

              Text(widget.startDate,
                style: const TextStyle(color: AppColors.textGrey),
              ),

              viewModel.getPadding(1),
              Visibility(
                  visible: widget.endDate != '',
                  child: const Text('～',
                    style: TextStyle(color: AppColors.textGrey),
                  )),
              viewModel.getPadding(1),

              Text(widget.endDate,
                style: const TextStyle(color: AppColors.textGrey),
              )

            ],),
          )),

      viewModel.getPadding(2),

      /// 快速搜尋按鈕列
      SizedBox(
          height: UIDefine.getScreenHeight(10),
          child:SingleChildScrollView(
              scrollDirection:Axis.horizontal,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  SearchActionButton(
                    isSelect: buttonType == Search.All,
                    btnText: '  ${tr('all')}  ',
                    onPressed: () async{
                      buttonType = Search.All;

                      widget.dateCallback('', '');
                    },
                  ),

                  viewModel.getPadding(2),

                  SearchActionButton(
                    isSelect: buttonType == Search.Today,
                    btnText: tr('today'),
                    onPressed: () async{
                      buttonType = Search.Today;

                      widget.startDate = viewModel.dateTimeFormat(DateTime.now());
                      widget.endDate = viewModel.dateTimeFormat(DateTime.now());

                      widget.dateCallback(widget.startDate, widget.endDate);
                    },
                  ),

                  viewModel.getPadding(2),

                  SearchActionButton(
                    isSelect: buttonType == Search.Yesterday,
                    btnText: tr('yesterday'),
                    onPressed: () async{
                      buttonType = Search.Yesterday;

                      widget.startDate = viewModel.getDays(1);
                      widget.endDate = viewModel.getDays(1);

                      widget.dateCallback(widget.startDate, widget.endDate);
                    },
                  ),

                  viewModel.getPadding(2),

                  SearchActionButton(
                    isSelect: buttonType == Search.SevenDays,
                    btnText: tr('day7'),
                    onPressed: () async{
                      buttonType = Search.SevenDays;

                      widget.startDate =  viewModel.getDays(7);
                      widget.endDate = viewModel.dateTimeFormat(DateTime.now());

                      widget.dateCallback(widget.startDate, widget.endDate);
                    },
                  ),

                  viewModel.getPadding(2),

                  SearchActionButton(
                    isSelect: buttonType == Search.ThirtyDays,
                    btnText: tr('day30'),
                    onPressed: () async{
                      buttonType = Search.ThirtyDays;

                      widget.startDate =  viewModel.getDays(30);
                      widget.endDate = viewModel.dateTimeFormat(DateTime.now());

                      widget.dateCallback(widget.startDate, widget.endDate);

                      /// 範例 ///
                      // await viewModel.getTeamOrder(
                      //     startDate, endDate).then((value)  => {
                      //   list = value,
                      // });
                      // setState(() {});
                      /// 範例 ///
                    },
                  ),
                ],))),

    ]);
  }

  Future<void> _showDatePicker(BuildContext context) async{
    await showDateRangePicker(
        context:context,
        firstDate: DateTime(2022, 10),
        lastDate: DateTime.now()).then((value) => {
      widget.startDate = viewModel.dateTimeFormat(value?.start),
      widget.endDate = viewModel.dateTimeFormat(value?.end),
    }).then((value) async => {
      widget.dateCallback(widget.startDate, widget.endDate),
    });
  }
}