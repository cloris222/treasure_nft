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
      decoration: AppStyle().styleColorBorderBackground(
          radius: 8,
          color: status == TaskStatus.unTaken
              ? AppColors.mainThemeButton
              : AppColors.bolderGrey,
          borderLine: 2),
      child: Container(
          margin: EdgeInsets.symmetric(
              vertical: UIDefine.getPixelWidth(15),
              horizontal: UIDefine.getPixelWidth(15)),
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
                      Image.asset(
                        getImagePath(status, index),
                        height: UIDefine.getPixelHeight(80),
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(width: 5),
                      Expanded(child: _buildTaskInfo(context, status, code))
                    ]),
                SizedBox(height: UIDefine.getPixelHeight(10)),
                WarpTwoTextWidget(
                    fontSize: UIDefine.fontSize14,
                    text: data.getAchievementCurrentTaskSubText(code),
                    color: AppColors.dialogGrey,
                    fontWeight: FontWeight.w500),
                SizedBox(height: UIDefine.getPixelHeight(5)),
                CustomLinearProgress(
                    percentage: data.nowValue / data.goalValue,
                    needShowPercentage: true),
              ])),
    );
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
        '${AppImagePath.achievementMission}/ma_{index}_01_{strStatus}.png', {
      'index': NumberFormatUtil().integerTwoFormat(index + 1),
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
                  fontSize: UIDefine.fontSize16,
                  color: AppColors.dialogBlack,
                  fontWeight: FontWeight.w600),
            ),
            Container(
                alignment: Alignment.topCenter,
                child: _buildButton(context, status, code)),
          ]),
      const SizedBox(height: 5),
      WarpTwoTextWidget(
          fontSize: UIDefine.fontSize14,
          text: data.getAchievementGoalTaskSubText(code),
          color: AppColors.dialogGrey,
          fontWeight: FontWeight.w400)
    ]);
  }

  Widget _buildButton(
      BuildContext context, TaskStatus status, AchievementCode code) {
    bool enable = (status == TaskStatus.unTaken);
    return TextButtonWidget(
        fontSize: UIDefine.fontSize12,
        setMainColor:
            enable ? AppColors.mainThemeButton : AppColors.datePickerBorder,
        setSubColor: enable ? AppColors.textWhite : AppColors.dialogGrey,
        isFillWidth: false,
        btnText: '+ ${data.point} ${tr('acv_point')}',
        onPressed: () {
          if (enable) {
            getPoint(code, data.recordNo!, data.point);
          }
        });
  }
}
