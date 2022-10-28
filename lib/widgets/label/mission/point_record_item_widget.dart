import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';

import '../../../constant/enum/task_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_style.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/point_record_data.dart';
import '../../../utils/number_format_util.dart';

class PointRecordItemWidget extends StatelessWidget {
  const PointRecordItemWidget({Key? key, required this.record})
      : super(key: key);
  final PointRecordData record;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: AppStyle().styleColorBorderBackground(
            color: AppColors.bolderGrey, borderLine: 2),
        child: Container(
            margin: const EdgeInsets.all(15),
            child: SizedBox(
              width: UIDefine.getWidth(),
              height: UIDefine.fontSize20 * 5,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Image.asset(
                  record.getImagePath(),
                  height: UIDefine.fontSize20 * 4,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(width: 5),
                Flexible(child: _buildRecordInfo())
              ]),
            )));
  }

  Widget _buildRecordInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(record.getTitle(),
            style: TextStyle(
                color: AppColors.dialogBlack,
                fontSize: UIDefine.fontSize16,
                fontWeight: FontWeight.w600)),
        Text(DateFormatUtil().getFullWithDateFormat2(record.time),
            style: TextStyle(
                color: AppColors.searchBar,
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w500)),
        Text('${tr('type')} : ${record.getStringType()}',
            style: TextStyle(
                color: AppColors.dialogGrey,
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w500)),
        Text('${tr('lv_point')} : ${record.getStringPoint()}',
            style: TextStyle(
                color: AppColors.dialogGrey,
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}
