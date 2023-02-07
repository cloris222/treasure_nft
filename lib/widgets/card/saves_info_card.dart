import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/check_earning_income.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

class SavesInfoCard extends StatelessWidget {
  const SavesInfoCard({Key? key, required this.data}) : super(key: key);
  final CheckEarningIncomeData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UIDefine.getScreenWidth(4.4)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bolderGrey, width: 2.5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 5),
          Text(
            BaseViewModel().changeTimeZone(data.time),
            style: AppTextStyle.getBaseStyle(
                color: AppColors.searchBar,
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          _buildAmount()
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Image.asset(AppImagePath.walletLogIcon,
            height: UIDefine.getPixelHeight(23), fit: BoxFit.fitHeight),
        SizedBox(width: UIDefine.getPixelWidth(5)),
        Text(
            data.saveType == "LEVEL_UP_ADD"
                ? tr('bonus_referral')
                : tr('bonus_trade'),
            style: AppTextStyle.getBaseStyle(
                color: AppColors.textBlack,
                fontSize: UIDefine.fontSize20,
                fontWeight: FontWeight.w500))
      ],
    );
  }

  Widget _buildAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tr('mintAmount'), // 在外部要塞多語系的key
          style: AppTextStyle.getBaseStyle(
              color: AppColors.dialogGrey,
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          '+${NumberFormatUtil().removeTwoPointFormat(data.saveAmount)}',
          style: AppTextStyle.getBaseStyle(
              color: AppColors.textBlack,
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
