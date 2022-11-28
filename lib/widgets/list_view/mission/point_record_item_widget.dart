import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/point_record_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

class PointRecordItemWidget extends StatelessWidget {
  const PointRecordItemWidget({Key? key, required this.record})
      : super(key: key);
  final PointRecordData record;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: UIDefine.getPixelHeight(5),
            horizontal: UIDefine.getPixelWidth(20)),
        decoration: AppStyle().styleColorBorderBackground(
            color: AppColors.bolderGrey, borderLine: 2, radius: 8),
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: UIDefine.getPixelWidth(15),
                vertical: UIDefine.getPixelHeight(10)),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Image.asset(
                record.getImagePath(),
                height: UIDefine.getPixelHeight(80),
                fit: BoxFit.fitHeight,
              ),
              SizedBox(width: UIDefine.getPixelWidth(10)),
              Expanded(child: _buildRecordInfo())
            ])));
  }

  Widget _buildRecordInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(record.getTitle(),
            style: TextStyle(
                color: AppColors.dialogBlack,
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w600)),
        SizedBox(height: UIDefine.getPixelHeight(5)),
        Text(BaseViewModel().changeTimeZone(record.time),
            style: TextStyle(
                color: AppColors.searchBar,
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w500)),
        Text('${tr('type')} : ${record.getStringType()}',
            style: TextStyle(
                color: AppColors.dialogGrey,
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w500)),
        Text('${tr('lv_point')} : ${record.getStringPoint()}',
            style: TextStyle(
                color: AppColors.dialogGrey,
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}
