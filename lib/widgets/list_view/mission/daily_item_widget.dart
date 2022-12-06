import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/personal/team/team_order_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/text_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/warp_two_text_widget.dart';

class DailyItemWidget extends StatelessWidget {
  const DailyItemWidget({Key? key, required this.data, required this.getPoint})
      : super(key: key);
  final TaskInfoData data;
  final GetMissionPoint getPoint;

  @override
  Widget build(BuildContext context) {
    ///MARK: 取得值
    TaskStatus status = data.getTaskStatus();
    int index = data.getDailyCodeIndex();
    DailyCode code = DailyCode.values[index];

    ///MARK:建立畫面
    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          radius: 8,
          color: status == TaskStatus.unTaken
              ? AppColors.mainThemeButton
              : AppColors.bolderGrey,
          borderLine: 2),
      child: Container(
          margin: EdgeInsets.symmetric(
              vertical: UIDefine.getPixelHeight(15),
              horizontal: UIDefine.getPixelHeight(15)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: UIDefine.getPixelHeight(80),
                          width: UIDefine.getPixelHeight(80),
                          child: Image.asset(
                            getImagePath(status, index),
                            fit: BoxFit.fill,
                          )),
                      const SizedBox(width: 5),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: UIDefine.getPixelHeight(4),
                                  right: UIDefine.getPixelHeight(4)),
                              child: _buildTaskInfo(context, status, code)))
                    ]),
                Padding(
                  padding: EdgeInsets.only(
                      top: UIDefine.getPixelHeight(10),
                      left: UIDefine.getPixelHeight(4),
                      right: UIDefine.getPixelHeight(4)),
                  child: Text(
                      '${tr('mis_award')} : ${data.point} ${tr('point')}',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: UIDefine.fontSize14,
                          color: AppColors.dialogGrey,
                          fontWeight: FontWeight.w500)),
                )
              ])),
    );
  }

  Widget _buildButton(BuildContext context, TaskStatus status, DailyCode code) {
    switch (status) {
      case TaskStatus.notFinish:
        {
          String btnText = '';
          bool visible = false;
          VoidCallback onPress = () {};
          switch (code) {
            case DailyCode.DlySignIn:
            case DailyCode.DlyTeamBuyFreq:
            case DailyCode.DlyTeamBuyAmt:
              break;

            ///MARK: 前往購買頁面
            case DailyCode.DlyRsvScs:
            case DailyCode.DlyBuyScs:
            case DailyCode.DlySlfBuyAmt:
              {
                visible = true;
                btnText = tr('mis_goto');
                onPress = () {
                  BaseViewModel().pushAndRemoveUntil(context,
                      const MainPage(type: AppNavigationBarType.typeTrade));
                };
              }
              break;

            ///MARK:前往收藏
            case DailyCode.DlyInvClsA:
            case DailyCode.DlyInvClsBC:
              {
                visible = true;
                btnText = tr('mis_goto');
                onPress = () {
                  BaseViewModel().pushAndRemoveUntil(
                      context,
                      const MainPage(
                          type: AppNavigationBarType.typeCollection));
                };
              }
              break;

            ///MARK: 前往團隊訂單
            case DailyCode.DlyShr:
              {
                visible = true;
                btnText = tr('mis_goto');
                onPress = () {
                  BaseViewModel()
                      .pushReplacement(context, const TeamOrderPage());
                };
              }
              break;
          }

          return Visibility(
              visible: visible,
              child: TextButtonWidget(
                  fontSize: UIDefine.fontSize12,
                  isFillWidth: false,
                  isBorderStyle: true,
                  btnText: btnText,
                  onPressed: onPress));
        }
      case TaskStatus.unTaken:
        {
          return TextButtonWidget(
              fontSize: UIDefine.fontSize12,
              isFillWidth: false,
              btnText: tr('acceptReward'),
              onPressed: () {
                getPoint(data.recordNo!, data.point);
              });
        }
      case TaskStatus.isTaken:
        {
          return TextButtonWidget(
              fontSize: UIDefine.fontSize12,
              isFillWidth: false,
              setMainColor: AppColors.datePickerBorder,
              setSubColor: AppColors.dialogGrey,
              btnText: tr('acceptedReward'),
              onPressed: () {});
        }
    }
  }

  String getImagePath(TaskStatus status, int index) {
    String strStatus;
    switch (status) {
      case TaskStatus.notFinish:
        strStatus = 'disable';
        break;
      case TaskStatus.unTaken:
        strStatus = 'focus';
        break;
      case TaskStatus.isTaken:
        strStatus = 'finish';
        break;
    }
    return format(
        '${AppImagePath.dailyMission}/dm_{index}_01_{strStatus}.png', {
      'index': NumberFormatUtil().integerTwoFormat(index + 1),
      'strStatus': strStatus
    });
  }

  Widget _buildTaskInfo(
      BuildContext context, TaskStatus status, DailyCode code) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: WarpTwoTextWidget(
                  text: data.getDailyTaskText(),
                  fontSize: UIDefine.fontSize16,
                  color: AppColors.dialogBlack,
                  fontWeight: FontWeight.w500),
            ),
            Container(
                alignment: Alignment.topCenter,
                child: _buildButton(context, status, code)),
          ]),
      const SizedBox(height: 5),
      WarpTwoTextWidget(
          fontSize: UIDefine.fontSize14,
          text: data.getDailyTaskSubText(),
          color: AppColors.dialogGrey,
          fontWeight: FontWeight.w400)
    ]);
  }
}
