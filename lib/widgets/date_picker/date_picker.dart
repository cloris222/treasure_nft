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
  bool displayALL;
  bool displayButton;

  DatePickerWidget({super.key,
    this.startDate = 'Select date',
    this.endDate = '',
    this.displayALL = true,
    this.displayButton = true,
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

  String startDate = '';
  String endDate = '';

  @override
  void initState() {
    super.initState();
    startDate = widget.startDate;
    endDate = widget.endDate;
  }

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
            height: UIDefine.getScreenHeight(5)+30,
            decoration: viewModel.setBoxDecoration(),


            child:Row(children: [
              viewModel.getPadding(1),
              Image.asset(AppImagePath.dateIcon),
              viewModel.getPadding(1),

              Text(startDate,
                style: const TextStyle(color: AppColors.textGrey),
              ),

              viewModel.getPadding(1),
              Visibility(
                  visible: endDate != '',
                  child: const Text('～',
                    style: TextStyle(color: AppColors.textGrey),
                  )),
              viewModel.getPadding(1),

              Text(endDate,
                style: const TextStyle(color: AppColors.textGrey),
              )

            ],),
          )),

      viewModel.getPadding(2),

      /// 快速搜尋按鈕列
      Visibility(
        visible: widget.displayButton,
        child: SizedBox(
            height: UIDefine.getScreenHeight(10),
            child:SingleChildScrollView(
                scrollDirection:Axis.horizontal,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Visibility(
                      visible: widget.displayALL,
                      child: SearchActionButton(
                        isSelect: buttonType == Search.All,
                        btnText: '  ${tr('all')}  ',
                        onPressed: () async{
                          buttonType = Search.All;

                          widget.dateCallback('', '');
                        },
                      ),
                    ),

                    viewModel.getPadding(2),

                    SearchActionButton(
                      isSelect: buttonType == Search.Today,
                      btnText: tr('today'),
                      onPressed: () async{
                        buttonType = Search.Today;

                        startDate = viewModel.dateTimeFormat(DateTime.now());
                        endDate = viewModel.dateTimeFormat(DateTime.now());

                        widget.dateCallback(startDate, endDate);
                      },
                    ),

                    viewModel.getPadding(2),

                    SearchActionButton(
                      isSelect: buttonType == Search.Yesterday,
                      btnText: tr('yesterday'),
                      onPressed: () async{
                        buttonType = Search.Yesterday;

                        startDate = viewModel.getDays(1);
                        endDate = viewModel.getDays(1);

                        widget.dateCallback(startDate, endDate);
                      },
                    ),

                    viewModel.getPadding(2),

                    SearchActionButton(
                      isSelect: buttonType == Search.SevenDays,
                      btnText: tr('day7'),
                      onPressed: () async{
                        buttonType = Search.SevenDays;

                        startDate =  viewModel.getDays(7);
                        endDate = viewModel.dateTimeFormat(DateTime.now());

                        widget.dateCallback(startDate, endDate);
                      },
                    ),

                    viewModel.getPadding(2),

                    SearchActionButton(
                      isSelect: buttonType == Search.ThirtyDays,
                      btnText: tr('day30'),
                      onPressed: () async{
                        buttonType = Search.ThirtyDays;

                        startDate =  viewModel.getDays(30);
                        endDate = viewModel.dateTimeFormat(DateTime.now());

                        widget.dateCallback(startDate, endDate);

                        /// 範例 ///
                        // await viewModel.getTeamOrder(
                        //     startDate, endDate).then((value)  => {
                        //   list = value,
                        // });
                        // setState(() {});
                        /// 範例 ///
                      },
                    ),
                  ],)))
      ),

    ]);
  }

  Future<void> _showDatePicker(BuildContext context) async{
    await showDateRangePicker(
        context:context,
        firstDate: DateTime(2022, 10),
        lastDate: DateTime.now()).then((value) => {
      startDate = viewModel.dateTimeFormat(value?.start),
      endDate = viewModel.dateTimeFormat(value?.end),
    }).then((value) async => {
      widget.dateCallback(startDate, endDate),
    });
  }
}