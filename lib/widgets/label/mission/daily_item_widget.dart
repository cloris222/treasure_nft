import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import '../../../constant/call_back_function.dart';
import '../../../constant/enum/task_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../models/http/parameter/task_info_data.dart';
import '../../../utils/number_format_util.dart';
import '../../../views/main_page.dart';
import '../../../views/personal/team/team_order_page.dart';
import '../../app_bottom_navigation_bar.dart';
import '../flex_two_text_widget.dart';

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
          color: status == TaskStatus.unTaken
              ? AppColors.mainThemeButton
              : AppColors.bolderGrey,
          borderLine: 2),
      child: Container(
          margin: const EdgeInsets.all(15),
          height: UIDefine.fontSize20 * 6.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Image.asset(
                        getImagePath(status, index),
                        height: UIDefine.fontSize20 * 4,
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(width: 5),
                      Flexible(child: _buildTaskInfo(context, status, code))
                    ])),
                Text('${tr('mis_award')} : ${data.point} ${tr('point')}',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: UIDefine.fontSize14,
                        color: AppColors.dialogGrey,
                        fontWeight: FontWeight.w500))
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
              child: ActionButtonWidget(
                  isFillWidth: false,
                  isBorderStyle: true,
                  btnText: btnText,
                  onPressed: onPress));
        }
      case TaskStatus.unTaken:
        {
          return ActionButtonWidget(
              isFillWidth: false,
              btnText: tr('acceptReward'),
              onPressed: () {
                getPoint(data.recordNo!, data.point);
              });
        }
      case TaskStatus.isTaken:
        {
          return ActionButtonWidget(
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
        strStatus = 'finish';
        break;
      case TaskStatus.isTaken:
        strStatus = 'focus';
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
    return SizedBox(
        width: UIDefine.getWidth(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: FlexTwoTextWidget(
                      alignment: Alignment.topLeft,
                      text: data.getDailyTaskText(),
                      fontSize: 16,
                      color: AppColors.dialogBlack,
                      fontWeight: FontWeight.w600),
                ),
                _buildButton(context, status, code),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: FlexTwoTextWidget(
                alignment: Alignment.topLeft,
                fontSize: 14,
                text: data.getDailyTaskSubText(),
                color: AppColors.dialogGrey,
                fontWeight: FontWeight.w600),
          )
        ]));
  }
}
