import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/point_record_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

class PointRecordItemWidget extends StatelessWidget {
  const PointRecordItemWidget({Key? key, required this.record})
      : super(key: key);
  final PointRecordData record;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: UIDefine.getPixelHeight(5)),
        child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset(
            record.getImagePath(),
            height: UIDefine.getPixelHeight(50),
            fit: BoxFit.fitHeight,
          ),
          SizedBox(width: UIDefine.getPixelWidth(10)),
          Expanded(child: _buildRecordInfo())
        ]));
  }

  Widget _buildRecordInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(record.getTitle(),
            style: AppTextStyle.getBaseStyle(
                color: AppColors.textBlack,
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w600)),
        SizedBox(height: UIDefine.getPixelHeight(5)),
        Text(BaseViewModel().changeTimeZone(record.time),
            style: AppTextStyle.getBaseStyle(
                color: AppColors.textNineBlack,
                fontSize: UIDefine.fontSize12)),
        Text('${tr('type')} : ${record.getStringType()}',
            style: AppTextStyle.getBaseStyle(
                color: AppColors.textNineBlack,
                fontSize: UIDefine.fontSize12)),
        Text('${tr('lv_point')} : ${record.getStringPoint()}',
            style: AppTextStyle.getBaseStyle(
                color: AppColors.textNineBlack,
                fontSize: UIDefine.fontSize12)),
      ],
    );
  }
}
