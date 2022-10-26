import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/enum/task_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_style.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/task_info_data.dart';
import '../../../utils/number_format_util.dart';
import '../../../views/personal/level/achievement/achievement_achieve_finish_page.dart';
import '../../button/action_button_widget.dart';
import '../custom_linear_progress.dart';
import '../flex_two_text_widget.dart';

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
          color: status == TaskStatus.unTaken
              ? AppColors.mainThemeButton
              : AppColors.bolderGrey,
          borderLine: 2),
      child: Container(
          margin: const EdgeInsets.all(15),
          height: UIDefine.fontSize20 * 8,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///MARK: 任務內容
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Image.asset(
                    getImagePath(status, index),
                    height: UIDefine.fontSize20 * 4,
                    fit: BoxFit.fitHeight,
                  ),
                  const SizedBox(width: 5),
                  Flexible(child: _buildTaskInfo(context, status, code))
                ]),
                FlexTwoTextWidget(
                    alignment: Alignment.topLeft,
                    fontSize: 14,
                    text: data.getAchievementCurrentTaskSubText(code),
                    color: AppColors.dialogGrey,
                    fontWeight: FontWeight.w500),
                CustomLinearProgress(
                    height: UIDefine.fontSize12,
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
    return SizedBox(
        width: UIDefine.getWidth(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Flexible(
                child: FlexTwoTextWidget(
                    alignment: Alignment.topLeft,
                    text: data.getAchievementTaskText(),
                    fontSize: 16,
                    color: AppColors.dialogBlack,
                    fontWeight: FontWeight.w600),
              ),
              _buildButton(context, status, code),
            ],
          ),
          const SizedBox(height: 5),
          FlexTwoTextWidget(
              alignment: Alignment.topLeft,
              fontSize: 14,
              text: data.getAchievementGoalTaskSubText(code),
              color: AppColors.dialogGrey,
              fontWeight: FontWeight.w600)
        ]));
  }

  Widget _buildButton(
      BuildContext context, TaskStatus status, AchievementCode code) {
    bool enable = (status == TaskStatus.unTaken);
    return ActionButtonWidget(
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
