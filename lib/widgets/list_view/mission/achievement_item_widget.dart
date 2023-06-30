import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/text_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/custom_linear_progress.dart';
import 'package:treasure_nft_project/widgets/label/warp_two_text_widget.dart';

class AchievementItemWidget extends StatelessWidget {
  const AchievementItemWidget(
      {Key? key, required this.data, required this.getPoint})
      : super(key: key);
  final TaskInfoData data;
  final GetAchievementMissionPoint getPoint;

  @override
  Widget build(BuildContext context) {
    ///MARK: 取得值
    TaskStatus status = data.getTaskStatus();
    int index = data.getAchievementCodeIndex();
    AchievementCode code = AchievementCode.values[index];

    ///MARK:建立畫面
    return Container(
      color: Colors.white,
      child: Container(
          margin: EdgeInsets.symmetric(
              vertical: UIDefine.getPixelHeight(15),
              horizontal: UIDefine.getPixelHeight(15)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///MARK: 任務內容
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: UIDefine.getPixelWidth(50),
                          width: UIDefine.getPixelWidth(50),
                          child: Image.asset(
                            getImagePath(status, code),
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
                /// 累計文字
                Padding(
                  padding: EdgeInsets.only(
                      top: UIDefine.getPixelHeight(10),
                      left: UIDefine.getPixelHeight(4),
                      right: UIDefine.getPixelHeight(4)),
                  child: WarpTwoTextWidget(
                      fontSize: UIDefine.fontSize12,
                      text: data.nowValue >= data.goalValue
                          ? tr("Done")
                          : data.getAchievementCurrentTaskSubText(code),
                      color: AppColors.textNineBlack),
                ),
                /// 累計進度條
                Padding(
                  padding: EdgeInsets.only(
                      top: UIDefine.getPixelHeight(5),
                      left: UIDefine.getPixelHeight(4),
                      right: UIDefine.getPixelHeight(4)),
                  child: CustomLinearProgress(
                      percentage: data.nowValue / data.goalValue,
                      needShowPercentage: false),
                ),
              ])),
    );
  }

  String getImagePath(TaskStatus status, AchievementCode code) {
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
    int index;
    switch (code) {
      case AchievementCode.AchSignIn:
        index = 1;
        break;
      case AchievementCode.AchContSignIn:
      case AchievementCode.AchRsvScs:
      case AchievementCode.AchBuyScs:
        index = 2;
        break;
      case AchievementCode.AchSlfBuyAmt:
        index = 3;
        break;
      case AchievementCode.AchTeamBuyFreq:
        index = 4;
        break;
      case AchievementCode.AchTeamBuyAmt:
        index = 5;
        break;
      case AchievementCode.AchInvClsA:
        index = 6;
        break;
      case AchievementCode.AchInvClsBC:
        index = 7;
        break;
    }

    return format(AppImagePath.achievementPath, {
      'index': NumberFormatUtil().integerTwoFormat(index),
      'strStatus': strStatus
    });
  }

  Widget _buildTaskInfo(
      BuildContext context, TaskStatus status, AchievementCode code) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: WarpTwoTextWidget(
                  text: data.getAchievementTaskText(),
                  fontSize: UIDefine.fontSize14,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w600),
            ),
            Container(
                alignment: Alignment.topCenter,
                child: _buildButton(context, status, code)),
          ]),
      const SizedBox(height: 5),
      WarpTwoTextWidget(
          fontSize: UIDefine.fontSize12,
          text: data.getAchievementGoalTaskSubText(code),
          color: AppColors.textNineBlack)
    ]);
  }

  Widget _buildButton(
      BuildContext context, TaskStatus status, AchievementCode code) {
    bool enable = (status == TaskStatus.unTaken);
    String btnText = '+ ${data.point} ${tr('acv_point')}';
    return enable
        ? LoginButtonWidget(
            radius: 15,
            fontSize: UIDefine.fontSize14,
            fontWeight: FontWeight.w600,
            isFillWidth: false,
            isAutoHeight: true,
            padding: EdgeInsets.symmetric(
                horizontal: UIDefine.getPixelWidth(15),
                vertical: UIDefine.getPixelWidth(5)),
            btnText: btnText,
            onPressed: () {
              if (enable) {
                getPoint(code, data.recordNo!, data.point);
              }
            })
        : TextButtonWidget(
            radius: 15,
            fontSize: UIDefine.fontSize14,
            fontWeight: FontWeight.w600,
            isFillWidth: false,
            setMainColor: AppColors.dailyAcceptedReward,
            setSubColor: Colors.white,
            backgroundHorizontal: UIDefine.getPixelWidth(15),
            btnText: btnText,
            onPressed: () {
              if (enable) {
                getPoint(code, data.recordNo!, data.point);
              }
            });
  }
}
