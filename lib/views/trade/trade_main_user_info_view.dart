import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_level_info_provider.dart';
import 'package:treasure_nft_project/view_models/trade/trade_new_main_view_model.dart';

import '../../models/http/parameter/check_reservation_info.dart';
import '../../view_models/trade/provider/trade_reserve_info_provider.dart';

class TradeMainUserInfoView extends ConsumerWidget {
  const TradeMainUserInfoView({Key? key, required this.viewModel})
      : super(key: key);
  final TradeNewMainViewModel viewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildTradeInfo(ref);
  }

  Widget _buildTradeInfo(WidgetRef ref) {
    CheckReservationInfo? reserveInfo = ref.watch(tradeReserveInfoProvider);
    num balance = reserveInfo?.getBalance() ?? 0;
    num reserveBalance = reserveInfo?.getReserveBalance() ?? 0;
    return Row(
      children: [
        _buildInfoItem(
          title: tr('amountRangeNFT'),
          content: viewModel.getRange(ref.watch(userLevelInfoProvider)),
        ),
        SizedBox(width: UIDefine.getPixelWidth(8)),
        _buildInfoItem(
          title: tr("wallet-balance'"),
          content: NumberFormatUtil().removeTwoPointFormat(balance),
        ),
        SizedBox(width: UIDefine.getPixelWidth(8)),
        _buildInfoItem(
          title: tr("availableBalance"),
          content: NumberFormatUtil().removeTwoPointFormat(reserveBalance),
        ),
      ],
    );
  }

  Widget _buildInfoItem({required String title, required String content}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
        decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(title,
                maxLines: 2,
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.dialogGrey,
                    fontSize: UIDefine.fontSize14,
                    fontWeight: FontWeight.w400)),
            Text(content,
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textBlack,
                    fontSize: UIDefine.fontSize18,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
