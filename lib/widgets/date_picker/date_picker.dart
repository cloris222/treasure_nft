import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/home/widget/search_action_button.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

class DatePickerWidget extends StatefulWidget {
  DatePickerWidget(
      {super.key,
      this.displayALL = true,
      this.displayButton = true,
      required this.dateCallback,
      required this.startDate,
      required this.endDate,
      required this.bUsePhoneTime});

  final onDateFunction dateCallback;
  bool displayALL;
  bool displayButton;
  String startDate;
  String endDate;
  bool bUsePhoneTime;

  @override
  State<StatefulWidget> createState() {
    return DatePickerState();
  }
}

class DatePickerState extends State<DatePickerWidget> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();
  Search buttonType = Search.All;

  late String startDate;
  late String endDate;

  @override
  void initState() {
    super.initState();
    if (widget.bUsePhoneTime) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      startDate = formattedDate;
      endDate = formattedDate;
    } else {
      startDate = widget.startDate;
      endDate = widget.endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      viewModel.getPadding(3),

      /// 日期選擇器
      GestureDetector(
          onTap: () async {
            await _showDatePicker(context);
            setState(() {});
          },
          child: Container(
            width: UIDefine.getWidth(),
            height: UIDefine.getPixelWidth(40),
            decoration: viewModel.setBoxDecoration(),
            child: Row(
              children: [
                viewModel.getPadding(1),
                Image.asset(AppImagePath.dateIcon),
                viewModel.getPadding(1),
                Text(
                  startDate,
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textGrey, fontSize: UIDefine.fontSize14),
                ),
                viewModel.getPadding(1),
                Visibility(
                    visible: endDate != '',
                    child: Text(
                      '～',
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textGrey,
                          fontSize: UIDefine.fontSize14),
                    )),
                viewModel.getPadding(1),
                Text(
                  endDate,
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textGrey, fontSize: UIDefine.fontSize14),
                )
              ],
            ),
          )),

      viewModel.getPadding(2),

      /// 快速搜尋按鈕列
      Visibility(
          visible: widget.displayButton,
          child: SizedBox(
              height: UIDefine.getPixelWidth(30),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: widget.displayALL,
                        child: SearchActionButton(
                          isSelect: buttonType == Search.All,
                          btnText: '  ${tr('all')}  ',
                          onPressed: () async {
                            buttonType = Search.All;

                            widget.dateCallback('', '');
                          },
                        ),
                      ),
                      viewModel.getPadding(2),
                      SearchActionButton(
                        isSelect: buttonType == Search.Today,
                        btnText: tr('today'),
                        onPressed: () async {
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
                        onPressed: () async {
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
                        onPressed: () async {
                          buttonType = Search.SevenDays;

                          startDate = viewModel.getDays(7);
                          endDate = viewModel.dateTimeFormat(DateTime.now());

                          widget.dateCallback(startDate, endDate);
                        },
                      ),
                      viewModel.getPadding(2),
                      SearchActionButton(
                        isSelect: buttonType == Search.ThirtyDays,
                        btnText: tr('day30'),
                        onPressed: () async {
                          buttonType = Search.ThirtyDays;

                          startDate = viewModel.getDays(30);
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
                    ],
                  )))),
    ]);
  }

  Future<void> _showDatePicker(BuildContext context) async {
    await showDateRangePicker(
            context: context,
            firstDate: DateTime(2022, 10),
            lastDate: DateTime.now())
        .then((value) => {
              startDate = viewModel.dateTimeFormat(value?.start),
              endDate = viewModel.dateTimeFormat(value?.end),
            })
        .then((value) async => {
              widget.dateCallback(startDate, endDate),
            });
  }
}
